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
# Test Case: ABB-CST-15 Change Carrier NP6.feature
# 
# Description:
# This test case will change carrier if necessary
#
# Input Source: Test Case Inputs/ABB INPUTS NP6/ABB-CST-15.csv
# Required Inputs:
#   carcod, ordnum, service level
# Optional Inputs:
#	None
#
# Assumptions:
#
#
############################################################ 
Feature: ABB-CST-15 Change Carrier NP6

Background: 
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################
Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Web/Web Outbound Planner Utilities.feature"
    And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Web Outbound Trailer Imports"
	And I execute scenario "Web Environment Setup"

	Then I assign "ABB-NP6-15" to variable "test_case"
	When I execute scenario "Test Data Triggers"
    And I assign "FALSE" to variable "auto_close_flag"

 
After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@ABB-OUT Change Carrier
Scenario Outline: ABB-CST-15
CSV Examples:Test Case Inputs/ABB INPUTS NP6/ABB-CST-15.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "login to the Web and navigate to the Inbound Shipments Screen"
	Then I execute scenario "Web Login"
    Then I execute scenario "Web Navigate to Order Payterm Maintenance NP6"
	And I "search for order"
	Then I assign "order number" to variable "component_to_search_for"
	And I assign $ordnum to variable "string_to_search_for"
	Then I execute scenario "Web Component Search"
	Then I execute scenario "Web Navigate to Change Carrier"