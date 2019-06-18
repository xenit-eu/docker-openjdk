pipeline {
    agent any

    stages {
        stage("Build Docker Images") {
            steps {
                sh "./gradlew buildDockerImage"
            }
        }

        stage("Testing") {
            steps {
                sh "./gradlew check --info"
            }
            post {
                always {
                    sh "./gradlew composeDownAll"
                }
            }
        }

        stage("Publish Docker Image") {
            when {
                anyOf {
                    branch 'master'
                    branch 'release*'
                }
            }
            steps {
                sh "./gradlew pushDockerImage"
            }
        }
    }
}