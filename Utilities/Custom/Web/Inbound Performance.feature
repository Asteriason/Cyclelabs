Feature: Inbound Performance

@wip @public
Scenario: Get Inbound Data
Given I "query for an available trailer"
	Given I assign "get_inbound_data.msql" to variable "msql_file"
	When I execute scenario "Perform MSQL Execution"
	If I verify MOCA status is 0
		Given I execute scenario "Assign ASN Variables"
	Else I fail step with error message "No data found!"
	EndIf

@wip @private 
Scenario: Assign ASN Variables
Then I assign row 0 column "trknum" to variable "trknum"
Then I assign row 0 column "yard_loc" to variable "yard_loc"
Then I assign row 0 column "invnum" to variable "inv_num"
Then I assign row 0 column "invlin" to variable "invlin"
Then I assign row 0 column "prtnum" to variable "prtnum"
Then I assign row 0 column "supnum" to variable "supnum"
