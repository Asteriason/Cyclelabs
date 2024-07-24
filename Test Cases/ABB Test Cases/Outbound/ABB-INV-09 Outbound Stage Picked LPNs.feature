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
# Test Case: ABB-INV-09 Outbound Stage Picked LPNs.feature
# 
# Functional Area: Inventory, Outbound
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: Mobile, MOCA
#
# Description: This test case performs a full inventory move of multiple LPNs as Undirected work in the Mobile App
#
# Input Source: Test Case Inputs/ABB INPUTS/ABB-INV-09.csv
# Required Inputs:
# 	wave_num - This will be the wave number assigned previous tests
#   ord_num - Order Number associated with this pick.
#   wh_id - Warehouse which we are working
#
# Optional Inputs:
#	None
# 
# Assumptions: 
# - Regression runs require parts and enough config to deposit inventory into the destination location.
# - Processing will handle standard LPN flow for blind receipts, over receipts, multi-client, multi-wh, lot tracking, aging, qa directed
# - Process ends with the inventory being moved to assign dstloc
#
# Notes:
# None
#
############################################################ 
Feature: ABB-INV-09 Outbound Stage Picked LPNs

Background:
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Mobile Inventory Imports"

	Then I assign "ABB-INV-09" to variable "test_case"
	When I execute scenario "Test Data Triggers"

After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"
   

@ABB-INV-09
Scenario Outline: ABB-INV Stage Picked LPNs
CSV Examples: Test Case Inputs/ABB INPUTS/ABB-INV-09.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "login to the Mobile App"
	And I execute scenario "Mobile Login"

When I "navigate to the transfer screen and perform transfer"
	Then I execute scenario "Mobile Navigate to Inventory Transfer Menu"
	And I execute scenario "Mobile Stage Picked LPNs"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"