pipeline {

  environment {
    registry = "chetangautamm/repo"
    registryCredential = 'dockerhub' 
    dockerImage = ""

    K8S_ADDRESS = "16.171.144.121"
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
          sh "scp -o StrictHostKeyChecking=no -q opensips.yaml ubuntu@$K8S_ADDRESS:/home/ubuntu"
          script {
            try {
              sh "ssh ubuntu@$K8S_ADDRESS kubectl apply -f opensips.yaml --context kind-kind"
            }catch(error){
              sh "ssh ubuntu@$K8S_ADDRESS kubectl apply -f opensips.yaml --context kind-kind"
            } 
          }
        }              
      }
    }
       stage('Deploy User Agent Server(UAS)') {
      steps {
        sshagent(['kindk8s']) {
          sh "scp -o StrictHostKeyChecking=no -q uas.yaml ubuntu@$K8S_ADDRESS:/home/ubuntu"
          script {
            try {
              sh "ssh ubuntu@$K8S_ADDRESS kubectl apply -f uas.yaml --context kind-kind"
            }catch(error){
              sh "ssh ubuntu@$K8S_ADDRESS kubectl apply -f uas.yaml --context kind-kind"
            } 
          }
        }              
      }
    }
       stage('Deploy User Agent Client(UAC)') {
      steps {
        sshagent(['kindk8s']) {
          sh "scp -o StrictHostKeyChecking=no -q uac.yaml ubuntu@$K8S_ADDRESS:/home/ubuntu"
          script {
            try {
              sh "ssh ubuntu@$K8S_ADDRESS kubectl apply -f uac.yaml --context kind-kind"
            }catch(error){
              sh "ssh ubuntu@$K8S_ADDRESS kubectl apply -f uac.yaml --context kind-kind"
            } 
          }
        }              
      }
    }
       stage('Running Call using Opensips Server , UAS & UAC') {
      steps {
        sleep 300
        sh "chmod +x configure.sh"
        sshagent(['kindk8s']) {
          sh "scp -o StrictHostKeyChecking=no -q configure.sh ubuntu@$K8S_ADDRESS:/home/ubuntu"
          script {
            sh "ssh ubuntu@$K8S_ADDRESS ./configure.sh"
          }
        }              
      }
    }
  }
}
