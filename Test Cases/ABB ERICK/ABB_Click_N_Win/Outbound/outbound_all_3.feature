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
# Test Case: outbound_all_3.feature
#
# Functional Area: Outbound
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: regression
# Blue Yonder Interfaces Interacted With: WEB, MOCA
#
# Description:
# This test case will be doing the outbound process. Outbound LTL Pt2, Outbound Parcel Pt2
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
# 	None
#
# Assumptions:
# None
#
# Notes:
# None
#
############################################################
Feature: Outbound All Pt3

	Background:
		############################################################
		# Description: Imports dependencies, sets up the environment.
		#############################################################

		Given I "setup the environment"
		Then I assign all chevron variables to unassigned dollar variables
		And I import scenarios from "Utilities/Base/Environment.feature"
		When I execute scenario "Set Up Environment"

		Given I execute scenario "Outbound Planner Imports"
		Then I execute scenario "Wave Imports"
		Given I execute scenario "Mobile Picking Imports"
		Given I execute scenario "Web Outbound Trailer Imports"
		And I execute scenario "Web Environment Setup"
		And I import scenarios from "Utilities\Base\Web\Web Outbound Packing Utilities.feature"

		Then I assign "ABB-SHP-01" to variable "test_case"
		When I execute scenario "Test Data Triggers"

		Given I execute MOCA script "Scripts/MSQL_Files/Base/get_ship_id.msql"
		And I assign row 0 column "ship_id" to variable "ship_id"

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
	CSV Examples: Test Case Inputs\ABB INPUTS\ABB INPUTS ERICK\ABB_Click_N_Win\Outbound\outbound_all.csv

	Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

	Then I execute MOCA script "Scripts/MSQL_Files/Custom/Create_Trailer.msql" 
	And I verify MOCA status is 0
	
	Then I "log into the Web and navigate to Outbound Screen"
	And I execute scenario "Web Login"

	Once I verify text $process_name is not equal to ""
	Then I "perform LTL or parcel"
	When I execute scenario "Outbound LTL Pt2"
	Then I execute scenario "Outbound Parcel Pt2"

	Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"