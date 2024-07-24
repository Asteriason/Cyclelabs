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
##########################.################################## 
# Test Case: ABB-RCV-02 Check In Inbound Shipment NP5.feature
# 
# Functional Area: Receiving
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: Web, MOCA
#
# Description: This test case will validate an inbound shipment in the Web
#
# Input Source: Test Case Inputs/ABB INPUTS NP5/ABB-RCV-02.csv
# Required Inputs:
#	trlr_num - this will be the Receive Truck
#	yard_loc - This is where your Trailer needs to be checked in. Must be a valid and open dock door.
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
Feature: ABB-RCV-02 Check In Inbound Shipments NP5

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

	Then I assign "ABB-RCV-02" to variable "test_case"
	When I execute scenario "Test Data Triggers"

	Then I execute MOCA script "Scripts\MSQL_Files\Custom\generate_lpn.msql"
	If I verify MOCA status is 0
    	Then I assign row 0 column "lodnum" to variable "lpn"
    	And I echo $lpn
	EndIf

#And I "load the dataset"	
#	Then I assign "receiving" to variable "dataset_directory"
#	And I execute scenario "Perform MOCA Dataset"
 
After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

#And I "cleanup the dataset"
#	Then I assign "receiving" to variable "cleanup_directory"
#	And I execute scenario "Perform MOCA Cleanup Script"

@ABB-RCV-02
Scenario Outline: ABB-RCV-02 Check In Inbound Shipments
CSV Examples: Test Case Inputs/ABB INPUTS NP5/ABB-RCV-02.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "log into the Web Browser and navigate to the Inbound Shipments Screen"
	Then I execute scenario "Web Login"
	And I execute scenario "Web Open Receiving Transport Equipment Screen"

When I "find and validate the inbound shipment"
    And I execute scenario "Web Search for Inbound Trailer"
    And I execute scenario "Web Check In Inbound Trailer"
    And I execute scenario "Web Verify Inbound Trailer Check In"
	And I execute scenario "Web Receiving Validate Inbound Shipment"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"