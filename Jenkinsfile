node{
    def GITHUB_PROJECT_URL = "https://github.com/bhuvi-12/railsproject.git"
    def GITHUB_CREDENTIALS = "git-credentials-token"
    def AWS_ACCOUNT_ID = "088578890509"
    def AWS_REGION = "ap-south-1"
    def AWS_JENKINS_CREDENTIALS_ID = "aws-ecr-credentials"
    def AWS_JENKINS_CREDENTIALS_ID_EKS = "aws-ecr-eks-credentials"
    def AWS_ECR_IMAGE = "railsapp"
    def AWS_EKS_CLUSTER_NAME = "cluster-eks"
    def EKS_NAMESPACE = "railsapp"
    def EKS_DEPLOYMENT_FILE = "deployment.yaml"
    def EKS_DEPLOYMENT_NAME = "railswelcomepage"
    def RUNNING_CONTAINER_NAME = "railspagecontainer"
    def BUILD_NUMBER = currentBuild.number
    def IMAGE_VERSION = "v${BUILD_NUMBER}"
    
    stage("Code checkout"){
        git branch: "main", url: "${GITHUB_PROJECT_URL}", credentialsId: "${GITHUB_CREDENTIALS}"
    }
    stage("Build the project to docker image & Push to ECR"){
        docker.withRegistry(
            "https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com",
            "ecr:${AWS_REGION}:${AWS_JENKINS_CREDENTIALS_ID}") {
            def dockerImage = docker.build("${AWS_ECR_IMAGE}:${IMAGE_VERSION}")
            dockerImage.push()
        }
    }
    stage("Kubernetes Deployment"){
        withAWS(credentials: "${AWS_JENKINS_CREDENTIALS_ID}", region: "${AWS_REGION}") {
            sh "aws eks update-kubeconfig --region ${AWS_REGION} --name ${AWS_EKS_CLUSTER_NAME}"
            sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 088578890509.dkr.ecr.ap-south-1.amazonaws.com"
//             sh "kubectl apply -f ${EKS_DEPLOYMENT_FILE} -n ${EKS_NAMESPACE}"
            sh "kubectl set image deployment/${EKS_DEPLOYMENT_NAME} ${RUNNING_CONTAINER_NAME}=${AWS_ECR_IMAGE}:${IMAGE_VERSION} -n ${EKS_NAMESPACE}"
            sh "kubectl rollout status deployment/${EKS_DEPLOYMENT_NAME} -n ${EKS_NAMESPACE}"
        }
    }
}
