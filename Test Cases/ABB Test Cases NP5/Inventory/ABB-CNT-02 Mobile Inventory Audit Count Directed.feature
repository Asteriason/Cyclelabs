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
# Test Case: ABB-CNT-02 Mobile Inventory Audit Count Directed.feature
#
# Functional Area: Inventory
# Author: Tryon Solutions
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: Mobile, MOCA
#
# Description: This test case performs a audit count in the Mobile App
#
# Input Source: Test Case Inputs/ABB-CNT-02.csv
# Required Inputs:
# 	stoloc - Where the adjustment will take place. Must be a valid adjustable location in the system
# 	lodnum - Load number being adjusted in. Can be a fabricated number. Used in Mobile App and datasets processing.
# 	prtnum - Needs to be a valid part number that is assigned in your system
# 	untqty - Inventory quantity being added
# 	reacod - System reason code for adjustment. Must exist as a valid reason code in the system
# 	invsts - Inventory status. This needs to be a valid inventory status in your system
# 	lotnum - Lot Number. This needs to be a valid lot/lot format based on config
#	adjref1 - Adjustment reference 1 (defaults to stoloc value)
#	adjref2 - Adjustment reference 2 (defaults to prtnum value)
#	actcod - Activity Code. Used by 'create inventory' command
#	cnt_sysdate - Used as the schedule date during dataset count batch creation
#	cntbat - Used to name the count batch
#	cnttyp - type of count (A)
#	cnt_qty - audit count quantity (value specified in count) to use for the test
# Optional Inputs:
# None
#
# Assumptions:
# - This test case loads inventory into a location and performs an audit count in the Mobile App
# - Note that user permissions must all be set up to run successfully
# - This test does create inventory to be counted in the dataset, but does require serialized parts in the WMS
# 
# Notes:
# - Test Case Inputs (CSV) - Examples:
#	Example Row: Run with serialized part and cnt_qty = inventory untqty
#	Example Row: Run with serialized part and inventory untqty + 1
#	Example Row: Run with serialized part and inventory untqty - 1
# 	Example Row: Run with audit cnt_qty = inventory untqty
#	Example Row: Run with with audit cnt_qty = inventory untqty - 1
#	Example Row: Run with audit cnt_qty = inventory untqty + 1
#
############################################################ 
Feature: ABB-CNT-02 Mobile Inventory Audit Count Directed
 
Background:
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Mobile Count Imports"

	Then I assign "ABB-CNT-02" to variable "test_case"
	When I execute scenario "Test Data Triggers"

After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@ABB-CNT-02
Scenario Outline: ABB-CNT-02 Mobile Inventory Audit Count Directed
CSV Examples: Test Case Inputs\ABB INPUTS NP5\ABB-CNT-AUDIT.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "log into the Mobile App"
	Then I execute scenario "Mobile Login"

And I "assign work and naviate to menu"
	Then I execute scenario "Assign Work to User by Count Batch and Count Type"
    And I execute scenario "Mobile Navigate to Directed Work Menu"
    And I execute scenario "Mobile Inventory Count Process Directed Work Screen"

When I "perform the audit count"
	Then I execute scenario "Mobile Inventory Audit Count Enter Location Directed Work"
	And I execute scenario "Mobile Inventory Audit Count Perform Count"
	And I execute scenario "Mobile Inventory Audit Count Complete Count"
    And I execute scenario "Mobile Exit Directed Work Mode"
    
And I "validate the audit count was successful"
	Then I execute scenario "Inventory Audit Count Check Inventory"
	And I execute scenario "Inventory Audit Count Check Tables"

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"