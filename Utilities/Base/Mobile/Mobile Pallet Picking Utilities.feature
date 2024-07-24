###########################################################
# Copyright 2024, Netlogistik
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
# Utility: Mobile Pallet Picking Utilities.feature
# 
# Functional Area: Picking
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Utility
# Blue Yonder Interfaces Interacted With: Mobile, MOCA
# 
# Description: Utilities to perform Pallet Picking in the Mobile App
#
# Public Scenarios:
#   - Mobile Perform Pallet Pick for Order - Performs all Pallet Picks associated with an Order
#   - Mobile Perform Undirected Pallet Pick for Order - Performs all Pallet Picks via Undirected associated with an Order
#
# Assumptions:
# 	None
#
# Notes:
# - See Scenario Headers for required inputs.
#
############################################################
Feature: Mobile Pallet Picking Utilities

@wip @public
Scenario: Mobile Perform Pallet Pick for Order
#############################################################
# Description: From the Directed Work screen, given an order number/operation code/username, 
# performs the entirety of the associated pallet picks.
# MSQL Files:
#	None
# Inputs:
# 	Required:
#		oprcod - set to the pallet picking operation code
#		username - the user assigned to or user to assign to
#   	ordnum - The order that will be pallet picked
#   Optional:
#		cancel_and_reallocate - Will cancel the Carton Pick and reallocate if set to "true"
# Outputs:
#	None
#############################################################
Given I assign 20 to variable "max_loop_counter"
And I assign 0 to variable "current_count"

Given I "wait some time for pallet picks to release" which can take between $wait_med seconds and $wait_long seconds
 
#Then I "obtain the Work Reference"
	#Then I echo $oprcod
    #And I echo $ordnum
    #And I echo $username
	#And I execute scenario "Get Directed Work Picking Work Reference by Order Number and Operation"
	#If I verify MOCA status is 0
	 #  Then I echo "We have got Pallet Picks"
	#Else I assign variable "error_message" by combining "ERROR: We do not have any Pallet Picks. Exiting...."
	#	Then I fail step with error message $error_message
	#EndIf
 
When I "confirm Directed Work exists"
	If I see "Pickup Product At" in element "className:appbar-title" in web browser within $screen_wait seconds
		Then I echo "I'm good to proceed as there are directed works"
	Else I assign variable "error_message" by combining "ERROR: No Directed Picks found. Exiting..."
		Then I fail step with error message $error_message
	EndIf
 
