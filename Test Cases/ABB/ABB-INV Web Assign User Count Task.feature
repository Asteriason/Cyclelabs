############################################################
############################################################ 
# Test Case: ABB-INV-1020 Web Assign User Count Task.feature
# Description:
# This test assigns Count work to user from the work queue
# Optional Inputs:
#	None
#
# Assumptions:
# - User has permissions for functions
#
# Notes:
# 	None
#
############################################################ 
Feature: ABB-INV-1020 Web Assign User Count Task
 
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
	And I execute scenario "Replenishment Imports"
   
	And I assign "ABB-INV-1020" to variable "test_case"
	When I execute scenario "Test Data Triggers"

	When I assign "ABC Cycle Count" to variable "wqoperation"
	And I assign "016-021-B-B" to variable "palloc"
	Then I assign "CL_TEST3" to variable "userlogin"

After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"


@ABB-INV-1020
Scenario Outline: ABB-INV-1020 Web Assign User Count Task
CSV Examples: Test Case Inputs/ABB-1010.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "log into the Web and navigate to Outbound Planner Work Queue Screen"
	And I execute scenario "Web Login NP2"
	And I execute scenario "Web Navigate to Outbound Planner Work Queue Screen"

When I "search task and assign user"
	And I execute scenario "Web Search Count Task in Work Queue"
	And I execute scenario "Assign User From Actions Button"
    
Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"