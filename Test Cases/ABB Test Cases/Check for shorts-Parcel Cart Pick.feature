Feature: OUT03 - Check For Short and Replenishment Wave
 
Background:
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################
 
Given I "setup the environment"
    Then I assign all chevron variables to unassigned dollar variables
    And I import scenarios from "Utilities/Base/Environment.feature"
    #And I import scenarios from "Utilities/Native App Utilities.feature"
    When I execute scenario "Set Up Environment"
 
    #Given I execute scenario "Wave Imports"
    #Then I execute scenario "Replenishment imports"
    #And I execute scenario "Outbound Planner Imports"
    #And I execute scenario "Inventory Adjust Imports"
    #Then I execute scenario "Web Environment Setup"
    #And I execute scenario "Native App Set Up Environment"
 
    And I assign "OUT03" to variable "test_case"
    When I execute scenario "Test Data Triggers"
 
 
After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################
 
Given I "perform test completion activities including logging out of the interfaces"
    Then I execute scenario "Test Completion"
 
 
@OUT03
Scenario Outline: OUT03 - Check For Short and Replenishment Wave
CSV Examples: Test Case Inputs/ABB Inputs/ABB-INV-04.csv
 
#Given I "execute pre-test scenario actions (including pre-validations)"
#    And I execute scenario "Begin Pre-Test Activities"
 
#Then I execute scenario "Web Login"
#And I execute scenario "Web Navigate to Picking Waves and Picks"
 
#Once I see "Waves" in web browser
#        Then I execute scenario "Web Wave info"
#        And I execute scenario "Check for pending replens"
#        And I execute scenario "Check for shorts"