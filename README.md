# Automated CI/CD Pipeline  Jenkins, AWS, Kubernetes, Docker
	This project is about continuous integration /Continuous deployment of application in the production environment. So in this project we have deployed Docker engine on Ubuntu Virtual Machine on AWS.
	After deploying Docker, Jenkins server is deployed on a container which accessible on port 8080.
	Then on another AWS EC2 instance Kubernates cluster is deployed type of Kubernates cluster used in KIND cluster.
	After deploying all the pre-requisites Jenkins file is written which contain the code for deployment of opensips and sipp application. This files contains deployment , verification and testing stages of the application.
	The Github repo also contains Yaml files for app deployment.
	Then a pipeline is created on Jenkins the Github repo and the pipeline is executed and the apps are deployed on Kunernetes cluster.
	And Kubernetes cluster is also connected to the Jenkins Server. 
	Explored about MLOps and how it can be integrated with the CI/CD Jenkins pipeline.

Tools Used:
1.Jenkins
2.Kubernetes(KIND cluster) 
3.Github
4.AWS (Amazon Web Services)
5.Dockerhub
6.Docker Container
7.Opensips Server Image
8.Sipp client Image
9.Sipp Server Image
10.Ubuntu

Links
https://hub.docker.com/r/chetangautamm/repo/tags
            docker pull chetangautamm/repo:Opensips_Build
            docker pull chetangautamm/repo:sipp.v3
https://aws.amazon.com/console/
https://kind.sigs.k8s.io/docs/user/quick-start/
https://docs.docker.com/engine/install/ubuntu/
https://www.jenkins.io/doc/book/installing/docker/
