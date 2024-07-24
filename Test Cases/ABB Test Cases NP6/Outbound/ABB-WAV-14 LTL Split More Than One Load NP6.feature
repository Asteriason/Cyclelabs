Feature: ABB-Outbound-LTLMoreThanOneLoad-SplitShipment
 
Background:
############################################################
# Description: Imports dependencies, sets up the environment.
#############################################################
 
Given I "setup the environment"
    Then I assign all chevron variables to unassigned dollar variables
    And I import scenarios from "Utilities/Base/Environment.feature"
    When I execute scenario "Set Up Environment"
 
    Given I execute scenario "Wave Imports"
    #Then I execute scenario "Replenishment imports"
    And I execute scenario "Outbound Planner Imports"
    And I execute scenario "Inventory Adjust Imports"
    Then I execute scenario "Web Environment Setup"
 
    And I assign "ABB-WAV-05" to variable "test_case"
    When I execute scenario "Test Data Triggers"
    And I assign $wave_num to variable "lodnum"
    Given I execute groovy "lodnum_changed = lodnum.replaceFirst('-', '')"
    
After Scenario:
#############################################################
# Description: Logs out of the interface and cleans up the dataset
#############################################################
 
Given I "perform test completion activities including logging out of the interfaces"
    Then I execute scenario "Test Completion"
 
@ABB-Outbound-LTLMoreThanOneLoad-SplitShipment

Scenario Outline: Outbound-LTLMoreThanOneLoad-SplitShipment
CSV Examples: Test Case Inputs\ABB INPUTS\LTL-MTOL-ALL.csv
 
Given I "execute pre-test scenario actions (including pre-validations)"
    And I execute scenario "Begin Pre-Test Activities"
 
Then I execute scenario "Web Login"
####update
And I execute scenario "Web Navigate to Outbound Planner Outbound Screen"
And I execute scenario "Web Create Load for LTL More Than One Load"