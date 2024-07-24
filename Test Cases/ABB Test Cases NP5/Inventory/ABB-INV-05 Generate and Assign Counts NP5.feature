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
# Test Case: ABB-INV-05 Fenerate and Assign Counts NP5.feature

# Functional Area: Inventory
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: MOCA, WEB
#
# Description: This test case will generate a count and it will be assigned to an user.
# 
# Input Source: Test Case Inputs/ABB INPUTS NP5/ABB-INV-05.csv
# Required Inputs:
#	stoloc - This will be used as the location that will be used for the location
#	yard_loc - This will be used as the location that will be used for the source location
# Optional Inputs:
# None
#
# Assumptions:
# - The warehouse is configured for Triggered Replenishment
#
# Notes:
# None
#
############################################################ 
Feature: ABB-INV-05 Generate and Assign Counts NP5

Background:
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Inventory Adjust Imports"
	Then I execute scenario "Web Environment Setup"

	And I assign "ABB-INV-05" to variable "test_case"
	When I execute scenario "Test Data Triggers"

#And I "load the dataset"
	#Then I assign "Triggered_Replen" to variable "dataset_directory"
	#And I execute scenario "Perform MOCA Dataset""
 
After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

#And I "cleanup the dataset"
#	Then I assign "Triggered_Replen" to variable "cleanup_directory"
#	And I execute scenario "Perform MOCA Cleanup Script"

@ABB-INV-05
Scenario Outline: ABB-INV-05 Generate and Assign Counts NP5
CSV Examples: Test Case Inputs/ABB INPUTS NP5/ABB-INV-05.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "login into the web and navigate to the inventory screen"
	And I execute scenario "Web Login"
	#And I execute scenario "Web Open Inventory Screen"

Given I "search for the location assigned to create a cycle count"
	#And I execute scenario "Web Inventory Search for Location"

Given I "assign the cycle count to user"
	And I execute scenario "Web Open Inventory Work Queue Screen"
	And I execute scenario "Web Assign User to Work Queue"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"