And I "perform all associated Pallet Picking"
	Then I assign "FALSE" to variable "DONE"
	#While I do not see "Looking for" in element "className:appbar-title" in web browser 
	While I do not see element "xPath://span[text()='Looking for Work, Please Wait...']" in web browser within $max_response seconds
		If I see "Pickup Product At" in web browser 
			Then I press keys "ENTER" in web browser
		EndIf
		If I verify text $DONE is equal to "FALSE"
			Then I copy text inside element "xPath://span[contains(text(),'Location')]/ancestor::aq-displayfield[contains(@id,'dsploc')]/descendant::span[contains(@class,'data')]" in web browser to variable "srcloc" within $max_response seconds
		EndIf
 
		And I execute scenario "Check Pick Directed Work Assignment by Operation and Location"
		If I verify MOCA status is 0
			Then I assign row 0 column "reqnum" to variable "reqnum"
			And I assign row 0 column "wh_id" to variable "wh_id"
			Then I echo "The Current Work (reqnum = " $reqnum ") is a Pallet Pick. Proceeding...."
 
			If I verify text $cancel_and_reallocate is equal to "TRUE" ignoring case
				Once I see element "xPath://span[contains(text(),'Next [Enter]')]" in web browser
				Then I press keys "ENTER" in web browser
			If I see "Order Pick" in element "className:appbar-title" in web browser within $wait_med seconds
				Then I assign "C-RA" to variable "cancel_code"
				And I assign "TRUE" to variable "error_location_flag"
				Then I execute scenario "Mobile Cancel Pick from Tools Menu"
			Else I verify text $cancel_and_reallocate is not equal to "TRUE" ignoring case
				Then I execute scenario "Mobile Pallet Picking Process Detail"
				And I execute scenario "Get Directed Work Picking Work Reference by Order Number and Operation"
				If I verify variable "cnz_mode" is assigned
					And I verify text $cnz_mode is equal to "TRUE" ignoring case
					And I execute scenario "Mobile Check for Count Near Zero Prompt"
				EndIf
				Then I press keys "F6" in web browser
				If I see " Deposit" in element "className:appbar-title" in web browser within $wait_long seconds
				Else I echo "Retrying F6 operation"
					And I press keys "F6" in web browser
				EndIf
			EndIf
                And I execute scenario "Mobile Wait for Processing"
			EndIf
		Else I echo "The current work is not a pallet pick or the work is not assigned to the current user. Exiting..."
			And I assign "TRUE" to variable "DONE"
		EndIf 
		If I see "Order Pick" in web browser
			If I verify text $cancel_pick is equal to "YES" ignoring case
				And I execute scenario "Mobile Cancel Pick from Tools Menu"
				And I execute scenario "Mobile Logout"
			Elsif I verify text $cancel_pick is equal to "NO" ignoring case
				And I "enter inventory identifier"
				Once I see element "name:lodnum" in web browser
				If I verify text $source_lpn_wrong is equal to "TRUE" ignoring case
					Then I type $value_source_lpn_wrong in element "name:lodnum" in web browser 
					Then I press keys "ENTER" in web browser
					If I "take a web browser screen shot if requested"
						And I verify text $generate_screenshot is equal to "TRUE" ignoring case
						Once I see "Inventory identifier is invalid" in web browser
						Then I save web browser screenshot
					EndIf
					Then I press keys "ENTER" in web browser
					Then I execute scenario  "Test Completion" 
				Endif
				When I press keys "F2" in web browser
					And I wait $wait_med seconds
					Once I see element "xPath://div[@class='data-area']" in web browser
				When I copy text inside element "xPath://div[@class='data-area']" in web browser to variable "lodnum"
					And I echo $lodnum
				When I press keys "F1" in web browser
					And I execute Groovy "lodnum = lodnum.split(' ')[0]" within $wait_med seconds
					Once I see element "name:lodnum" in web browser
					Then I type $lodnum in element "name:lodnum" in web browser
					And I press keys "ENTER" in web browser
					And I wait $wait_med seconds
				
				If I see element "name:stoloc" in web browser
					Then I "enter location"
					When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
						Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
					Given I assign row 0 column "locvrc" to variable "location_verification_code"
						Then I type $location_verification_code in element "name:stoloc" in web browser
						And I press keys "ENTER" in web browser
				
					And I "enter item number"
					If I see element "name:prtnum" in web browser within 3 seconds 
							If I verify text $sku_wrong is equal to "TRUE" ignoring case
								Then I type $value_sku_wrong in element "name:prtnum" in web browser 
								Then I press keys "ENTER" in web browser
							EndIf
							If I "take a web browser screen shot if requested"
								And I verify text $generate_screenshot is equal to "TRUE" ignoring case
								If I see "Invalid Item Number" in web browser
									Then I save web browser screenshot
									Then I press keys "ENTER" in web browser
									Then I execute scenario  "Test Completion"  
								EndIf
							Endif
						When I copy text inside element "xPath://span[contains(text(),'Item Number')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "prtnum"
						Then I type $prtnum in element "name:prtnum" in web browser
						And I press keys "ENTER" in web browser
					EndIf
				EndIf
				Then I "enter client ID"
				If I see element "name:dspprtcli" in web browser within $wait_med seconds 
					Then I press keys "ENTER" in web browser
				EndIf
				And I "enter unit qty"
				If I see element "name:untqty" in web browser 
					If I verify text $extra_pick is equal to "TRUE" ignoring case
						Then I copy text inside element "name:untqty" in web browser to variable "pick_qty"
							And I convert string variable "pick_qty" to integer variable "pick_qty2"
							And I increase variable "pick_qty2" by $extra_pick_qty
							Then I type $pick_qty2 in element "name:untqty" in web browser within $wait_med seconds
							And I press keys "ENTER" in web browser
							Once I see element "name:uomcod" in web browser
							Then I press keys "ENTER" in web browser
						If I "take a web browser screen shot if requested"
							And I verify text $generate_screenshot is equal to "TRUE" ignoring case
							Once I see "Invalid Quantity" in web browser
							Then I save web browser screenshot
						Endif
						And I press keys "ENTER" in web browser
						Then I execute scenario  "Test Completion"
					Endif
					And I press keys "ENTER" in web browser
					And I "enter uom"
					Once I see element "name:uomcod" in web browser 
					And I press keys "ENTER" in web browser
				EndIf
			EndIf
			ElsIf I execute scenario "MultiLPN Pallet"
				And I wait $wait_med seconds
			EndIf

			If I see "MRG" in web browser
				And I execute scenario "Mobile Deposit"
			EndIf

        And I wait $wait_med seconds
	EndWhile

