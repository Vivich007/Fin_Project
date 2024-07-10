pipeline {
    agent any

    environment {
        // Set environment variables for kubectl
        KUBECONFIG = credentials('kubeconfig') // Assume 'kubeconfig' is the ID of the Jenkins credential containing your kubeconfig
    }

    stages {
        stage('Clone repository') {
            steps {
                // Clone your repository containing the deployment and service YAML files
                git branch: 'project-3', url: 'https://github.com/Vivich007/fin_project.git'
            }
        }

        stage('Apply Kubernetes Manifests') {
            steps {
                script {
                    // Apply deployment.yaml
                    sh 'kubectl apply -f deployment.yaml'
                    
                    // Apply service.yaml
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
        
        stage('Get Kubernetes Services') {
            steps {
                script {
                    // Get the list of services
                    sh 'kubectl get services'
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

