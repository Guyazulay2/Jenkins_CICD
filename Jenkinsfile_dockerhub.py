pipeline {
    agent any
    }
    stages {
        stage('Build') {
            steps{
                script {
                    try {
                        echo '** Build The Dockerfile **'
                        sh 'cd $HOME & sudo docker build -t webrtccontroller'
                        sh 'sudo docker run -it -d --name webrtc_controller --network="host" webrtccontroller'
                    } catch (error){
                        echo "The Dockerimage was not built ${error}"
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
        }
        stage ('Test') {
            steps {
                sh 'sudo docker images && sudo docker ps -a'
            }
        }
        stage ('Upload') {
            steps {
                echo "** Upload Image to Dockerhub **"
                sh 'ID=`docker images --filter=reference=webrtccontroller --format "{{.ID}}"`'
                sh 'sudo docker tag $ID $USERNAME/webrtc_controller:$VERSION & sudo docker push $USERNAME/webrtc_controller '
            }
        }
        stage('Cleanup') {
            echo '** Clean WS **'
            cleanWs cleanWhenAborted: false, cleanWhenFailure: false, cleanWhenNotBuilt: false, cleanWhenUnstable: false
        }
    }
}