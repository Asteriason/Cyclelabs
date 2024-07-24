Feature: Web Outbound Packing Utilities

@wip @public
Scenario: Web Navigate to Packing Screen

#############################################################
# Description: Use Web Search to navigate to Outbound Packing Screen
# MSQL Files:
#	None
# Inputs:
# 	Required:
#		None
#	Optional:
#		None
# Outputs:
#	None
#############################################################

Given I "open the Outbound Plannner screen"
	Then I assign "Packing" to variable "wms_screen_to_open"
	And I assign "ABB Packing" to variable "wms_parent_menu"
	Then I execute scenario "Web Screen Search"

@wip @public
Scenario: Web Select Workstation
#############################################################
# Description: This scenario selects the order to plan
# MSQL Files:
#	None
# Inputs:
#	Required:
#		ordnum - Order number
#	Optional:
#		None
# Outputs:
#	load_next_button
#	load_finish_button
#	or_button
#############################################################

When I assign "xPath://tr[starts-with(@id, 'gridview-') and .//div[contains(text(), 'PARCEL-PACK-001')]]" to variable "elt"
If I see element $elt in web browser within $max_response seconds 
    Then I click element $elt in web browser 
    And I wait $wait_short seconds
    Then I click element "xPath://span[text()='Save']/.." in web browser 
    And I wait $wait_med seconds 
EndIf

@wip @public
Scenario: Web Enter Subnum
#############################################################
# Description: This scenario selects the order to plan
# MSQL Files:
#	None
# Inputs:
#	Required:
#		subnum
#	Optional:
#		None
# Outputs:
#	load_next_button
#	load_finish_button
#	or_button
#############################################################

Given I assign "xPath://input[starts-with(@id, 'textfield-') and @name='identifier'] " to variable "elt"
Once I see element $elt in web browser
And I type $subnum in element $elt in web browser within $wait_med seconds
Then I press keys "ENTER" in web browser
And I wait $wait_med seconds 


@wip @public
Scenario: Web Outbound Complete Packing
#############################################################
# Description: This scenario selects the order to plan
# MSQL Files:
#	None
# Inputs:
#	Required:
#		ordnum - Order number
#	Optional:
#		None
# Outputs:
#	load_next_button
#	load_finish_button
#	or_button
#############################################################

Once I see "Packing From:" in web browser 
Then I "select the item"
    When I click element "xPath://div[starts-with(@id,'gridcolumn-')]/descendant::span[contains(@class,'x-column-header-text')]" in web browser 
    And I wait $wait_short seconds 

Then I "Process and complete"
    When I click element "xPath://a[span/span/span[starts-with(@id, 'button-') and text()='Process']]" in web browser 
    Then I wait $wait_short seconds
    And I click element "xPath://a[contains(@class, 'x-btn') and .//span[text()='Complete']]" in web browser 

And I "confirm packing"
    If I see element "xPath://div[starts-with(@id, 'messagebox-') and text()='Shipping Label Printed']" in web browser within $max_response seconds
    	Then I click element "xPath://span[text()='OK']/.." in web browser 
    EndIf
    If I see element "xPath://label[starts-with(@id, 'textfield-') and contains(., 'Scan identifier to get started')]" in web browser within $max_response seconds
    Then I echo "Packing Complete"
    EndIf 


@wip @public
Scenario: Web Navigate to Parcel Screen

#############################################################
# Description: Use Web Search to navigate to Outbound Packing Screen
# MSQL Files:
#	None
# Inputs:
# 	Required:
#		None
#	Optional:
#		None
# Outputs:
#	None
#############################################################

Given I "open the Parcel screen"
	Then I assign "Parcel" to variable "wms_screen_to_open"
	And I assign "ABB Shipping" to variable "wms_parent_menu"
	Then I execute scenario "Web Screen Search"



@wip @public
Scenario: Web Click Manifests Tab
#############################################################
# Description: This scenario selects the order to plan
# MSQL Files:
#	None
# Inputs:
#	Required:
#		ordnum - Order number
#	Optional:
#		None
# Outputs:
#	load_next_button
#	load_finish_button
#	or_button
#############################################################

Once I see "Parcel Activity" in web browser 
Then I "click the manifests tab"
    When I click element "xPath://span[starts-with(@id, 'button-') and text()='Manifests']//.." in web browser 
    And I wait $wait_short seconds 

@wip @public
Scenario: Web Close Manifest Shipment
#############################################################
# Description: This scenario selects the order to plan
# MSQL Files:
#	None
# Inputs:
#	Required:
#		ordnum - Order number
#	Optional:
#		None
# Outputs:
#	load_next_button
#	load_finish_button
#	or_button
#############################################################

When I "search for shipment"
	Then I assign "shipment" to variable "component_to_search_for"
    And I assign $ship_id to variable "string_to_search_for"
	And I execute scenario "Web Component Search"

And I "select the shipment"
	Once I see element "xPath://div[@class='x-grid-row-checker']" in web browser
    When I click element "xPath://div[@class='x-grid-row-checker']" in web browser 
    And I wait $wait_med seconds 

And I "close manifest"
	Once I see element "xPath://a[contains(@class, 'x-btn') and .//span[text()='Close Manifest']]" in web browser
    When I click element "xPath://a[contains(@class, 'x-btn') and .//span[text()='Close Manifest']]" in web browser 
    And I wait $wait_med seconds 
    If I see element "xPath://div[starts-with(@id, 'messagebox-') and text()='Are you sure you want to close the selected manifest(s)?']" in web browser within $max_response seconds
      Then I click element "xPath://span[text()='Yes']/.." in web browser
      And I wait $wait_med seconds 
    EndIf
    If I see element "xPath://div[starts-with(@id, 'messagebox-') and text()='The selected manifest(s) closed successfully.']" in web browser within $max_response seconds
      Then I click element "xPath://span[text()='OK']/.." in web browser 
      And I wait $wait_med seconds
    EndIf

@wip @public
Scenario: Web Perform Packing and Manifest Close
#############################################################
# Description: This scenario selects the order to plan
# MSQL Files:
#	None
# Inputs:
#	Required:
#		ordnum - Order number
#	Optional:
#		None
# Outputs:
#	load_next_button
#	load_finish_button
#	or_button
#############################################################

Given I execute moca script "Scripts\MSQL_Files\Custom\count_subnums.msql"
When I verify MOCA status is 0
And I assign row 0 column "total_count" to variable "max_count"
And I assign 0 to variable "counter"
While I verify number $counter is less than $max_count
    Given I "setup the data"
        When I execute moca script "Scripts\MSQL_Files\Custom\get_subnums.msql"
        Then I assign row $counter column "ship_id" to variable "ship_id"
        And I assign row $counter column "subnum" to variable "subnum"
    
    Then I "Perform Packing"
        When I execute scenario "Web Navigate to Packing Screen"
        When I execute scenario "Web Select Workstation"
        When I execute scenario "Web Enter Subnum"
        When I execute scenario "Web Outbound Complete Packing"
    
    And I "Manifest Close"
        When I execute scenario "Web Navigate to Parcel Screen"
        Then I execute scenario "Web Click Manifests Tab"
        And I execute scenario "Web Close Manifest Shipment"
    
    And I increase variable "counter" by 1
EndWhile