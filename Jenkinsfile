pipeline {
  agent any
  stages {
    stage('Setup Environment Variables') {
      steps {
        powershell '$env:TOKEN = \'eyJraWQiOiJjcGltY29yZV8wOTI1MjAxNSIsInZlciI6IjEuMCIsInppcCI6IkRlZmxhdGUiLCJzZXIiOiIxLjAifQ..eHRNWVQdNFc49bLV.5_uQDL2W5xVCYjEAPXrp9yU2nZCjV9sqxEbNU7Z9HtRFbaQ7-qhiay409nJ5mR_4Yw8ebdn8rDeAdK3jpEmUQnB-42OlwiWDHdVNp_XbX0pdq6CnU8jyqaEUH3j8QSGmfThZpTsBU-HuWVKRjppBgmVeaoC8K3rHd9A62jvVBWRHdtd7lm7vngJvRpmyIaRVP1WqbsXeFd9pFr6ZTV2vJe6ZJVX65h1Oq5mr6_rmw0XlDQu5pPfUOEQTFs8MBMApcyGCEUiK4eojnrVWt_VO3PFJWET9IdU62xhyFkKJYT6z_jB7jDmWA9k2kewOLpZNSQPWxXrRDrv5tK3qfvmRC-4Nsj56kzWmwjH2VNyy--OU0igWvz4j6wUmKMNpkal8xLYNT9ImVEmiDaiirH0cjxIjnJyC9YbnM14dGrrtye9nRn6KqHvc532i1gx_y4R_YBWGtI5FAen8em8n-oJbN9Mky-_tQ-ZgWJ98AvTC-aMkFNnAhqegCHIM8ASEF831LH1PD9PiWZ0Mbs4QVCFoja40OP95sqLI3cpAx8elI2cF-bX-SLU7wMzyRSJEngdeUuIYFPo7PoQm2J0fvrv2zp-TPYXzcKQgb5U8gAY6a-Y_f-0tbi-dqPbdfY5kHdv-sVLAsquCZ5mdtBHeVI2thMPpE-VBefKeF_c4ydpuIhbxG7zYwJMmr-S2256CzO-jMybPvHJ4OUYcrBtIuCUSYCZq_-EUuOMxGXMugroJ55pt-WahGBghXs9ROAxzPD5J5upZCxOWvLSq7YkRTblYy-WPgpMrof68pjpKXJB8TOkTlJSOmKwVBIkkjWQCvE13tHnV0DXIxGs8Jq95b26reksIJA.L1jNMq7lMb88ExhMbN1rJA\' '
        powershell 'Write-Output "Credentials setup complete. TOKEN: $env:TOKEN"'
      }
    }

    stage('Execute Script') {
      steps {
        powershell '& "C:\\\\Program Files (x86)\\\\CycleLabs\\\\Cycle\\\\cycle-cli" --token ${TOKEN} -u erick.mejia -p WMS-BUNDLE-3.1.0.cycproj "Test Cases\\\\ABB Test Cases NP7\\\\Cross-Dock\\\\Create_Shipment_With_Order.feature"'
      }
    }

  }
}