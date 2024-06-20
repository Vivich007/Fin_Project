pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'project-1', url: 'https://github.com/Vivich007/fin_project.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("web-calculator")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    dockerImage.run('-p 7080:8080')
                }
            }
        }
    }
}
