pipeline {
    agent any

    environment {
        JAVA_HOME = "${tool 'openjdk-11'}"
        MAVEN_HOME = "${tool 'maven-3.6.1'}/bin"
        PATH = "${MAVEN_HOME}:${PATH}"
        BRANCH_VERSION = ""
    }

    stages {

        stage('Checkout') {
            steps {
                // checkout repository
                checkout scm

                // checkout input branch
                sh "git checkout ${BRANCH_NAME}"
            }
        }

        stage('Determine Branch Version') {
            steps {
                script {
                    //    determine version in pom.xml
                    pomVersion = sh(script: 'mvn -q -Dexec.executable=\'echo\' -Dexec.args=\'${project.version}\' --non-recursive exec:exec', returnStdout: true).trim()
                    branchVersion = ""

                    // compute proper branch SNAPSHOT version
                    pomVersion = pomVersion.replaceAll(/-SNAPSHOT/, "")
                    branchVersion = "${BRANCH_NAME}"
                    branchVersion = branchVersion.replaceAll(/origin\//, "")
                    branchVersion = branchVersion.replaceAll(/\W/, "-")
                    branchVersion = "${pomVersion}-${branchVersion}-SNAPSHOT"

                    // set branch SNAPSHOT version in pom.xml
                    sh "mvn versions:set -DnewVersion=${branchVersion}"
                    BRANCH_VERSION = branchVersion
                }
            }
        }

        stage('Java Build') {
            steps {
                sh 'mvn clean package -U'
            }
        }

        stage('Docker Build') {
            steps {
                echo "Build docker image"

                script {
                    // prepare docker build context
                    //sh "cp target/spring-boot-docker-0.0.1-master-SNAPSHOT.jar ./tmp-docker-build-context/"

                    // Build and push image with Jenkins' docker-plugin
                    withDockerServer([uri: "tcp://denpasar.indonesia:2575"]) {
                        //withDockerRegistry([credentialsId: 'docker-registry-credentials', url: "https://<my-docker-registry>/"]) {
                        // we give the image the same version as the .war package
                        dockerImage = docker.build("raymondmm/spring-boot-demo:${branchVersion}", "--build-arg PACKAGE_VERSION=${branchVersion} .")

                        //pipelineContext.dockerImage = dockerImage
                        //image.push()
                        //}
                    }

                }
            }
        }

        stage('Docker Run') {
            steps {
                echo "Run docker image"

                script {
                    withDockerServer([uri: "tcp://denpasar.indonesia:2575"]) {
                        dockerContainer = dockerImage.run("-p8888:8080", "--name spring-boot-demo-app")
                    }
                }
            }

        }

        stage('Test') {
            steps {
                echo "Testing 1 2 3 ..."
            }
        }
    }

    post {
        always {
            echo "Stop Docker image"
            script {
                if (dockerContainer) {
                    dockerContainer.stop()
                }
            }
        }
    }

}
