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
# Test Case: ABB-PCK-16 Outbound Unpicking.feature
# 
# Functional Area: Picking
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: Mobile, MOCA
#
# Description:
# This test case performs Mobile App Unpicking functions
# 
# Input Source: Test Case Inputs/BASE-PCK-4080.csv
# Required Inputs:
# 	ordnum - This will be used as the ordnum when creating when creating carton pick data
# 	cancelcod - cancel code to use when unpicking, this should be a valid cancel code configured in the system
#	
# Optional Inputs:
#	None
#
# Assumptions:
# - Load, part, client, qty, uomcod reason code are configured for unpicking
# - The instance contains sufficient inventory for allocation
#
# Notes: 
# - If not using the dataset, values must be defined for pck_lodnum, and prtnum/unpick_qty (if unpicking_partial is set to Y)
# - By default, this Test Case uses Undirected Putaway. Additional variables may be added to the CSV to support Directed Putaway
# 
############################################################ 
Feature: ABB-PCK-16 Outbound Unpicking

Background:
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Mobile Picking Imports"

	Then I assign "ABB-PCK-16" to variable "test_case"
	When I execute scenario "Test Data Triggers"

After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@ABB-PCK-16
Scenario Outline: ABB-PCK-16 Outbound Unpicking
CSV Examples: Test Case Inputs\ABB INPUTS NP5\ABB-PCK-16.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "login to the Mobile App and navigate to the Unpick Menu"
	And I execute scenario "Mobile Login"
    And I execute scenario "Mobile Navigate to Unpick Menu"

When I execute scenario "Mobile Full Unpick" 

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"