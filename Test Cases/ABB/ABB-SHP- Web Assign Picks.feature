###########################################################
# Copyright 2020, Tryon Solutions, Inc.
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

	Given I execute scenario "Wave Imports"
	Then I execute scenario "Web Environment Setup"

	Then I assign "ABB-SHP Web Assign Picks" to variable "test_case"
	When I execute scenario "Test Data Triggers"

    And I assign "USKAMAR2" to variable "userlogin"
    Then I assign "BAT0000004" to variable "schbat1"


After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@ABB-SHP-Web-Assign-Picks
Scenario Outline: ABB-SHP Web Assign Picks
CSV Examples: Test Case Inputs/ABB-SHP Web Assign Picks.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "log into the Web Browser, select workstation, and navigate to the Inbound Shipments Screen"
	Then I execute scenario "Web Login"
	And I execute scenario "Web Navigate to Outbound Planner Waves and Picks"
    And I execute scenario "Web Assign Picks"


Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"