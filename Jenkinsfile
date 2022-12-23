node{
    stage("Code checkout"){
        git url: "https://github.com/bhuvi-12/railsproject.git"
    }
    stage("Build the project to docker image"){
        echo("Building the project")
        docker.withRegistry('https://hub.docker.com', 'docker-login'){
            def builtImage = docker.build("rails-default-page:${currentBuild.number}")
            builtImage.push()
        }
    }
}
