pipeline {
  agent any
  stages {
    stage('Setup Environment Variables') {
      steps {
        powershell '$env:TOKEN = \'eyJraWQiOiJjcGltY29yZV8wOTI1MjAxNSIsInZlciI6IjEuMCIsInppcCI6IkRlZmxhdGUiLCJzZXIiOiIxLjAifQ..xiHlj9W8DEBnij_l.HiM9kbmma0VGrGIkRNXql6qlipHQig2dSdD3JUfKnne8STeLIhgv217YSb_1mpQ24dpIH11FU3LinOnl7dkXVzgHvuZoKdXbFghm6dWLkVX7qw23R9fWLSGr1rFYzKRhpX3IX9WrUdYuSbYUltl_9nsYstWa-4lp9j-5crYjyKIhL1Z4paNWnIkn23ZFkRCd0Qhr5OHjUjmG4i18gmMoe7qZSrrYj2ewHcaOFTdqQs91QLX4U3ZPavFd0ImSO3IqRIZDPcGW2QkHUu2e-EtnMsfjScs3TmPbNlFUfr8xvGkpvSVHMB2W2TKg2SfMV8IWOJDwMTJh2D6SNQbOQMyCohyd8WT3dIGMwkJzAFkm7PebnsgQ3BhhVV1g93U-TemRsVDBR86MGRAJXne6OC-ulszCZlBX3dZnEZ2agtnN9a6L2PiHvSDlq8Cr-gvL07VuDYpqqnlM5a3Kz56jbMOvU05nFrCUI8KAo2iy1pcv5d-gbZQMZDCJmNwJ-m4g93DhM-yX8E7f045CreD8eM86XfYnanFkAGUrstJ3bxjJTDMpkj7E7y_6F6De7I9_y2Lk839aPJVixpfxF-HxgQKFRGNfmZZ9ispBcAlKaPS1Tkr-fua2jmC2GonLpVwi7BiWqEGNOKxHV2hH7iWT2i3dT4xPH-7M4K-ybmp1-qaFnaGv0Dxc4l3TZczTw1kFIGV3puvKvg5JISkg39MUMUD0NXXaqh32z5JnKqjOKmttt-tMIPhVDgzrt6FTFDiDNjA_5BdNU40WxdUZpWFLKMspH1xNj12R9wrHJfPszHYovTPluYuCJaN31_wV3GWrgnvVl3SAlHuFQCot_fEzxWYSuls.eM_Ik77_LX2fHZBl3xhuKA\' '
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