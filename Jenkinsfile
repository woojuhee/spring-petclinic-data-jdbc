pipeline {
  agent any

    stages {
        stage('Prepare Environment') {
            steps {
                script {
                    // Docker CLI 설치 및 설정
                    sh 'apk add docker'
                    sh 'docker --version' // Docker 설치 확인
                    sh 'apk add curl' // 필요한 경우 curl을 설치할 수도 있습니다.
                    sh 'curl -fsSL https://get.docker.com/rootless | sh' // 필요한 경우 rootless Docker 설치
                    sh 'export DOCKER_HOST=unix:///var/run/docker.sock' // Docker 소켓 설정
                }
            }
        }
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Git describe 명령어를 사용하여 태그 생성
                    def gitTag = sh(script: 'git describe', returnStdout: true).trim()

                    // Docker 이미지 빌드
                    sh "docker build -t docker.io/gitops/spring-petclinic-data-jdbc-maven:${gitTag} ."
                }
            }
        }
        
        stage('Push') {
            steps {
                script {
                    // Docker 이미지 푸시
                    sh "docker push docker.io/gitops/spring-petclinic-data-jdbc-maven:${gitTag}"
                }
            }
        }
    }

    post {
        always {
            // 작업 공간 정리
            cleanWs()
        }
    }
}

