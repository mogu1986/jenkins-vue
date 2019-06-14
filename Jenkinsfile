pipeline {

    agent any

    environment {

        // harbor 相关配置
        HARBOR = "harbor.top.mw"
        HARBOR_URL = "http://${HARBOR}"
        HARBOR_CRED = credentials('harbor')

        IMAGE_NAME = "${HARBOR}/library/${JOB_NAME}:${BUILD_ID}"
    }

    parameters {
        choice(name: 'BUILD_BRANCH', choices: 'master\ntest', description: '请选择部署的环境')
    }

    tools {
        nodejs 'NODEJS'
    }

    stages {

        stage('编译') {
            steps {
                sh "yarn install"
                sh "yarn build"
            }
        }

        stage('推送镜像') {
            steps {
                script {
                    docker.withRegistry("$HARBOR_URL", "harbor") {
                        def app = docker.build("$IMAGE_NAME")
                        app.push()
                        app.push('latest')
                    }
                    sh "docker rmi -f $IMAGE_NAME"
                }
            }
        }


    }

    post {
        always {cleanWs()}
    }
}