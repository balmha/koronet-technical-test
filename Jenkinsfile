pipeline {
    // This code uses the next Docker Pipeline plugin: https://plugins.jenkins.io/docker-workflow/
    agent any

    environment {
        DOCKER_IMAGE = 'docker-repository/image-name'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials-id'
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-credentials-id'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def imageTag = "${env.BUILD_NUMBER}" // Use build number as image tag
                    docker.build("${DOCKER_IMAGE}:${imageTag}")
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    def imageTag = "${env.BUILD_NUMBER}"
                    docker.image("${DOCKER_IMAGE}:${imageTag}").inside {
                        sh 'npm test'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    def imageTag = "${env.BUILD_NUMBER}"
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image("${DOCKER_IMAGE}:${imageTag}").push()
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG')]) {
                        sh 'kubectl config use-context my-cluster'  // Ensure the right context
                        sh 'kubectl apply -f k8s/deployment.yaml'
                        sh 'kubectl apply -f k8s/service.yaml'
                    }
                }
            }
        }
    }

    post {
        cleanup {
            cleanWs()  // Clean workspace after the pipeline
        }
    }
}
