pipeline {
    agent any
    environment { 
        TOKEN = credentials('cycle-cli-token')
    }
    triggers {
        cron('0 8 * * *')  // Trigger the pipeline every day at 8 AM
    }
    stages {
        stage('Update CSV and Run Cycle CLI Command') {
            steps {
                script {
                    // Path to your CSV file
                    def csvFilePath = 'Test Case Inputs\\ABB INPUTS NP7\\XDCK\\create_inbound_shipment_and_order.csv'
                    
                    // Read the CSV file
                    def csvContent = readFile(file: csvFilePath)
                    
                    // Process the CSV content
                    def updatedCsvContent = processCsv(csvContent)
                    
                    // Write the updated content back to the CSV file
                    writeFile(file: csvFilePath, text: updatedCsvContent)
                    
                    // Print token value for debugging purposes
                    echo "Token value: ${env.TOKEN}"
                    
                    // Run the PowerShell command
                    powershell """
                    & "C:\\Program Files (x86)\\CycleLabs\\Cycle\\cycle-cli" --token ${env.TOKEN} -u erick.mejia -p WMS-BUNDLE-3.1.0.cycproj "Test Cases\\ABB Test Cases NP7\\Cross-Dock\\Create_Shipment_With_Order.feature"
                    """
                }
            }
        }
    }
}

// Function to process the CSV content
def processCsv(csvContent) {
    def lines = csvContent.split('\n')
    def header = lines[0]
    def data = lines[1].split(',')

    // Increment the first number
    data[1] = (data[1].toBigInteger() + 1).toString()

    // Increment the second number (assuming the format remains consistent)
    def match = (data[2] =~ /(.*-XD)(\d+)/)
    if (match) {
        def prefix = match[0][1]
        def number = match[0][2].toInteger() + 1
        data[2] = "${prefix}${String.format('%04d', number)}"
    }

    return "${header}\n${data.join(',')}"
}
