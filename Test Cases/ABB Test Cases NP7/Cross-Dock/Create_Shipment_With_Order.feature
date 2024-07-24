Feature: Generate Inbound Shipment With Order

Background:
	############################################################
	# Description: Imports dependencies, sets up the environment.
	#############################################################

	Given I "setup the environment"
	Then I assign all chevron variables to unassigned dollar variables
	And I import scenarios from "Utilities/Base/Environment.feature"
	When I execute scenario "Set Up Environment"

	Then I assign values in row 1 from "Test Case Inputs\ABB INPUTS NP7\XDCK\create_inbound_shipment_and_order.csv" to variables


@ABB-RCV-01
Scenario: Receive Inbound Shipment With Order

Given I "Create an inbound shipment" 
    When I execute MOCA script "Scripts\MSQL_Files\Custom\create_trknum.msql"
    And I verify MOCA status is 0

Then I "Create an order for that inbound shipment"
    Given I execute MOCA command "get datetime with milliseconds"
    And I assign row 0 column "datetimemilli" to variable "adddte"
    And I execute MOCA script "Scripts\MSQL_Files\Custom\create_inbound_order.msql"
    Then I verify MOCA status is 0

Then I "create the order lines"
    While I assign values in next row from "Test Case Inputs\ABB INPUTS NP7\XDCK\inbound_order_lines.csv" to variables
        Then I execute MOCA script "Scripts\MSQL_Files\Custom\create_inbound_order_line.msql"
        And I verify MOCA status is 0
    EndWhile


