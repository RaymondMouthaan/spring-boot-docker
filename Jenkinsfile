node {
  def pipelineContext = [:]

  echo 'The pipeline started'

  jdk = tool name: 'openjdk-11'
  env.JAVA_HOME = "${jdk}"

  def branchVersion = ""

  stage ('Checkout') {
    // checkout repository
    checkout scm

    // checkout input branch
    sh "git checkout ${BRANCH_NAME}"
  }

  stage ('Determine Branch Version') {
//    environment {
//      env.JAVA_HOME = "${tool 'openjdk-11'}"
//      env.PATH = "${tool 'maven-3.6.1'}/bin:${env.PATH}"
//    }

    // add maven to path
    env.PATH = "${tool 'maven-3.6.1'}/bin:${env.PATH}"

    // determine version in pom.xml
    def pomVersion = sh(script: 'mvn -q -Dexec.executable=\'echo\' -Dexec.args=\'${project.version}\' --non-recursive exec:exec', returnStdout: true).trim()

    // compute proper branch SNAPSHOT version
    pomVersion = pomVersion.replaceAll(/-SNAPSHOT/, "")
    branchVersion = env.BRANCH_NAME
    branchVersion = branchVersion.replaceAll(/origin\//, "")
    branchVersion = branchVersion.replaceAll(/\W/, "-")
    branchVersion = "${pomVersion}-${branchVersion}-SNAPSHOT"

    // set branch SNAPSHOT version in pom.xml
    sh "mvn versions:set -DnewVersion=${branchVersion}"
  }

  stage ('Java Build') {
    // build .jar package
    sh 'mvn clean package -U'
  }

  stage ('Docker Build') {
      // prepare docker build context
      //sh "cp target/spring-boot-docker-0.0.1-master-SNAPSHOT.jar ./tmp-docker-build-context/"

      // Build and push image with Jenkins' docker-plugin
      withDockerServer([uri: "tcp://denpasar.indonesia:2575"]) {
        //withDockerRegistry([credentialsId: 'docker-registry-credentials', url: "https://<my-docker-registry>/"]) {
          // we give the image the same version as the .war package
          def dockerImage = docker.build("raymondmm/spring-boot-demo:${branchVersion}", "--build-arg PACKAGE_VERSION=${branchVersion} .")

          pipelineContext.dockerImage = dockerImage
          //image.push()
        //}
      }
    }
  }

  stage ('Docker Run') {
      echo "Run docker image"

      withDockerServer([uri: "tcp://denpasar.indonesia:2575"]) {
          pipelineContext.dockerContainer = pipelineContext.dockerImage.run()
      }
  }

