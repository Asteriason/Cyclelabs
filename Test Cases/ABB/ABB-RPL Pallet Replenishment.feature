Feature: ABB-PCK Pallet Replenishment

Background:

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Mobile Replenishment Imports"

	If I verify variable "mobile_devcod" is assigned
		And I assign $mobile_devcod to variable "devcod"
	EndIf
  
    Then I assign "033-042-C-A-189" to variable "mobile_start_loc"
    # LPCK=PJ  PCK=RT
    Then I assign "RT" to variable "vehtyp"


After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@BASE-PCK-4050
Scenario Outline: ABB-RPL Pallet Replenishment
CSV Examples:Test Case Inputs/ABB-PCK-4050.csv

Then I "login to the Mobile App, assign work, and traverse to directed work menu"
	And I execute scenario "Mobile Login"
    And I execute scenario "Mobile Navigate to Directed Work Menu"

When I "perform pallet replenishment"
	And I execute scenario "Mobile Perform Pallet Replenishment"

