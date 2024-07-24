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
# Test Case: ABB-SHIP-01 Outbound Validate Order.feature
#
# Functional Area: Outbound
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: regression
# Blue Yonder Interfaces Interacted With: WEB, MOCA
# 
# Description:
# This test case will load an incoming order and validate from the Web
#
# Input Source: Test Case Inputs/ABB INPUTS/ABB-SHP-01.csv
# Required Inputs:
# 	ordnum - This will be used as the ordnum when creating the order 
#	carcod - This will be used as the carrier for the shipment
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
Feature: ABB-SHP-01 Outbound Validate Order NP5
 
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

	Then I assign "ABB-SHP-01" to variable "test_case"
	When I execute scenario "Test Data Triggers"

#And I "load the dataset"	
	#Then I assign "Web_Outbound_Shipment" to variable "dataset_directory"
	#And I execute scenario "Perform MOCA Dataset"
 
After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

#And I "cleanup the dataset"
#	Then I assign "Web_Outbound_Shipment" to variable "cleanup_directory"
	#And I execute scenario "Perform MOCA Cleanup Script"
 
@ABB-SHP-01
Scenario Outline: ABB-SHP-01 Outbound Validate Order
CSV Examples: Test Case Inputs/ABB INPUTS NP5/ABB-SHP-01.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "log into the Web and navigate to Outbound Screen"
	And I execute scenario "Web Login"
	And I execute scenario "Web Navigate to Outbound Planner Outbound Screen"
    
When I "validate the incoming shipment and screen/system information about the shipment"
	Then I execute scenario "Web Validate Order"
	And I execute scenario "Web Validate Order Info"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"