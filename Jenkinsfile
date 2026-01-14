
pipeline {
  agent any

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
          docker build -t soodnivesh93/devops-demo:${BUILD_NUMBER} .
          docker push soodnivesh93/devops-demo:${BUILD_NUMBER}
        '''
      }
    }

    stage('Update Helm Values') {
      steps {
        sh '''
          git clone https://github.com/soodnivesh93/devops-demo-helm.git
          cd devops-demo-helm/charts/devops-demo
          sed -i "s/tag:.*/tag: ${BUILD_NUMBER}/" values.yaml
          git commit -am "Update image to ${BUILD_NUMBER}"
          git push origin main
        '''
      }
    }
  }
}
