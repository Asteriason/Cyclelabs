pipeline {
    agent any
    environment { 
        TOKEN = credentials('cycle-cli-token')
    }
    stages {
        stage('Run Cycle CLI Command') {
            steps {
                script {
                    echo "Token value: ${env.TOKEN}"
                }
                powershell """
                & "C:\\Program Files (x86)\\CycleLabs\\Cycle\\cycle-cli" --token ${env.TOKEN} -u erick.mejia -p WMS-BUNDLE-3.1.0.cycproj "Test Cases\\ABB Test Cases NP5\\Outbound E2E\\Outbound_1_web.feature"
                """
            }
        }
    }
}