@wip @public
Scenario: Mobile Perform Undirected Pallet Pick for Order
#############################################################
# Description: From the Directed Work screen, given an order number/operation code/username, 
# performs the entirety of the associated pallet picks.
# MSQL Files:
#	None
# Inputs:
# 	Required:
#		oprcod - set to the pallet picking operation code
#		username - the user assigned to or user to assign to
#   	ordnum - The order that will be pallet picked
#   Optional:
#		None
# Outputs:
#	None
#############################################################

Given I "perform Order Pallet picks"
	And I assign "FALSE" to variable "DONE"
	While I see "Product Pickup" in element "className:appbar-title" in web browser within $wait_med seconds 
	And I verify text $DONE is equal to "FALSE"
		Then I execute scenario "Get Pallet Pick Undirected Work by Order Number and Operation"
		If I verify MOCA status is 0
			Given I assign row 0 column "wrkref" to variable "wrkref"
			And I assign row 0 column "wh_id" to variable "wh_id"
			
			And I echo "The Current Work (wrkref = " $wrkref ") is a Pallet Pick. Proceeding...."
			
			When I execute scenario "Mobile Pallet Picking Undirected Process Detail"
			If I see " Deposit" in element "className:appbar-title" in web browser within $wait_long seconds
			Else I echo "Retrying F6 operation"
				And I press keys "F6" in web browser
			EndIf
			And I execute scenario "Mobile Wait for Processing"
			Then I execute scenario "Mobile Deposit"
		Else I echo "No Picks. Exiting..."
			And I assign "TRUE" to variable "DONE"
		EndIf 
	EndWhile

#############################################################
# Private Scenarios:
#   Mobile Pallet Picking Process Detail - performs an individual Pallet Pick
#   Mobile Pallet Picking Undirected Process Detail - performs an individual Pallet Pick via Undirected
#############################################################

@wip @private
Scenario: Mobile Pallet Picking Process Detail
#############################################################
# Description: This scenario performs Pallet Picking to completion from the Directed Work screen.
# MSQL Files:
#	None
# Inputs:
#    Required:
#       None
#   Optional:
#		None
# Outputs:
#     None
#############################################################

Given I "press Enter to Acknowledge"
	Once I see element "xPath://span[contains(text(),'Next [Enter]')]" in web browser
	Then I press keys "ENTER" in web browser
	Once I see "Order Pick" in element "className:appbar-title" in web browser
	
And I "get the pallet pick source location from the Mobile App screen"
	Then I copy text inside element "xPath://span[contains(text(),'Location')]/ancestor::aq-displayfield[contains(@id,'dsploc')]/descendant::span[contains(@class,'data')]" in web browser to variable "srcloc" within $max_response seconds

And I "get the part number to be picked from the Mobile App screen"
	Then I copy text inside element "xPath://span[contains(text(),'Item Number')]/ancestor::aq-displayfield[contains(@id,'dspprt')]/descendant::span[contains(@class,'data')]" in web browser to variable "prtnum" within $max_response seconds
 
And I "get the client ID to be picked from the Mobile App screen"
	Then I copy text inside element "xPath://span[contains(text(),'Item Client ID')]/ancestor::aq-displayfield[contains(@id,'dspprtcli-')]/descendant::span[contains(@class,'data')]" in web browser to variable "client" within $max_response seconds
 
And I "get a pallet number from the pick location to be the pallet we will pick"
	Given I execute scenario "Get Pallet Number from Source Location for Picking"
	If I verify MOCA status is 0
		Then I assign row 0 column "lodnum" to variable "srclod"
	Else I assign variable "error_message" by combining "ERROR: The inventory in this location is not equal to what we expect to pick"
		Then I fail step with error message $error_message
	EndIf 
 
When I "enter the pallet number we are picking to complete the pallet pick"
	Then I assign "Inventory Identifier" to variable "input_field_with_focus"
	And I execute scenario "Mobile Check for Input Focus Field"
	Then I type $srclod in element "name:lodnum" in web browser within $max_response seconds
	And I press keys "ENTER" in web browser
    
