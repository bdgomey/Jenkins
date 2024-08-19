pipeline {
    agent any
// if i wanted to use credentials i would use the following

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }
    stages {
        stage('Build Frontend') {
            steps {
                echo 'Building Frontend'
                sh 'cd frontend && npm install && npm run build'
                }
            }
        }
        stage('Deploy Frontend') {
            steps {
                echo 'Deploying Frontend'
                sh 'aws s3 sync frontend/build s3://my-bucket-name'
            }
        }
        stage('Build Backend') {
            steps {
                sh 'echo "Building..."'
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
