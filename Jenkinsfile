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
    
    
    stage('Deploy Oensips Server') {
      steps {
        sshagent(['kindk8s']) {
          sh "scp -o StrictHostKeyChecking=no -q opensips.yaml ubuntu@13.53.42.203:/home/ubuntu"
          script {
            try {
              sh "ssh ubuntu@13.53.42.203 kubectl apply -f opensips.yaml --context kind-kind"
            }catch(error){
              sh "ssh ubuntu@13.53.42.203 kubectl apply -f opensips.yaml --context kind-kind"
            } 
          }
        }              
      }
    }
       stage('Deploy User Agent Server(UAS)') {
      steps {
        sshagent(['kindk8s']) {
          sh "scp -o StrictHostKeyChecking=no -q uas.yaml ubuntu@13.53.42.203:/home/ubuntu"
          script {
            try {
              sh "ssh ubuntu@13.53.42.203 kubectl apply -f uas.yaml --context kind-kind"
            }catch(error){
              sh "ssh ubuntu@13.53.42.203 kubectl apply -f uas.yaml --context kind-kind"
            } 
          }
        }              
      }
    }
       stage('Deploy User Agent Client(UAC)') {
      steps {
        sshagent(['kindk8s']) {
          sh "scp -o StrictHostKeyChecking=no -q uac.yaml ubuntu@13.53.42.203:/home/ubuntu"
          script {
            try {
              sh "ssh ubuntu@13.53.42.203 kubectl apply -f uac.yaml --context kind-kind"
            }catch(error){
              sh "ssh ubuntu@13.53.42.203 kubectl apply -f uac.yaml --context kind-kind"
            } 
          }
        }              
      }
    }
       stage('Running Call using Opensips Server , UAS & UAC') {
      steps {
        sh "chmod +x configure.sh"
        sshagent(['kindk8s']) {
          sh "scp -o StrictHostKeyChecking=no -q configure.sh ubuntu@13.53.42.203:/home/ubuntu"
          script {
            sh "ssh ubuntu@13.53.42.203 ./configure.sh"
          }
        }              
      }
    }
  }
}
