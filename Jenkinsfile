pipeline {
    agent any


    stages {
        stage('Build Frontend') {
            steps {
                echo 'Building Frontend'
                sh 'cd frontend && npm install && npm run build'
                }
            }
        stage('Deploy Frontend') {
            steps {
                echo 'Deploying Frontend'
                withAWS(region: 'us-east-1', credentials: 'AWS_CREDENTIALS') {
                    sh 'ls'
                    sh 'aws s3 sync frontend/dist s3://bjgomes-bucket-sdet'
                }
            }
        }
        stage('Build Backend') {
            steps {
                sh 'echo "Building..."'
                sh 'ls'
                sh 'mvn clean install' // Example build command for a Maven project
            }
        }
        stage('Test Backend') {
            steps {
                sh 'echo "Running Tests..."'
                sh 'mvn test' // Example test command for a Maven project
            }
        }
        stage('Deploy Backend') {
            steps {
                sh 'echo "Deploying..."'
                // Add deployment commands here
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
