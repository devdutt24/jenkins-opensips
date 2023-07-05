pipeline {

  environment {
    registry = "chetangautamm/repo"
    registryCredential = 'dockerhub' 
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/devdutt24/jenkins-opensips.git'
      }
    }
    
    
    stage('Deploy APP') {
      steps {
        sh "chmod +x configure.sh"
        sshagent(['kindk8s']) {
          sh "scp -o StrictHostKeyChecking=no -q opensips.yaml ubuntu@16.171.139.4:/home/ubuntu"
          sh "scp -o StrictHostKeyChecking=no -q configure.sh ubuntu@16.171.139.4:/home/ubuntu"
          script {
            try {
              sh "ssh ubuntu@16.171.139.4 kubectl apply -f opensips.yaml"
            }catch(error){
              sh "ssh ubuntu@16.171.139.4 kubectl apply -f opensips.yaml"
            } 
            sh "ssh ubuntu@16.171.139.4 ./configure.sh"
          }
        }              
      }
    }
  }
}
