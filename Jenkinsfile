pipeline {
    agent none
    environment {
        JAVA_HOME = tool name: 'openjdk-11'
    }
    stages{

        stage('Example') {
            steps {
                echo 'Hello World'
                echo '${JAVA_HOME}'
            }
        }
    }
}
