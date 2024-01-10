###########################################################
############################################################ 
# Test Case: BASE-RCV-1050 Web Inbound Complete OSD Receipt.feature
# 
# Functional Area: Receiving
# Author: Tryon Solutions
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: Web, MOCA
#
# Description: This test case will receive/putaway in short, over, and damaged product states
#
# Input Source: Test Case Inputs/BASE-RCV-1050.csv
# Required Inputs:
# 	trlr_num - This will be used as the trailer number when receiving by Trailer. If not, this will be the Receive Truck and Invoice Number
#	invnum - This will be used as the Invoice Number when receiving by Trailer. If receiving by PO - this will not be used.
#	yard_loc - If receiving by Trailer, this is where your Trailer needs to be checked in. Must be a valid and open dock door.
#	invtyp - This need to be a valid Invoice Type, that is assigned in your system
#	prtnum - This needs to be a valid part number that is assigned in your system. Will use the default client_id.
#	rcvsts - Receiving status created on the Invoice Line being loaded
#	expqty - The number expected
#	rcvqty - The number being received
# 	supnum - A valid supplier
#	rec_loc - A valid Receiving Staging lane 
#	damaged_flag - designate that goods should be received as damaged
# Optional Inputs:
# 	None
#
# Assumptions:
# None
#
# Notes:
# None
#
############################################################
Feature: BASE-RCV-1050 Web Inbound Complete OSD Receipt

Background:
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Web Receiving Imports"
	And I execute scenario "Web Environment Setup"

	Then I assign "BASE-RCV-1050" to variable "test_case"
	When I execute scenario "Test Data Triggers"

And I "load the dataset"	
	Then I assign "Receiving" to variable "dataset_directory"
	#And I execute scenario "Perform MOCA Dataset"

After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

And I "cleanup the dataset"
	Then I assign "Receiving" to variable "cleanup_directory"
	#And I execute scenario "Perform MOCA Cleanup Script"
Then I echo $over_qty
And I echo $shorts_qty
And I echo $dmg_qty

@BASE-RCV-1050
Scenario Outline: BASE-RCV-1050 Web Inbound Validate Shorts
CSV Examples: Test Case Inputs/BASE-RCV-1050.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "log into the Web Browser, select workstation, and navigate to the Inbound Shipments Screen"
	Then I execute scenario "Web Login"
	And I execute scenario "Web Select Workstation"
	And I execute scenario "Web Open Inbound Shipments Screen"

When I "find shipment, receive/putawy with short, over, or damaged product conditions"
	Then I execute scenario "Web Inbound Shipments Search for Shipment"
    
And I "validate short, over, and damaged states"
	Then I execute scenario "Web Receiving Validate Only OSD States"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"