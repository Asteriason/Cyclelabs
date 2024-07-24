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
# Test Case: ABB-RCV-07 Store-Pallet Work Directed NP2.feature
#
# Functional Area: Outbound
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: regression
# Blue Yonder Interfaces Interacted With: WEB, MOCA
#
# Description:
# This Test Case loads an order, plans a wave, creates a load and assigns a stop to it via MSQL. It then removes stop from the load in the Web
#
# Input Source: Test Case Inputs/ABB INPUTS NP2/ABB-RCV-07.csv
# Required Inputs:
#   oprcod - This will be used to validate the type of operation performed
#   vehtyp - Vehicle type
#   ordnum - Order number when creating the order to be loaded onto the trailer. Must not match any existing ordnum in the warehouse
#  
# Optional Inputs:
#   None
#
# Assumptions:
# - User has permissions for functions
#
# Notes:
# None
#
############################################################
Feature: ABB-RCV-07 Store-Pallet Work Directed NP6
 
Background:
 
Given I "setup the environment"
    Then I assign all chevron variables to unassigned dollar variables
    And I import scenarios from "Utilities/Base/Environment.feature"
    When I execute scenario "Set Up Environment"
 
    Given I execute scenario "Mobile Receiving Imports"
 
    Then I assign "ABB-RCV-07" to variable "test_case"
    When I execute scenario "Test Data Triggers"
 
 
    If I verify variable "mobile_devcod" is assigned
        And I assign $mobile_devcod to variable "devcod"
    EndIf
 
    #And i assign "DK001-182" to variable "mobile_start_loc"
   
After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################
 
Given I "perform test completion activities including logging out of the interfaces"
    Then I execute scenario "Test Completion"
 
@ABB-RCV-07
Scenario Outline: ABB-RCV-07 Store-Pallet Work Directed
CSV Examples:Test Case Inputs/ABB INPUTS NP6/ABB-RCV-07.csv
 
Given I "execute pre-test scenario actions (including pre-validations)"
    And I execute scenario "Begin Pre-Test Activities"
 
Then I "login to the Mobile App, assign work, and traverse to directed work menu"
    And I execute scenario "Mobile Login"
    And I execute scenario "Mobile Navigate to Directed Work Menu"
    And I execute scenario "Process Store-Pallet"