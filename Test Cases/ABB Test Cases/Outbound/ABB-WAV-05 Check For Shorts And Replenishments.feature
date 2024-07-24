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
# Test Case: ABB-WAV-05 Check For Shorts and Replenishments.feature
# Functional Area: Outbound
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: regression
# Blue Yonder Interfaces Interacted With: WEB, MOCA
# 
# Description:
# This test case will create a new load in the Web
#
# Input Source: Test Case Inputs/ABB INPUTS/ABB-WAV-03.csv
# Required Inputs:
# 	trlr_num - This will be used as the trailer num 
#	yard_loc - This will be used as the yard loc
#   wave_num - This will be used as the wave number
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
##########################################################

Feature: ABB-WAV-05 Check For Short and Replenishment Wave
 
Background:
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################
 
Given I "setup the environment"
    Then I assign all chevron variables to unassigned dollar variables
    And I import scenarios from "Utilities/Base/Environment.feature"
    When I execute scenario "Set Up Environment"

    Given I execute scenario "Wave Imports"
    And I execute scenario "Outbound Planner Imports"
    And I execute scenario "Inventory Adjust Imports"
    Then I execute scenario "Web Environment Setup"

    #Assign replenishment imports
    Given I execute scenario "Outbound Planner Imports"
    And I execute scenario "Web Environment Setup"
	And I execute scenario "Replenishment Imports"

    #Pallet replenishment imports
 	Given I execute scenario "Mobile Replenishment Imports"

	If I verify variable "mobile_devcod" is assigned
		And I assign $mobile_devcod to variable "devcod"
	EndIf

    #Assign variables for mobile
    And I assign "CL_TEST3" to variable "userlogin"
    Then I assign "033-042-C-A-189" to variable "mobile_start_loc"
    # LPCK=PJ  PCK=RT
    Then I assign "RT" to variable "vehtyp"

    And I assign "ABB-WAV-05" to variable "test_case"
    When I execute scenario "Test Data Triggers"
 
 
After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################
 
Given I "perform test completion activities including logging out of the interfaces"
    Then I execute scenario "Test Completion"
 
@ABB-WAV-05
Scenario Outline: ABB-WAV-05 Check For Short And Replenishments
CSV Examples: Test Case Inputs/ABB INPUTS/ABB-WAV-05.csv
#CSV Examples: Test Case Inputs\ABB INPUTS\LTL-MTOL-ALL.csv
 
Given I "execute pre-test scenario actions (including pre-validations)"
    And I execute scenario "Begin Pre-Test Activities"
 
Then I execute scenario "Web Login"
And I execute scenario "Web Navigate to Picking Waves and Picks"
 
Once I see "Waves" in web browser
        Then I execute scenario "Web Wave info"
        And I execute scenario "Check for shorts"
        And I execute scenario "Move inventory in case of shorts"
        And I execute scenario "Web Navigate to Picking Waves and Picks"
        And I execute scenario "Check for replenishments"