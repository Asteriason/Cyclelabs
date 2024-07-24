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
# Test Case: outbound_all_2.feature
#
# Functional Area: Inventory, Outbound
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Regression
# Blue Yonder Interfaces Interacted With: Mobile, MOCA
#
# Description:
# This test case will be doing the outbound process. Mobile Navigate to Inventory Transfer Menu,
# Mobile Stage Picked LPNs
#
# Input Source: Test Case Inputs\ABB_Click_N_Win\Outbound\outbound_all.csv
#
# Required Inputs:
# 	ordnum - This will be used as the ordnum when creating the order
#	wave_num - Wave number to be created
#	alc_destination_zone - Allocation destination location
#	alc_staging_lane - Allocation staging lane
#	alc_wave_priority - Allocate Wave priority
# 	trlr_num - This will be used as the trailer num
#	yard_loc - This will be used as the yard loc
#	ui_move_id - Load ID to use in the web when creating a new load
#	ship_id - This will be used as the ship_id when creating the shipment
#	carcod - This will be used as the carrier for the shipment
#	eqtype - Fill with the Equipment type
#	dock - This will be used as the dock location for the trailer
#	carrier - Fill with the assign carrier for the order
#	schbat1 - Wave number
#	wrkarea - work area to be set
#	mobile_start_loc - this is the code for Mobile Start Location
#	userlogin - user name who's going to be assigned the work
#	process_name - Fill in with the process that will be carried out
#	process_type - Fill in the type of process that will be carried out
# 	oprcod - This will be used to validate the type of operation performed
#   vehtyp - Vehicle type
#	cancel_and_reallocate - Will cancel the List Pick and reallocate if set to "true"
# 	srcloc - The source location of the LPN (load number) to be moved. Must be a valid adjustable/storable location
#	inventory_move_mode - set to IMMEDIATE for this test
#	generate_screenshot - generate screenshot of inventory display screen
#	wrong_dest_lpn - set TRUE if a test will be done with a wrong destination for the LPN, FALSE to inactivate this test
#	value_wrong_dest_lpn - If the wrong destination is tested, the location for the test must be indicated.
#	source_lpn_wrong - set TRUE if a test will be done with an incorrect source, FALSE to inactivate this test
#	value_source_lpn_wrong - if the incorrect source test is performed, this value must be captured
#	sku_wrong - if incorrect sku test is performed capture TRUE, otherwise use FALSE to inactivate this test.
#	value_sku_wrong - capture value of incorrect sku to perform the test if necessary
#	extra_pick - indicate TRUE if a test will perform with a quantity greater than the requested by the system for pick, FALSE to inactivate this test
#	value_extra_pick - capture the value of the extra amount to receive in case of performing the extra pick test
#
# Optional Inputs:
#	None
#
# Assumptions:
# - Regression runs require parts and enough config to deposit inventory into the destination location.
# - Processing will handle standard LPN flow for blind receipts, over receipts, multi-client, multi-wh, lot tracking, aging, qa directed
# - Process ends with the inventory being moved to assign dstloc
#
# Notes:
# None
#
############################################################
Feature: ABB-INV-09 Outbound Stage Picked LPNs

Background:
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################

Given I "setup the environment"
Then I assign all chevron variables to unassigned dollar variables
And I import scenarios from "Utilities/Base/Environment.feature"
When I execute scenario "Set Up Environment"

Given I execute scenario "Mobile Inventory Imports"

Then I assign "ABB-INV-09" to variable "test_case"
When I execute scenario "Test Data Triggers"

After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
Then I execute scenario "Test Completion"

@ABB-INV-09
Scenario Outline: ABB-INV Stage Picked LPNs
CSV Examples: Test Case Inputs\ABB INPUTS\ABB INPUTS ERICK\ABB_Click_N_Win\Outbound\outbound_all.csv

	Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"
	If I verify text $process_name is not equal to "parcel"
	Then I "login to the Mobile App"
	And I execute scenario "Mobile Login"

	When I "navigate to the transfer screen and perform transfer"
	Then I execute scenario "Mobile Navigate to Inventory Transfer Menu"
	And I execute scenario "Mobile Stage Picked LPNs"
	EndIf
	Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"