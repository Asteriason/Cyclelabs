pipeline {
  agent any
  stages {
    stage('Setup Environment Variables') {
      steps {
        powershell '$env:TOKEN = \'eyJraWQiOiJjcGltY29yZV8wOTI1MjAxNSIsInZlciI6IjEuMCIsInppcCI6IkRlZmxhdGUiLCJzZXIiOiIxLjAifQ..d8pUO34zWE12t0vd.PQ6PEnF_KX-pdyCgHWFMuqS0GXOH3q4I_ch56FgCLgKZtBgF32tXBALRI8kvHNOk5oZ75KeOUzGefhMWttGnANljFF8T0TdGIsb9nBAR3PHuOqmVWBj1Cjl4cnq0vBHYlFpb6fclb-s1ABEom9TNlNdv0qP4EkGyUhvAqOxz-rne82ShG-zzBNipBkE1q-2BUDSp8VmgzCJgVlj0DoiCpCEY1tqMz-7GTQniNWASzFMWax4gyGMvaivLnz6PCpNc2C77a2_x6UHtYCyzu2UKqaE_UFBfRpFZNxYrZu5QjbISMp4UBw4wOAFZQRYF7U-3rA33e61CoWbN0BNlH99rGXMcLa6uUq-TCkuCScdKJiOdplFjn6DD5ogHf7EizR4uaHYWfhn8144-pW-ri1wnaTzTpRXO8gKwfP1cnjcDVRFjgY1sgvWcifHv46YSSvdWRqLm87kPFL9KwwylY8cV72--bHILc1NUtSU_0RDwx6EgN5kApWB2NknzbiRSTSV1tBpq3XjzK7j8kzchCaWWP3hHkUc1PPeguDkgevZRP0JzYiawiICbqpnJS84fL2wVgNFkAZ_Xet0QePQCd6vdKhN_YOFjWWKaMSjH5GkkgO5dGZPQB6IHK5X2Rg7Fh5w0dgwGmNtpjQOHuk0CvNC_0GFzjk0H011riVR8hqYccdEfMvGZrmHx3AKce9VHyELz8zsznr1lqQJMBR2Z9DONcToqAKeXM10ed8YOjXfIVurdxOCLtkRlqEbZXH7Uw7hEjZ50HlcueMqjrt8MeRr3YbGpEpyu7twDo4q09ngJodn8J9dS_nir3KkD6y6CouTwEivVWUftGh_-C6Lug-4n4XqOjQ.kTvnJ45zX7A8SAzfF7jKXA\' '
        powershell 'Write-Output "Credentials setup complete. TOKEN: $env:TOKEN"'
      }
    }

    stage('Execute Script') {
      steps {
        powershell '& "C:\\\\Program Files (x86)\\\\CycleLabs\\\\Cycle\\\\cycle-cli" --token ${env.TOKEN} -u erick.mejia -p WMS-BUNDLE-3.1.0.cycproj "Test Cases\\ABB_Click_N_Win\\Outbound\\slotted_picks_only.feature"'
      }
    }

  }
}