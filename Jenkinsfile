pipeline {
    agent any 
    
    environment { 
        DOCKER_IMAGE_NAME = 'xyzz84066/java-hello'
	DOCKER_IMAGE_TAG = '1.0' 
    } 
    
    stages { 
        stage('Docker Build') { 
            steps { 
                sh "docker build -t ${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG} ." 
            } 
        } 
        
	stage('Push to dockerhub') {
		steps {
		  withCredentials([usernamePassword(credentialsId: 'docker-hub-id',
						   usernameVariable: 'DOCKER_USERNAME',
						   passwordVariable: 'DOCKER_PASSWORD')]){
			sh """
			echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
			docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
			"""
			}
		}
	}
	stage('Deploy to k8s'){
		steps{
		  sh "minikube kubectl -- apply -f deployment.yaml"
		  sh "minikube kubectl -- apply -f service.yaml"
		}
	} 
    } 
    
    post { 
        success { 
            echo 'Java image built successfully!' 
        } 
        failure { 
            echo 'An error occurred while building/running the image' 
        } 
    } 
}	
