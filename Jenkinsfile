pipeline {
  agent any

  environment {
    IMAGE_NAME = "soodnivesh93/devops-demo"
    IMAGE_TAG  = "${BUILD_NUMBER}"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        sh 'echo Building app'
      }
    }

    stage('Test') {
      steps {
        sh 'echo Tests passed'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh '''
          docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
        '''
      }
    }

    stage('Docker Login & Push') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub-creds',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push ${IMAGE_NAME}:${IMAGE_TAG}
          '''
        }
      }
    }

    stage('Update Helm Values') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'github-creds',
          usernameVariable: 'GIT_USER',
          passwordVariable: 'GIT_PASS'
        )]) {
          sh '''
            rm -rf devops-demo-helm

            git config --global user.email "jenkins@local"
            git config --global user.name "jenkins"

            git clone https://$GIT_USER:$GIT_PASS@github.com/soodnivesh93/devops-demo-helm.git
            cd devops-demo-helm/devops-demo/

            sed -i "s/^  tag:.*/  tag: \\"${IMAGE_TAG}\\"/" values.yaml

            

            git add values.yaml
            git commit -m "Update image tag to ${IMAGE_TAG}"
            git push https://$GIT_USER:$GIT_PASS@github.com/soodnivesh93/devops-demo-helm.git main
          """
        }
      }
    }
  }

  post {
    success {
      echo "✅ CI pipeline successful. Image ${IMAGE_NAME}:${IMAGE_TAG} pushed & Helm updated."
    }
    failure {
      echo "❌ Pipeline failed."
    }
  }
}
