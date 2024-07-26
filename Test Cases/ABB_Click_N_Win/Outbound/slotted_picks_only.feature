Feature: Picking ABB

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
	Then I execute scenario "Web Outbound Trailer Imports"
	Given I execute scenario "Mobile Picking Imports"
	And I execute scenario "Web Environment Setup"

	Then I assign "Picking-ABB" to variable "test_case"
	When I execute scenario "Test Data Triggers"

	And I assign "SPCK" to variable "oprcod"
	And I assign "DPJ" to variable "vehtyp"
 
After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################

Given I "perform test completion activities including logging out of the interfaces"
Then I execute scenario "Test Completion"

@Picking-ABB
Scenario: Picking-ABB
#CSV Examples: Test Case Inputs\outbound_hp.csv

Given I "execute pre-test scenario actions (including pre-validations)"
And I execute scenario "Begin Pre-Test Activities"


And I "log in mobile to pick"
When I execute scenario "Mobile Login"
And I wait $worker_wait seconds
And I execute scenario "Mobile Navigate to Directed Work Menu"
Then I execute scenario "Select Picking Process"

Then I "execute post-test scenario actions (including post-validations)"
And I execute scenario "End Post-Test Activities"