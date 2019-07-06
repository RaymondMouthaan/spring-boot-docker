pipeline {
    agent any

    environment {
        JAVA_HOME = "${tool 'openjdk-11'}"
        MAVEN_HOME = "${tool 'maven-3.6.1'}/bin"
        PATH = "${MAVEN_HOME}:${PATH}"
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

//        stage('Determine Branch Version') {
//
//
//
//            // determine version in pom.xml
//            def pomVersion = sh(script: 'mvn -q -Dexec.executable=\'echo\' -Dexec.args=\'${project.version}\' --non-recursive exec:exec', returnStdout: true).trim()
//
//            // compute proper branch SNAPSHOT version
//            pomVersion = pomVersion.replaceAll(/-SNAPSHOT/, "")
//            branchVersion = env.BRANCH_NAME
//            branchVersion = branchVersion.replaceAll(/origin\//, "")
//            branchVersion = branchVersion.replaceAll(/\W/, "-")
//            branchVersion = "${pomVersion}-${branchVersion}-SNAPSHOT"
//
//            // set branch SNAPSHOT version in pom.xml
//            sh "mvn versions:set -DnewVersion=${branchVersion}"
//        }
//
//        stage('Example') {
//            steps {
//                sh(script: 'java --version')
//                sh(script: 'mvn --version')
//
//            }
//        }
    }
}
