pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/bdgomey/jenkins.git'
            }
        }
        stage('Build') {
            steps {
                sh 'echo "Building..."'
                sh 'echo "mvn clean install"' // Example build command for a Maven project
            }
        }
        stage('Test') {
            steps {
                sh 'echo "Running Tests..."'
                sh 'echo "mvn test"' // Example test command for a Maven project
            }
        }
        stage('Deploy') {
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
