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
# Test Case: ABB-WAV-02 Outbound Plan Wave.feature
# 
# Functional Area: Allocation
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: regression
# Blue Yonder Interfaces Interacted With: WEB, MOCA
# 
# Description:
# This Test Case loads an order and inventory then plans and allocates a wave in the Web
# 
# Input Source: Test Case Inputs/ABB INPUTS/ABB-WAV-02.csv
# Required Inputs:
#	ordnum - Order number to be found
#	wave_num - Wave number to be created
#
# Optional Inputs:
#	alc_destination_zone - Allocation destination location
#
# Assumptions:
# - User has permissions for functions
#
# Notes:
# - Test Case Inputs (CSV) - Examples:
#	Example Row: Allocate Wave with standard allocation
#	Example Row: Allocaton specifiying specific allocation destination_zone, staging_lane, and uoms
#
############################################################ 
Feature: ABB-WAV-02 Outbound Plan Wave PR5
 
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

	And I assign "ABB-WAV-02" to variable "test_case"
	When I execute scenario "Test Data Triggers"

	Then I assign "alc_destination_zone" to variable "alc_destination_zone"
	#And I assign "2TX-JAN31" to variable "schbat1"

After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

#And I "cleanup the dataset"
	#Then I assign "Ord_Allocate_Wave" to variable "cleanup_directory"
	#And I execute scenario "Perform MOCA Cleanup Script"
 
@ABB-WAV-02
Scenario Outline: ABB-WAV-02 Outbound Allocate Wave
CSV Examples: Test Case Inputs/ABB INPUTS NP6/ABB-WAV-02.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I execute scenario "Web Login"
And I execute scenario "Web Plan Wave"


Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"