###########################################################
# Copyright 2024, Netlogistik.
# All rights reserved.  Proprietary and confidential.
#
# This file is subject to the license terms found at 
# https://www.cycleautomation.com/end-user-license-agreement/
#
# The methods and techniques described herein are considered
# confidential and/or trade secrets. 
# No part of this file may be copied, modified, propagated,
# or distributed except as authorized by the license.
############################################################ 
# Test Case: ABB-RCV-04 Web Inbound Complete OSD Receipt.feature
# 
# Functional Area: Receiving
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: Web, MOCA
#
# Description: This test case will receive/putaway in short, over, and damaged product states
#
# Input Source: Test Case Inputs/ABB INPUTS NP5/BASE-RCV-04.csv
# Required Inputs:
# 	trlr_num - This will be used as the trailer number when receiving by Trailer. If not, this will be the Receive Truck and Invoice Number
#	trlnum - This will be used as the Invoice Number when receiving by Trailer. If receiving by PO - this will not be used.
#	yard_loc - If receiving by Trailer, this is where your Trailer needs to be checked in. Must be a valid and open dock door.
#
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
Feature: ABB-RCV-04 Inbound Complete OSD Receipt NP6

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

	Then I assign "ABB-RCV-04" to variable "test_case"
	When I execute scenario "Test Data Triggers"

#And I "load the dataset"	
	#Then I assign "Receiving" to variable "dataset_directory"
	#And I execute scenario "Perform MOCA Dataset"

After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

#And I "cleanup the dataset"
	#Then I assign "Receiving" to variable "cleanup_directory"
	#And I execute scenario "Perform MOCA Cleanup Script"

@ABB-RCV-04
Scenario Outline: BASE-RCV-1050 Web Inbound Complete OSD Receipt
CSV Examples: Test Case Inputs/ABB INPUTS NP6/ABB-RCV-04.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "log into the Web Browser, select workstation, and navigate to the Inbound Shipments Screen"
	Then I execute scenario "Web Login"
	Then I execute scenario "Web Open Inbound Shipments Screen"
	Then I execute scenario "Web Inbound Shipments Search for Shipment"
	Then I execute scenario "Web Receiving Validate Inbound Shipment Part 1"
	
    
And I "complete OSD shipment"
	Then I execute scenario "Web OSD Complete"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"