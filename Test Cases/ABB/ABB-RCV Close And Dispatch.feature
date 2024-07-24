############################################################
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
# Test Case: ABB-LDG Close And Dispatch
# 
# Description:
# This test case will handle loading a trailer in the Web
#
# Input Source: Test Case Inputs/BASE-LDG-1010.csv
# Required Inputs:
#   trlr_id - This will be used as the trailer ID for the trailer
# Optional Inputs:
#	None
#
# Assumptions:
# - Sufficient pickable and shippable inventory for the order
# - Dock door for the dataset is an open and usable dock door
# - The trailer has a single stop assigned and the stop is fully picked and staged
# - Load trailer function will utilize move immediately rather than work queue for loading
#
############################################################ 
Feature: BASE-LDG-1010 Web Outbound Trailer Load

Background: 
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Web Receiving Imports"
	And I execute scenario "Web Environment Setup"

	Then I assign "BASE-RCV-1010" to variable "test_case"
	When I execute scenario "Test Data Triggers"

	And I assign $trlr_num to variable "trknum"
    And I assign "FALSE" to variable "auto_close_flag"

 
After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@BASE-LDG-1010
Scenario Outline: ABB-LDG Close And Dispatch
CSV Examples: Test Case Inputs/ABB-1010.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "login to the Web and navigate to the Inbound Shipments Screen"
	Then I execute scenario "Web Login"
And I "create xpaths"
	When I execute scenario "Create local xPaths"
    
	And I execute scenario "Web Perform Close And Dispatch"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"