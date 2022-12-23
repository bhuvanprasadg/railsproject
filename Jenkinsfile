node{
    agent any
    stage("Code checkout"){
        git url: "https://github.com/bhuvi-12/railsproject.git"
    }

    stage("Build the project to docker image"){
        docker.withRegistry('https://hub.docker.com', 'docker-login'){
            def builtImage = docker.build("rails-default-page:${currentBuild.number}")
            builtImage.push()
        }
    }
}