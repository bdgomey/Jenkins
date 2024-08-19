pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/bdgomey/jenkins.git']]])
            }
        }
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
                script {
                    try {
                        withAWS(region: 'us-east-1', credentials: 'AWS_CREDENTIALS') {
                            sh 'ls'
                            curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                            sh 'unzip awscliv2.zip'
                            sh './aws/install'
                            sh 'aws s3 sync frontend/dist s3://bjgomes-bucket-sdet'
                        }
                    } catch (Exception e) {
                        echo "Failed to deploy frontend, error: ${e}"
                        throw e
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
                script {
                    try {
                        sh 'echo "Building Backend..."'
                        sh 'mvn clean install'
                    } catch (Exception e) {
                        echo "Failed to build backend, error: ${e}"
                        throw e
                    }
                }
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
                script {
                    try {
                        sh 'echo "Running Tests..."'
                        sh 'mvn test'
                    } catch (Exception e) {
                        echo "Failed to run tests, error: ${e}"
                        throw e
                    }
                }
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
                script {
                    try {
                        withAWS(region: 'us-east-1', credentials: 'AWS_CREDENTIALS') {
                            sh 'aws s3 sync target s3://bjgomes-bucket-sdet-backend'
                        }
                    } catch (Exception e) {
                        echo "Failed to deploy backend, error: ${e}"
                        throw e
                    }
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