pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'vivich007/web-calculator'
        CONTAINER_NAME = 'web-calc'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'project-1', url: 'https://github.com/Vivich007/fin_project.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build(DOCKER_IMAGE)
                }
            }
        }
        stage('Remove Existing Container') {
            steps {
                script {
                    sh "docker ps -a -q --filter name=${CONTAINER_NAME} | grep -q . && docker rm -f ${CONTAINER_NAME} || echo 'No container to remove'"
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    dockerImage.run("-d -p 7080:8080 --name ${CONTAINER_NAME}")
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline succeeded.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
