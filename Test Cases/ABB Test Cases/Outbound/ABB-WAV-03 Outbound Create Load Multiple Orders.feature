############################################################
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
# Test Case: ABB-WAV-03 Outbound Create Load.feature
# Functional Area: Outbound
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: regression
# Blue Yonder Interfaces Interacted With: WEB, MOCA
# 
# Description:
# This test case will create a new load in the Web
#
# Input Source: Test Case Inputs/ABB INPUTS/ABB-WAV-03.csv
# Required Inputs:
# 	trlr_num - This will be used as the trailer num 
#	yard_loc - This will be used as the yard loc
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
Feature: ABB-WAV-03 Outbound Create Load
 
Background: 
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Outbound Planner Imports"
	And I execute scenario "Web Environment Setup"

	Then I assign "ABB-WAV-05" to variable "test_case"
	When I execute scenario "Test Data Triggers"

	Given I assign "" to variable "ship_id"
When I "get shipment list"
	When I echo $ordnum_1
	And I echo $ordnum_2
	Then I wait $wait_med seconds
	Given I execute scenario "Get Multiple Shipments For Search"
    And I echo $shipment_list
	And I wait $wait_med seconds

After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

#And I "cleanup the dataset"
	Then I assign $ui_move_id to variable "move_id"
	#And I assign "Web_Outbound_Shipment" to variable "cleanup_directory"
	#And I execute scenario "Perform MOCA Cleanup Script"

@ABB-WAV-03
Scenario Outline: ABB-WAV-03 Outbound Create Load
CSV Examples: Test Case Inputs\ABB INPUTS\LTL-MTOL-ALL.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "log into the Web and navigate to Outbound Screen"
	And I execute scenario "Web Login"
	And I execute scenario "Web Navigate to Outbound Planner Outbound Screen"

When I "create the load"
	Then I execute scenario "Web Create Load Multiple Orders"
    
Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"