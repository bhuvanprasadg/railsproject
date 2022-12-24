node{
    def GITHUB_PROJECT_URL = "https://github.com/bhuvi-12/railsproject.git"
    def GITHUB_CREDENTIALS = "git-credentials-token"
    def AWS_ACCOUNT_ID = "088578890509"
    def AWS_REGION = "ap-south-1"
    def AWS_JENKINS_CREDENTIALS_ID = "aws-ecr-credentials"
    def AWS_ECR_IMAGE = "railsapp"
    def AWS_EKS_CLUSTER_NAME = "railsapp"
    def EKS_NAMESPACE = "railsapp"
    def DEPLOYMENT_FILE = "deployment.yaml"
    
    stage("Code checkout"){
        git branch: "main", url: "${GITHUB_PROJECT_URL}", credentialsId: "${GITHUB_CREDENTIALS}"
    }
    stage("Build the project to docker image & Push to ECR"){
        docker.withRegistry(
            "https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com",
            "ecr:${AWS_REGION}:${AWS_JENKINS_CREDENTIALS_ID}") {
            def dockerImage = docker.build("${AWS_ECR_IMAGE}:latest")
            dockerImage.push()
        }
    }
    stage("Kubernetes Deployment"){
        withAWS(credentials: "${AWS_JENKINS_CREDENTIALS_ID}", region: "${AWS_REGION}") {
            sh "aws eks update-kubeconfig --region ${AWS_REGION} --name ${AWS_EKS_CLUSTER_NAME}"
            sh "kubectl apply -f ${DEPLOYMENT_FILE} -n ${EKS_NAMESPACE}"
        }
    }
}
