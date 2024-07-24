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
# Test Case: ABB-WAV-10 Packing And Manifest Close.feature
# 
# Functional Area: Outbound
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: regression
# Blue Yonder Interfaces Interacted With: WEB, MOCA
# 
# Description:
# This Test Case packs all the LPNs and move to the shipping stage to search the manifest and close it
# 
# Input Source: Test Case Inputs/ABB INPUTS/ABB-WAV-10.csv
# Required Inputs:
#   ordnum - Order number when creating the order to be loaded onto the trailer. Must not match any existing ordnum in the warehouse
# 	wave_num - This will be used as the wave number for the shipment when creating carton pick data
#	alc_destination_zone - Allocation destination location
#	trlr_num - This will be used as the trailer number when receiving by Trailer. If not, this will be the Receive Truck and Invoice Number
#	yard_loc - 	If receiving by Trailer, this is where your Trailer needs to be checked
#	ui_move_id - Load ID to use in the web when creating a new load	
#	ship_id	- This will be used as the ship_id when creating carton/ list pick data
#	carcod - Carrier code of the trailer
#	schbat1	- wave number
#	wrkarea	- work area to be set
#	mobile_start_loc - this is the code for Mobile Start Location
#
# Optional Inputs:
#	None
#
# Assumptions:
# - User has permissions for functions
#
# Notes:
# None
#
############################################################ 
Feature: ABB-WAV-10 Packing And Manifest Close
 
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

After Scenario: 
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@ABB-WAV-10
Scenario Outline: ABB-WAV-10 Packing And Manifest Close
CSV Examples: Test Case Inputs\ABB INPUTS NP6\ABB-WAV-10.csv

Then I "log into the Web and navigate to Outbound Screen"
	And I execute scenario "Web Login"
        When I execute scenario "Web Navigate to Parcel Screen"
        Then I execute scenario "Web Click Manifests Tab"
        And I execute scenario "Web Close Manifest Shipment"
    