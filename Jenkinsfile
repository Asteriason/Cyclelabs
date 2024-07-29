pipeline {
  agent any
  stages {
    stage('Setup Environment Variables') {
      steps {
        sh 'withCredentials([string(credentialsId: \'cycle-cli-token\', variable: \'TOKEN\')])'
        powershell 'Write-Output "Credentials setup complete. TOKEN: $env:TOKEN"'
      }
    }

    stage('Execute Script') {
      steps {
        powershell '& "C:\\\\Program Files (x86)\\\\CycleLabs\\\\Cycle\\\\cycle-cli" --token ${TOKEN} -u erick.mejia -p WMS-BUNDLE-3.1.0.cycproj "Test Cases\\ABB_Click_N_Win\\Outbound\\slotted_picks_only.feature"'
      }
    }

  }
}