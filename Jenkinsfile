pipeline {
    agent any
    environment {
        JAVA_HOME = tool name: 'openjdk-11'
        MAVEN_HOME = tool name: 'maven-3.6.1'
    }
    stages {

        stage('Example') {
            steps {
                echo 'Hello World'
                echo "${JAVA_HOME}"
                echo "${MAVEN_HOME}"
                echo "${PATH}"

                sh(script: 'java --version')
                sh(script: 'mvn --version')

            }
        }
    }
}
