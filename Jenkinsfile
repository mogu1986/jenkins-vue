pipeline {

    agent any

    environment {
        // harbor 相关配
        HARBOR = "harbor.top.mw"
        HARBOR_URL = "http://${HARBOR}"

        IMAGE_NAME = "${HARBOR}/library/${JOB_NAME}:${BUILD_ID}"

        APP_NAME = "vue"
        LANG = "nginx"
    }

    parameters {
        choice(name: 'BUILD_BRANCH', choices: 'dev\ntest', description: '请选择部署的环境')
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

         stage("ansible自动化部署"){
           steps{
             script{
               docker.image('harbor.top.mw/library/ansible:centos7').inside() {
                 checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false,
                           extensions: [], submoduleCfg: [],
                           userRemoteConfigs: [[credentialsId: 'gitlab', url: 'https://github.com/mogu1986/jenkins-ansible-playbooks.git']]])
                    ansiColor('xterm') {
                        ansiblePlaybook(
                            playbook: "playbook_${env.LANG}.yml",
                            inventory: "hosts/${params.BUILD_BRANCH}.ini",
                            hostKeyChecking: false,
                            colorized: true,
                            extraVars: [
                                lang: "${env.LANG}",
                                app: [value: "${env.APP_NAME}", hidden: false],
                                html_path: "${env.WORKSPACE}/dist/"
                            ]
                        )
                    }
               }
             }
           }
         }

    }

    post {
        always {cleanWs()}
    }
}