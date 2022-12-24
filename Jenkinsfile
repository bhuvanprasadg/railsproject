node{
    def PROJECT_GITHUB_URL = "https://github.com/bhuvi-12/railsproject.git"
    def AWS_ACCOUNT_ID = "088578890509"
    def AWS_REGION = "ap-south-1"
    def AWS_JENKINS_CREDENTIALS = "aws-ecr-credentials"
    def AWS_ECR_IMAGE = "railsapp"
    
    stage("Code checkout"){
        git branch: "main", url: "${PROJECT_GITHUB_URL}"
    }
    stage("Build the project to docker image & Push to ECR"){
        docker.withRegistry(
            "https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com",
            "ecr:${AWS_REGION}:${AWS_JENKINS_CREDENTIALS}") {
            def dockerImage = docker.build("${AWS_ECR_IMAGE}:latest")
            dockerImage.push()
        }
    }
    stage("Kubernetes Deployment"){
        sh "aws eks update-kubeconfig --region ${AWS_REGION} --name railsapp"
        sh "kubectl apply -f deployment.yaml -n railsapp"
    }
}
