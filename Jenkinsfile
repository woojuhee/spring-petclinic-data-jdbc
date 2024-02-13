pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    // Make build
                    sh 'make build'
                }
            }
        }

        stage('Push') {
            when {
                // Only push if build succeeds
                expression { currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    // Push image
                    sh 'make push'
                }
            }
        }
    }

    post {
        always {
            // Clean up
            cleanWs()
        }
    }
}

