Feature: BASE-PCK-4050 Mobile Outbound List Pick Case To Pallet Directed Cancel and Reallocate

Background:

Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Given I execute scenario "Mobile Picking Imports"

	Then I assign "BASE-PCK-4050" to variable "test_case"
	When I execute scenario "Test Data Triggers"

	If I verify variable "mobile_devcod" is assigned
		And I assign $mobile_devcod to variable "devcod"
	EndIf
  
    And I assign "LPCK" to variable "oprcod"
    Then I assign "035-008-A-B-259" to variable "mobile_start_loc"
    # LPCK=PJ  PCK=RT
    Then I assign "PJ" to variable "vehtyp"
    And I assign "FALSE" to variable "cancel_and_reallocate"
    #And I assign "SHP512-492" to variable "dep_loc"


After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
	Then I execute scenario "Test Completion"

@BASE-PCK-4050
Scenario Outline: BASE-PCK-4050 Mobile Outbound List Pick Case To Pallet Directed Cancel and Reallocate
CSV Examples:Test Case Inputs/ABB-PCK-4050.csv

Given I "execute pre-test scenario actions (including pre-validations)"
	And I execute scenario "Begin Pre-Test Activities"

Then I "login to the Mobile App, assign work, and traverse to directed work menu"
	And I execute scenario "Mobile Login NP2"
    And I execute scenario "Mobile Navigate to Directed Work Menu"

When I "perform verify the type of pick and perform the pick"
	If I verify text $oprcod is equal to "LPCK"
		And I execute scenario "Mobile Perform Directed List Pick"
    Elsif I verify text $oprcod is equal to "PCK"
    	Then I execute scenario "Mobile Perform Pallet Pick for Order"
    EndIf

Then I "execute post-test scenario actions (including post-validations)"
	And I execute scenario "End Post-Test Activities"