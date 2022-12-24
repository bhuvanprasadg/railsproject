node{
    stage("Code checkout"){
        git branch: "main", url: "https://github.com/bhuvi-12/railsproject.git"
    }
    stage("Build the project to docker image & Push to ECR"){
        docker.withRegistry(
            'https://088578890509.dkr.ecr.ap-south-1.amazonaws.com',
            'ecr:ap-south-1:aws-ecr-credentials') {
            def dockerImage = docker.build('railsapp:latest')
            dockerImage.push()
        }
    }
}
