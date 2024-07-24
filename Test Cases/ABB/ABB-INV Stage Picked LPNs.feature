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
# Test Case: BASE-INV-4140 Mobile Inventory Transfer Multiple LPNs Undirected.feature
# 
# Functional Area: Inventory
# Author: Tryon Solutions 
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: Mobile, MOCA
#
# Description: This test case performs a full inventory move of multiple LPNs as Undirected work in the Mobile App
#
# Input Source: Test Case Inputs/BASE-INV-4140.csv
# Required Inputs:
# 	srcloc - Where the adjustment will take place. Must be a valid adjustable location in the system
#	dstloc - Destination Location.  Where we deposit the inventory.
# 	lodnum - Load number being adjusted in. Can be a fabricated number. Used in Terminal and datasets processing.
# 			 (Note: When lodnum = 'CYC-LOAD-XFER', Cycle will generate a new LPN when processing the dataset.
#			 otherwise, it will use the input lodnum.)
# 	prtnum_list - Comma separated list of valid part numbers that are assigned in your system and will use to generated inventory
#	untqty - Quantity for the dataset to add inventory . Must be a number. Quantity used for all prtnums in prtnum_list
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
Feature: BASE-INV-4140 Mobile Inventory Transfer Multiple LPNs Undirected

Background:
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Mobile Inventory Imports"

	Then I assign "BASE-INV-4140" to variable "test_case"
	When I execute scenario "Test Data Triggers"
    
    Given I assign "0813429763" to variable "ordnum"
    Given I assign 25 to variable "wh_id"

After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"
   

@BASE-INV-4140
Scenario Outline: ABB-INV Stage Picked LPNs
CSV Examples: Test Case Inputs\ABB-1010.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "login to the Mobile App"
	And I execute scenario "Mobile Login NP2"

When I "navigate to the transfer screen and perform transfer"
	Then I execute scenario "Mobile Navigate to Inventory Transfer Menu"
	And I execute scenario "Mobile Stage Picked LPNs"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"