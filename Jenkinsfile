pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'echo "Building..."'
                sh 'mvn clean install' // Example build command for a Maven project
            }
        }
        stage('Test') {
            steps {
                sh 'echo "Running Tests..."'
                sh 'mvn test' // Example test command for a Maven project
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
