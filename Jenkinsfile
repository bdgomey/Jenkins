pipeline {
    agent none

    stages {
        stage('Build Frontend') {
            agent {
                docker {
                    image 'node:22-alpine3.19'
                    args '--network jenkins -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'echo "Building Frontend..."'
                sh 'cd frontend && npm install && npm run build'
            }
        }
        stage('Deploy Frontend') {
            agent {
                docker {
                    image 'amazon/aws-cli'
                    args '--network jenkins -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                    sh 'aws s3 sync frontend/dist s3://bjgomes-bucket-sdet'
                }
            }
        }
        stage('Build Backend') {
            agent {
                docker {
                    image 'maven:3.6.3-openjdk-17'
                    args '--network jenkins -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'echo "Building Backend..."'
                sh 'mvn clean install'
            }
        }
        stage('Test Backend') {
            agent {
                docker {
                    image 'maven:3.6.3-openjdk-17'
                    args '--network jenkins -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'echo "Running Tests..."'
                sh 'mvn test'
            }
        }
        stage('Deploy Backend') {
            agent {
                docker {
                    image 'amazon/aws-cli'
                    args '--network jenkins -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                    sh 'aws s3 sync target s3://bjgomes-bucket-sdet-backend'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed'
        }
        success {
            echo 'Pipeline succeeded'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}