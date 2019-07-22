node() {

    currentBuild.result = "SUCCESS"

    try {

        stage('Checkout') {

            checkout scm
        }

        stage('Run Unit Tests') {

            bat "mvn clean test"
        }

        stage('Package the application') {

            bat "mvn package"
        }

        stage('Continue to Build Docker Image') {
            timeout(60) {
                input 'Should i build the docker image ?'
            }
        }


        stage('Build Docker Image') {

            bat "docker build -t docker-api-demo -f Dockerfile ."
        }

    }
    catch (err) {

        currentBuild.result = "FAILURE"
        throw err
    }

}