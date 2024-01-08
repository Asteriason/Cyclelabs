###########################################################
# 
# Functional Area: Receiving
# Author: Erick Mejía
# Blue Yonder WMS Version: 2021
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: Web, MOCA
#
# Description:
# This test case determines if inbound shipment is over receipt.
#
# Input Source: Test Case Inputs/ABB-RCV-OVERRECEIPT.csv
# Required Inputs:
#   trknum - Inbound Shipment number
#
# Optional Inputs:
#	  None
#
# Assumptions:
# None
#
# Notes:
# None
#
############################################################
Feature: ABB-RCV-OVERRECEIPT Inbound Shipment Over Receipt
 
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

	Then I assign "ABB-RCV-OVERRECEIPT" to variable "test_case"
	When I execute scenario "Test Data Triggers"    

After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"
If I verify variable "result" is assigned
  Then I echo $result
  Else I echo "Shipment is empty"
EndIf

@ABB-RCV-OVERRECEIPT
Scenario Outline: ABB-RCV-OVERRECEIPT Inbound Shipment Over Receipt
CSV Examples: Test Case Inputs/ABB-RCV-OVERRECEIPT.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"
When I execute scenario "Web Login"
Then I execute scenario "Web Open Inbound Shipments Screen"
And I execute scenario "Web Inbound Shipments Search for Inbound Shipment Number"
And I execute scenario "Web Check Over Receipt Inbound Shipment"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"