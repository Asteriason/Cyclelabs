############################################################
# Copyright 2024, Netlogistik
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
# Test Case: ABB-INV-02 Change Inventory Status
#
# Functional Area: Inventory
# Author: NetLogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: MOCA, WEB
#
# Description:
# This test case will change the Inventory Status from the Web
#
# Input Source: Test Case Inputs/ABB Inputs/ABB-INV-02.csv
# Required Inputs:
# 	stoloc - Location where the adjustment will take place. Must be a valid adjustable location in the system
# 	lodnum - Load number being adjusted in. Can be a fabricated number. Used in Terminal/WEB and datasets processing
# 	prtnum - Needs to be a valid part number that is assigned in your system
#	newinvsts - New Inventory Status. Used to set the inventory to this status
#	reacodfull - Reason Code Full. Used for the reason code of the inventory status change. Must be full description
# Optional Inputs:
# None
#
# Assumptions:
# None
#
# Notes:
# None
#
############################################################ 
Feature: ABB-INV-02 Change Inventory Status NP5
 
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

	And I assign "ABB-INV-02" to variable "test_case"
	When I execute scenario "Test Data Triggers"

 
After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@ABB-INV-02
Scenario Outline: ABB-INV-02 Inventory Status Change
CSV Examples: Test Case Inputs/ABB Inputs NP5/ABB-INV-02.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "login into the web and navigate to the inventory screen"
	And I execute scenario "Web Login"
	And I execute scenario "Web Open Inventory Screen"
    
When I execute scenario "Web Inventory Status Change"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"