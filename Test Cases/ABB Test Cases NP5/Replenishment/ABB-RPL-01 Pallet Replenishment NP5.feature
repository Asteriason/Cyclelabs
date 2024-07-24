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
# Test Case: ABB-RPL-01 Pallet Replenishment.feature
# 
# Functional Area: Replenishment
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: Web, MOCA
#
# Description: This test case will validate an inbound shipment in the Web
#
# Input Source: Test Case Inputs/ABB INPUTS NP5/ABB-RPL-01.csv
# Required Inputs:
#	mobile_start_loc - 
#	vehtyp - 
#	ordnum - 
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

Feature: ABB-RPL-01 Pallet Replenishment NP5

Background:

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Mobile Replenishment Imports"

	If I verify variable "mobile_devcod" is assigned
		And I assign $mobile_devcod to variable "devcod"
	EndIf
    # LPCK=PJ  PCK=RT

After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@ABB-RPL-01
Scenario Outline: ABB-RPL-01 Pallet Replenishment NP5
CSV Examples:Test Case Inputs/ABB INPUTS NP5/ABB-RPL-01.csv

Then I "login to the Mobile App, assign work, and traverse to directed work menu"
	And I execute scenario "Mobile Login"
    And I execute scenario "Mobile Navigate to Directed Work Menu"

When I "perform pallet replenishment"
	And I execute scenario "Mobile Perform Pallet Replenishment"

