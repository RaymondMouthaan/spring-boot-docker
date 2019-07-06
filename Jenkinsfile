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

        stage('Example') {
            steps {
                echo "${BRANCH_VERSION}"

                sh(script: 'java --version')
                sh(script: 'mvn --version')

            }
        }
    }
}
