pipeline {
    agent any

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

