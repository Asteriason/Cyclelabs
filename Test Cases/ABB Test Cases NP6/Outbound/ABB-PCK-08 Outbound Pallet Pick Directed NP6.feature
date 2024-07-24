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
# Test Case: ABB-WAV-08 Outbound Mobile Pick Directed.feature
# 
# Functional Area: Outbound
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: regression
# Blue Yonder Interfaces Interacted With: WEB, MOCA
# 
# Description:
# This Test Case loads an order, plans a wave, creates a load and assigns a stop to it via MSQL. It then removes stop from the load in the Web
# 
# Input Source: Test Case Inputs/ABB INPUTS/ABB-PCK-08P.csv
# Required Inputs:
# 	oprcod - This will be used to validate the type of operation performed
#   vehtyp - Vehicle type
#   ordnum - Order number when creating the order to be loaded onto the trailer. Must not match any existing ordnum in the warehouse
# 	
# Optional Inputs:
#	None
#
# Assumptions:
# - User has permissions for functions
#
# Notes:
# None
#
############################################################ 
Feature: ABB-PCK-08 Outbound Mobile Pick Directed NP6

Background:

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Mobile Picking Imports"

	Then I assign "ABB-PCK-08" to variable "test_case"
	When I execute scenario "Test Data Triggers"

	If I verify variable "mobile_devcod" is assigned
		And I assign $mobile_devcod to variable "devcod"
	EndIf
  
	#When is Long Work Assignment the vehicle type must be CB


After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@ABB-PCK-08
Scenario Outline: ABB-PCK-08 Outbound Mobile Pick Directed NP6
CSV Examples:Test Case Inputs/ABB INPUTS NP6/ABB-PCK-08P.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "login to the Mobile App, assign work, and traverse to directed work menu"
	And I execute scenario "Mobile Login"
    And I execute scenario "Mobile Navigate to Directed Work Menu"

When I "perform verify the type of pick and perform the pick"
	If I verify text $oprcod is equal to "LPCK"
		And I execute scenario "Mobile Perform Directed List Pick"
    Elsif I verify text $oprcod is equal to "PCK"
    	Then I execute scenario "Mobile Perform Pallet Pick for Order"
    EndIf
    
Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"