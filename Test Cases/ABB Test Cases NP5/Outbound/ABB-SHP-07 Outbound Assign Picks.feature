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
# Test Case: ABB-SHP-07 Outbound Assign Picks.feature
# 
# Functional Area: Receiving, Outbound
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: Web, MOCA
#
# Description: This test case will receive/putaway in short, over, and damaged product states
#
# Input Source: Test Case Inputs/ABB INPUTS/ABB-SHP-07.csv
# Required Inputs:
# 	schbat1: This is wave number
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
Feature: ABB-SHP-07 Outbound Assing Picks

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

    And I assign "CL_TEST3" to variable "userlogin"
    #Then I assign "2TX-JAN31" to variable "schbat1"


After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@ABB-SHP-07
Scenario Outline: ABB-SHP-07 Web Assign Picks
CSV Examples: Test Case Inputs\ABB INPUTS\ABB-PARCEL-ALL.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "log into the Web Browser, select workstation, and navigate to the Inbound Shipments Screen"
	Then I execute scenario "Web Login"
	And I execute scenario "Web Navigate to Outbound Planner Work Queue Screen"
    And I execute scenario "Web Assign Picks"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"