And I "copy location to input"
    When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
    Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
    Given I assign row 0 column "locvrc" to variable "location_verification_code"
    Then I type $location_verification_code in element "name:stoloc" in web browser
    And I press keys "ENTER" in web browser
    
And I "copy item number to input"
	Once I see element "name:prtnum" in web browser
    When I copy text inside element "xPath://span[contains(text(),'Item Number')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "prtnum" within $short_sec_wait seconds
    Then I type $prtnum in element "name:prtnum" in web browser
    And I press keys "ENTER" in web browser
Then I "press enter for Unit Quantity and UOM fields"
    Once I see element "name:untqty" in web browser
    Then I press keys "ENTER" in web browser
 
    Once I see element "name:uomcod" in web browser
    Then I press keys "ENTER" in web browser

@wip @private
Scenario: Mobile Pallet Picking Undirected Process Detail
#############################################################
# Description: This scenario performs List Picking to completion from the Product Pickup screen.
# MSQL Files:
#	None
# Inputs:
#     Required:
#       wrkref - the Work Reference Number
#   Optional:
#		None
# Outputs:
#	None
#############################################################

Given I "enter the Work Reference"
	Then I assign "Work Task" to variable "input_field_with_focus"
	And I execute scenario "Mobile Check for Input Focus Field"
	Then I type $wrkref in element "name:wrkref" in web browser within $max_response seconds
	And I press keys "ENTER" in web browser

	Once I see "Order Pick" in element "className:appbar-title" in web browser
 
When I "get the pallet pick source location from the Mobile App screen"
	Then I copy text inside element "xPath://span[contains(text(),'Location')]/ancestor::aq-displayfield[contains(@id,'dsploc')]/descendant::span[contains(@class,'data')]" in web browser to variable "srcloc" within $max_response seconds
 
And I "get the part number to be picked from the Mobile App screen"
	Then I copy text inside element "xPath://span[contains(text(),'Item Number')]/ancestor::aq-displayfield[contains(@id,'dspprt')]/descendant::span[contains(@class,'data')]" in web browser to variable "prtnum" within $max_response seconds
 
And I "get the client ID to be picked from the Mobile App screen"
	Then I copy text inside element "xPath://span[contains(text(),'Item Client ID')]/ancestor::aq-displayfield[contains(@id,'dspprtcli-')]/descendant::span[contains(@class,'data')]" in web browser to variable "client" within $max_response seconds
 
And I "get a pallet number from the pick location to be the pallet we will pick"
	Given I execute scenario "Get Pallet Number from Source Location for Picking"
	If I verify MOCA status is 0
		 Then I assign row 0 column "lodnum" to variable "srclod"
	Else I assign variable "error_message" by combining "ERROR: The inventory in this location is not equal to what we expect to pick"
		Then I fail step with error message $error_message
	EndIf 
 
When I "enter the pallet number we are picking to complete the List Pick"
	Then I assign "Inventory Identifier" to variable "input_field_with_focus"
	And I execute scenario "Mobile Check for Input Focus Field"
	Then I type $srclod in element "name:lodnum" in web browser within $max_response seconds
	And I press keys "ENTER" in web browser

@wip @private
Scenario: MultiLPN Pallet
#############################################################
# Description: Generate a subload LPN for receiving functions
# MSQL Files:
#   None
# Inputs:
#   Required:
#       trknum- the inbound shipment number
#        wh_id - warehouse id
#   Optional:
#       None
# Outputs:
#     detail_lpn - detail lpn for receiving
#############################################################

Given I "execute get source location script"
	Given I execute moca script "Scripts\MSQL_Files\Custom\get_srcloc_wave.msql"
	When I verify MOCA status is 0
	And I assign row 0 column "srcloc" to variable "srcloc"

    Given I execute moca script "Scripts\MSQL_Files\Custom\get_lodnum_pallet.msql"
	When I verify MOCA status is 0
	And I assign row 0 column "lodnum" to variable "lodnum"

And I "enter inventory identifier"
Once I see element "name:lodnum" in web browser
And I wait $wait_med seconds
And I echo $lodnum
Then I type $lodnum in element "name:lodnum" in web browser
And I press keys "ENTER" in web browser
And I wait $wait_med seconds
    
And I "enter unit qty"
	Once I see element "name:untqty" in web browser 
	And I press keys "ENTER" in web browser
	
	And I wait $wait_short seconds
	And I "enter uom"
		Once I see element "name:uomcod" in web browser 
		And I press keys "ENTER" in web browser

Then I unassign variable "srcloc"