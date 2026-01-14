pipeline {
    agent any

    environment {
        IMAGE_NAME = "devops-demo-app"
        CONTAINER_NAME = "devops-demo-container"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out code'
            }
        }

        stage('Build') {
            steps {
                echo 'Building application'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests'
                sh '''
                  echo "Simulated test passed"
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Deploy (Run Container)') {
            steps {
                sh '''
                  docker rm -f $CONTAINER_NAME || true
                  docker run -d --name $CONTAINER_NAME $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo 'FULL CI/CD PIPELINE SUCCESSFUL 🎉'
        }
        failure {
            echo 'PIPELINE FAILED ❌'
        }
    }
}
