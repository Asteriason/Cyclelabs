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
# Utility: Mobile List Picking Utilities.feature
# 
# Functional Area: Picking
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Utility
# Blue Yonder Interfaces Interacted With: Mobile, MOCA
# 
# Description:
# This utility contains scenarios to perform List Picking in the Mobile App
#
# Public Scenarios:
#     - Mobile Perform Directed List Pick for Order - Performs Directed List Pick For a Given Order From Directed Work Menu
#     - Mobile Perform Undirected List Pick for Order - Performs Undirected List Pick For a Given Order From Undirected Menu
#     - Mobile Work Assignment Menu - Navigates From Undirected Menu To Work Assignment Menu 
#	  - Mobile Perform Picks for Work Assignment - Performs all the picks to complete a pick list
#
# Assumptions:
# None
#
# Notes:
# - See Scenario Headers for required inputs.
#
############################################################
Feature: Mobile List Picking Utilities

@wip @public
Scenario: Mobile Perform Directed Carton Pick 
Given I assign 20 to variable "max_loop_counter"
And I assign 0 to variable "current_count"
#While I verify number "current_count" is less than "max_loop_counter"
While I do not see element "xPath://span[text()='Looking for Work, Please Wait...']" in web browser within $max_response seconds

	If I see "Pick List At" in element "className:appbar-title" in web browser
    	If I see "List ID" in web browser
        When I copy text inside element "xPath://span[contains(text(),'List ID')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "list_id"
        Then I press keys "ENTER" in web browser
        EndIf
		Given I execute scenario "Get Load Id for Work Assignment"
            Then I assign "To ID" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"
            
            Then I execute groovy "to_id = to_id[1..-1].padLeft(9, '0')"
			If I verify text $wrong_dest_lpn is equal to "TRUE" ignoring case
		Then I type $value_wrong_dest_lpn in element "name:to_id" in web browser 
		Then I press keys "ENTER" in web browser
		If I "take a web browser screen shot if requested"
        And I verify text $generate_screenshot is equal to "TRUE" ignoring case
		Once I see "Provided LPN is not valid" in web browser
        Then I save web browser screenshot
    EndIf
	Then I press keys "ENTER" in web browser
	Then I execute scenario  "Test Completion" 
	Endif
            Then I type $to_id in element "name:to_id" in web browser within $max_response seconds
			And I press keys "ENTER" in web browser
		If I see element "name:pos_id" in web browser within $wait_med seconds
			Then I assign "Pos ID" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"	
			Then I press keys "ENTER" in web browser
			And I wait $wait_long seconds
		EndIf 
    EndIf
    
    If I see "Build Batch" in element "className:appbar-title" in web browser  
        And I press keys "ENTER" in web browser 2 times with $wait_short seconds delay
	EndIf
    
	If I see "Order Pick L" in web browser
        When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
        Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
        Given I assign row 0 column "locvrc" to variable "location_verification_code"
        Once I see element "name:stoloc" in web browser
        Then I type $location_verification_code in element "name:stoloc" in web browser within $wait_med seconds
        And I press keys "ENTER" in web browser

    And I "copy item number to input"
        Once I see element "name:prtnum" in web browser
        If I verify text $sku_wrong is equal to "TRUE" ignoring case
		Then I type $value_sku_wrong in element "name:prtnum" in web browser 
		Then I press keys "ENTER" in web browser
		If I "take a web browser screen shot if requested"
        And I verify text $generate_screenshot is equal to "TRUE" ignoring case
		Once I see "Invalid Item Number" in web browser
        Then I save web browser screenshot
    EndIf
	Then I press keys "ENTER" in web browser
	Then I execute scenario  "Test Completion" 
	Endif
		When I copy text inside element "xPath://span[contains(text(),'Item Number')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "prtnum" within $short_sec_wait seconds
        Then I type $prtnum in element "name:prtnum" in web browser
        And I press keys "ENTER" in web browser

	And I "see element dspprtcli"
        If I see element "name:dspprtcli" in web browser within $wait_short seconds
        	And I press keys "ENTER" in web browser
		EndIf

    Then I "press enter for Unit Quantity and UOM fields"
        Once I see element "name:untqty" in web browser
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
		Then I press keys "ENTER" in web browser

        Once I see element "name:uomcod" in web browser
        Then I press keys "ENTER" in web browser
        
        And I "enter to id"
        Once I see element "name:to_id" in web browser
        If I see element "xPath://span[contains(text(),'To ID')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser within $wait_short seconds
          		  Then I copy text inside element "xPath://span[contains(text(),'To ID')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "to_id" within $wait_short seconds
          Then I type $to_id in element "name:to_id" in web browser
          And I press keys "ENTER" in web browser
          And I wait $wait_med seconds
        EndIf
        If I see element "name:to_id" in web browser within $wait_short seconds
          And I see element "xPath://span[contains(text(),'Inventory Identifier')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser
		  Then I copy text inside element "xPath://span[contains(text(),'Inventory Identifier')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "to_id" within $short_sec_wait seconds
          Then I type $to_id in element "name:to_id" in web browser
          And I press keys "ENTER" in web browser
          And I wait $wait_short seconds
        EndIf
    EndIf
    
    If I see "Carton Is Complete" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf
    
    If I see "Batch is Complete" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf
    
    If I see "No Picks Remaining in Batch" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf
    
    If I see "MRG Product Deposit" in web browser
    	If I see element "name:subnum" in web browser within $wait_short seconds
        	Then I press keys "ENTER" in web browser
        Elsif I see element "name:lodnum" in web browser 
        	Then I press keys "ENTER" in web browser
        EndIf
        If I see element "xPath://span[contains(text(), '1 Equipment Full')]" in web browser within $wait_short seconds
        	Then I click element "xPath://span[contains(text(), '1 Equipment Full')]" in web browser
        EndIf
        If I see element "name:dstloc" in web browser within $wait_short seconds
        	When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
        	Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
       		Given I assign row 0 column "locvrc" to variable "location_verification_code"
        	Then I type $location_verification_code in element "name:dstloc" in web browser
        	And I press keys "ENTER" in web browser
        EndIf
    EndIf
    
    If I see "List Pick Completed" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_med seconds
    EndIf
    
    If I see "Work Assignment" in web browser
      If I see "List Pick Completed" in web browser
          Then I press keys "ENTER" in web browser
          And I press keys "F1" in web browser 2 times with $wait_short seconds delay
      EndIf
    EndIf
    
	And I wait $wait_med seconds
EndWhile

@wip @private
Scenario: Check for Product Put Screen
Given I "check for Product Put screen"
	If I see element "name:to_id" in web browser within $wait_short seconds
	And I verify element "name:to_id" is clickable in web browser
		And I see element "xPath://span[contains(text(),'To ID')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser
		Then I copy text inside element "xPath://span[contains(text(),'To ID')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "to_id" within $short_sec_wait seconds
		Then I type $to_id in element "name:to_id" in web browser
		And I press keys "ENTER" in web browser
		And I wait $wait_med seconds
	EndIf

@wip @public
Scenario: Mobile Perform Directed List Pick 
Given I assign 20 to variable "max_loop_counter"
And I assign 0 to variable "current_count"
#While I verify number "current_count" is less than "max_loop_counter"
While I do not see "Looking for Work" in web browser within $wait_long seconds

	If I see "Pick List At" in element "className:appbar-title" in web browser
    	If I see "List ID" in web browser
        When I copy text inside element "xPath://span[contains(text(),'List ID')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "list_id"
        Then I press keys "ENTER" in web browser
        EndIf
		Given I execute scenario "Get Load Id for Work Assignment"
            Then I assign "To ID" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"
            
            Then I execute groovy "to_id = to_id[1..-1].padLeft(9, '0')"
            If I verify text $wrong_dest_lpn is equal to "TRUE" ignoring case
		Then I type $value_wrong_dest_lpn in element "name:to_id" in web browser 
		Then I press keys "ENTER" in web browser
		If I "take a web browser screen shot if requested"
        And I verify text $generate_screenshot is equal to "TRUE" ignoring case
		Once I see "Provided LPN is not valid" in web browser
        Then I save web browser screenshot
    EndIf
	Then I press keys "ENTER" in web browser
	Then I execute scenario  "Test Completion" 
	Endif
			Then I type $to_id in element "name:to_id" in web browser within $max_response seconds
			And I press keys "ENTER" in web browser
			
		If I see element "name:pos_id" in web browser within $wait_med seconds
			Then I assign "Pos ID" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"	
			Then I press keys "ENTER" in web browser
			And I wait $wait_med seconds
		EndIf 
    EndIf
    
    If I see "Build Batch" in element "className:appbar-title" in web browser  
        And I press keys "ENTER" in web browser 2 times with $wait_short seconds delay
	EndIf
    
	If I see "Order Pick L" in web browser
		While I see "Order Pick L" in web browser within $wait_med seconds
			If I verify variable "cancel_pick" is assigned
			And I verify text $cancel_pick is equal to "YES" ignoring case
				And I execute scenario "Mobile Cancel Pick from Tools Menu"
				And I execute scenario "Mobile Logout"
			EndIf
				When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
				Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
				Given I assign row 0 column "locvrc" to variable "location_verification_code"
				Once I see element "name:stoloc" in web browser
				Then I type $location_verification_code in element "name:stoloc" in web browser within $wait_med seconds
				And I press keys "ENTER" in web browser

				And I "copy item number to input"
					Once I see element "name:prtnum" in web browser
					When I copy text inside element "xPath://span[contains(text(),'Item Number')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "prtnum" within $short_sec_wait seconds
					If I verify text $sku_wrong is equal to "TRUE" ignoring case
						Then I type $value_sku_wrong in element "name:prtnum" in web browser 
						Then I press keys "ENTER" in web browser
						If I "take a web browser screen shot if requested"
							And I verify text $generate_screenshot is equal to "TRUE" ignoring case
							Once I see "Invalid Item Number" in web browser
							Then I save web browser screenshot
						EndIf
						Then I press keys "ENTER" in web browser
						Then I execute scenario  "Test Completion" 
					Endif

					Then I type $prtnum in element "name:prtnum" in web browser
					And I press keys "ENTER" in web browser

					And I "see element dspprtcli"
						If I see element "name:dspprtcli" in web browser within $wait_short seconds
							And I press keys "ENTER" in web browser
						EndIf

				Then I "press enter for Unit Quantity and UOM fields"
					Once I see element "name:untqty" in web browser
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
					Then I press keys "ENTER" in web browser

					Once I see element "name:uomcod" in web browser
					Then I press keys "ENTER" in web browser
					
					And I "process Product Put screen by entering To ID"
					Once I see element "name:to_id" in web browser
					While I see element "name:to_id" in web browser within $wait_short seconds
					And I see "Product Put" in web browser
						Then I execute scenario "Check for Product Put Screen"
					EndWhile
		EndWhile
    EndIf

    If I see "Carton Is Complete" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf

    If I see "Batch is Complete" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf
    
    If I see "No Picks Remaining in Batch" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf
    
    If I see "List Pick Completed" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_med seconds
    EndIf
    
    If I see "Work Assignment" in web browser
      If I see "List Pick Completed" in web browser
          Then I press keys "ENTER" in web browser
          And I press keys "F1" in web browser 2 times with $wait_short seconds delay
      EndIf
    EndIf

    If I see "MRG Product Deposit" in web browser
    	If I see element "name:lodnum" in web browser within $wait_short seconds
        	Then I press keys "ENTER" in web browser
        EndIf
        If I see element "xPath://span[contains(text(), '1 Equipment Full')]" in web browser within $wait_short seconds
        	Then I click element "xPath://span[contains(text(), '1 Equipment Full')]" in web browser
        EndIf
        If I see element "name:dstloc" in web browser within $wait_med seconds
        When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
        Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
        Given I assign row 0 column "locvrc" to variable "location_verification_code"
        Then I type $location_verification_code in element "name:dstloc" in web browser
        And I press keys "ENTER" in web browser
        EndIf
    EndIf
    
	And I wait $wait_med seconds
EndWhile



@wip @public
Scenario: Mobile Perform Slotted Picking
Given I assign 20 to variable "max_loop_counter"
And I assign 0 to variable "current_count"
#While I verify number "current_count" is less than "max_loop_counter"
While I do not see "Looking for Work" in web browser within $wait_long seconds

	If I see "Pick List At" in element "className:appbar-title" in web browser
    	If I see "List ID" in web browser
        When I copy text inside element "xPath://span[contains(text(),'List ID')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "list_id"
        Then I press keys "ENTER" in web browser
        EndIf
		Given I execute scenario "Get Load Id for Work Assignment"
            Then I assign "To ID" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"
            
            Then I execute groovy "to_id = to_id[1..-1].padLeft(9, '0')"
            If I verify text $wrong_dest_lpn is equal to "TRUE" ignoring case
		Then I type $value_wrong_dest_lpn in element "name:to_id" in web browser 
		Then I press keys "ENTER" in web browser
		If I "take a web browser screen shot if requested"
        And I verify text $generate_screenshot is equal to "TRUE" ignoring case
		Once I see "Provided LPN is not valid" in web browser
        Then I save web browser screenshot
    EndIf
	Then I press keys "ENTER" in web browser
	Then I execute scenario  "Test Completion" 
	Endif
			Then I type $to_id in element "name:to_id" in web browser within $max_response seconds
			And I press keys "ENTER" in web browser
			
		If I see element "name:pos_id" in web browser within $wait_med seconds
			Then I assign "Pos ID" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"	
			Then I press keys "ENTER" in web browser
			And I wait $wait_med seconds
		EndIf 
    EndIf
    
    If I see "Build Batch" in element "className:appbar-title" in web browser  
        And I press keys "ENTER" in web browser 2 times with $wait_short seconds delay
	EndIf
    
	If I see "Order Pick L" in web browser
		While I see "Order Pick L" in web browser within $wait_med seconds
			If I verify variable "cancel_pick" is assigned
			And I verify text $cancel_pick is equal to "YES" ignoring case
				And I execute scenario "Mobile Cancel Pick from Tools Menu"
				And I execute scenario "Mobile Logout"
			EndIf
				When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
				Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
				Given I assign row 0 column "locvrc" to variable "location_verification_code"
				Once I see element "name:stoloc" in web browser
				Then I type $location_verification_code in element "name:stoloc" in web browser within $wait_med seconds
				And I press keys "ENTER" in web browser

				And I "copy item number to input"
					Once I see element "name:prtnum" in web browser
					When I copy text inside element "xPath://span[contains(text(),'Item Number')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "prtnum" within $short_sec_wait seconds
					If I verify text $sku_wrong is equal to "TRUE" ignoring case
						Then I type $value_sku_wrong in element "name:prtnum" in web browser 
						Then I press keys "ENTER" in web browser
						If I "take a web browser screen shot if requested"
							And I verify text $generate_screenshot is equal to "TRUE" ignoring case
							Once I see "Invalid Item Number" in web browser
							Then I save web browser screenshot
						EndIf
						Then I press keys "ENTER" in web browser
						Then I execute scenario  "Test Completion" 
					Endif

					Then I type $prtnum in element "name:prtnum" in web browser
					And I press keys "ENTER" in web browser

					And I "see element dspprtcli"
						If I see element "name:dspprtcli" in web browser within $wait_short seconds
							And I press keys "ENTER" in web browser
						EndIf

				Then I "press enter for Unit Quantity and UOM fields"
					Once I see element "name:untqty" in web browser
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
					Then I press keys "ENTER" in web browser

					Once I see element "name:uomcod" in web browser
					Then I press keys "ENTER" in web browser
					
					And I "process Product Put screen by entering To ID"
					Once I see element "name:to_id" in web browser
					While I see element "name:to_id" in web browser within $wait_short seconds
					And I see "Product Put" in web browser
						Then I execute scenario "Check for Product Put Screen"
					EndWhile
		EndWhile
    EndIf

    If I see "Carton Is Complete" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf

    If I see "Batch is Complete" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf
    
    If I see "No Picks Remaining in Batch" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf
    
    If I see "List Pick Completed" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_med seconds
    EndIf
    
    If I see "Work Assignment" in web browser
      If I see "List Pick Completed" in web browser
          Then I press keys "ENTER" in web browser
          And I press keys "F1" in web browser 2 times with $wait_short seconds delay
      EndIf
    EndIf

    If I see "MRG Product Deposit" in web browser
    	If I see element "name:lodnum" in web browser within $wait_short seconds
        	Then I press keys "ENTER" in web browser
        EndIf
		If I see element "name:slot" in web browser within $wait_med seconds
			Given I assign next value from sequence "lodnum" to "slot_id"
			Then I execute groovy "slot_id = slot_id[1..-1].padLeft(9, '0')"
			Then I type $slot_id in element "name:slot_id" in web browser within $max_response seconds
			And I press keys "ENTER" in web browser

			Once I see "OK to change Slot" in web browser 
			Then I press keys "Y" in web browser
		EndIf
        If I see element "xPath://span[contains(text(), '1 Equipment Full')]" in web browser within $wait_short seconds
        	Then I click element "xPath://span[contains(text(), '1 Equipment Full')]" in web browser
        EndIf
        If I see element "name:dstloc" in web browser within $wait_med seconds
        When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
        Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
        Given I assign row 0 column "locvrc" to variable "location_verification_code"
        Then I type $location_verification_code in element "name:dstloc" in web browser
        And I press keys "ENTER" in web browser
        EndIf
    EndIf
    
	And I wait $wait_med seconds
EndWhile



@wip @public
Scenario: Mobile Perform Directed List Pick V1
Given I assign 20 to variable "max_loop_counter"
And I assign 0 to variable "current_count"
#While I verify number "current_count" is less than "max_loop_counter"
While I do not see "Looking for Work" in web browser within $wait_long seconds

	If I see "Pick List At" in element "className:appbar-title" in web browser
    	If I see "List ID" in web browser
        When I copy text inside element "xPath://span[contains(text(),'List ID')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "list_id"
        Then I press keys "ENTER" in web browser
        EndIf
		Given I execute scenario "Get Load Id for Work Assignment"
            Then I assign "To ID" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"
            
            Then I execute groovy "to_id = to_id[1..-1].padLeft(9, '0')"
            If I verify text $wrong_dest_lpn is equal to "TRUE" ignoring case
		Then I type $value_wrong_dest_lpn in element "name:to_id" in web browser 
		Then I press keys "ENTER" in web browser
		If I "take a web browser screen shot if requested"
        And I verify text $generate_screenshot is equal to "TRUE" ignoring case
		Once I see "Provided LPN is not valid" in web browser
        Then I save web browser screenshot
    EndIf
	Then I press keys "ENTER" in web browser
	Then I execute scenario  "Test Completion" 
	Endif
			Then I type $to_id in element "name:to_id" in web browser within $max_response seconds
			And I press keys "ENTER" in web browser
			
		If I see element "name:pos_id" in web browser within $wait_med seconds
			Then I assign "Pos ID" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"	
			Then I press keys "ENTER" in web browser
			And I wait $wait_med seconds
		EndIf 
    EndIf
    
    If I see "Build Batch" in element "className:appbar-title" in web browser  
        And I press keys "ENTER" in web browser 2 times with $wait_short seconds delay
	EndIf
    
	If I see "Order Pick L" in web browser
	If I verify variable "cancel_pick" is assigned
	And I verify text $cancel_pick is equal to "YES" ignoring case
		And I execute scenario "Mobile Cancel Pick from Tools Menu"
		And I execute scenario "Mobile Logout"
	EndIf
        When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
        Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
        Given I assign row 0 column "locvrc" to variable "location_verification_code"
        Once I see element "name:stoloc" in web browser
        Then I type $location_verification_code in element "name:stoloc" in web browser within $wait_med seconds
        And I press keys "ENTER" in web browser

		And I "copy item number to input"
			Once I see element "name:prtnum" in web browser
			When I copy text inside element "xPath://span[contains(text(),'Item Number')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "prtnum" within $short_sec_wait seconds
			If I verify text $sku_wrong is equal to "TRUE" ignoring case
				Then I type $value_sku_wrong in element "name:prtnum" in web browser 
				Then I press keys "ENTER" in web browser
				If I "take a web browser screen shot if requested"
					And I verify text $generate_screenshot is equal to "TRUE" ignoring case
					Once I see "Invalid Item Number" in web browser
					Then I save web browser screenshot
    			EndIf
				Then I press keys "ENTER" in web browser
				Then I execute scenario  "Test Completion" 
			Endif
			Then I type $prtnum in element "name:prtnum" in web browser
			And I press keys "ENTER" in web browser

			And I "see element dspprtcli"
				If I see element "name:dspprtcli" in web browser within $wait_short seconds
					And I press keys "ENTER" in web browser
				EndIf

		Then I "press enter for Unit Quantity and UOM fields"
			Once I see element "name:untqty" in web browser
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
			Then I press keys "ENTER" in web browser

			Once I see element "name:uomcod" in web browser
			Then I press keys "ENTER" in web browser
			
			And I "enter to id"
			Once I see element "name:to_id" in web browser
			If I see element "xPath://span[contains(text(),'To ID')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser within $wait_short seconds
				Then I copy text inside element "xPath://span[contains(text(),'To ID')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "to_id" within $wait_short seconds
				Then I type $to_id in element "name:to_id" in web browser
				And I press keys "ENTER" in web browser
				And I wait $wait_med seconds
			EndIf
			If I see element "name:to_id" in web browser within $wait_short seconds
				And I see element "xPath://span[contains(text(),'Inventory Identifier')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser
				Then I copy text inside element "xPath://span[contains(text(),'Inventory Identifier')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "to_id" within $short_sec_wait seconds
				Then I type $to_id in element "name:to_id" in web browser
				And I press keys "ENTER" in web browser
				And I wait $wait_short seconds
			EndIf
    EndIf

    If I see "Carton Is Complete" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf

    If I see "Batch is Complete" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf
    
    If I see "No Picks Remaining in Batch" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_short seconds
    EndIf
    
    If I see "List Pick Completed" in web browser
    	Then I press keys "ENTER" in web browser
        And I wait $wait_med seconds
    EndIf
    
    If I see "Work Assignment" in web browser
      If I see "List Pick Completed" in web browser
          Then I press keys "ENTER" in web browser
          And I press keys "F1" in web browser 2 times with $wait_short seconds delay
      EndIf
    EndIf

    If I see "MRG Product Deposit" in web browser
    	If I see element "name:lodnum" in web browser within $wait_short seconds
        	Then I press keys "ENTER" in web browser
        EndIf
        If I see element "xPath://span[contains(text(), '1 Equipment Full')]" in web browser within $wait_short seconds
        	Then I click element "xPath://span[contains(text(), '1 Equipment Full')]" in web browser
        EndIf
        If I see element "name:dstloc" in web browser within $wait_med seconds
        When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
        Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
        Given I assign row 0 column "locvrc" to variable "location_verification_code"
        Then I type $location_verification_code in element "name:dstloc" in web browser
        And I press keys "ENTER" in web browser
        EndIf
    EndIf
    
	And I wait $wait_med seconds
EndWhile

@wip @public
Scenario: Mobile Perform Directed List Pick for Order
#############################################################
# Description: From the Directed Work screen, given an order number/operation code/username, 
# performs the entirety of the associated List Picks.
# MSQL Files:
#	None
# Inputs:
# 	Required:
#		oprcod - set to the List picking operation code
#		username - the user assigned to or user to assign to
#		ordnum - The order that will be List picked
# 	Optional:
#		cancel_and_reallocate - Will cancel the List Pick and reallocate if set to "true"
# Outputs:
# 	None
#############################################################

Given I "wait some time for list picks to release" which can take between $wait_med seconds and $wait_long seconds 

And I "confirm Directed Work exists"	
	If I see "Pick List At" in element "className:appbar-title" in web browser within $wait_long seconds
		Then I echo "I'm good to proceed as there is list pick directed work"
	Else I fail step with error message "ERROR: There are no directed list picks. Exiting..."
	EndIf

When I "perform all associated list Picking"
	Given I assign "FALSE" to variable "lists_done"
	While I see "Pick List At" in element "className:appbar-title" in web browser within $wait_long seconds 
	And I verify text $lists_done is equal to "FALSE"

	Then I "copy the list ID from the Mobile App screen"
		And I copy text inside element "xPath://span[contains(text(),'List ID')]/ancestor::aq-displayfield[contains(@id,'list_id')]/descendant::span[contains(@class,'data')]" in web browser to variable "list_id" within $max_response seconds
	When I "perform the List Pick, if applicable"
    	Then I echo $oprcod
        Then I echo $devcod
        And I echo $username
        And I echo $list_id
		And I execute scenario "Check List Pick Directed Work Assignment"
		If I verify MOCA status is 0
			Then I echo "The Current Work is a List Pick. Proceeding...."
           	And I execute scenario "Mobile Acknowledge Work Assignment"
        EndIf
        EndWhile
	
@wip @public
Scenario: Mobile Perform Undirected List Pick for Order
#############################################################
# Description: Given an order number, performs the entirety of the associated Undirected List Picks.
# MSQL Files:
#	None
# Inputs:
# 	Required:
#		oprcod - set to the List picking operation code
#		ordnum - The order that will be List picked
# 	Optional:
#		None
# Outputs:
# 	None
#############################################################

Given I "obtain the List ID"
	When I execute scenario "Get Pick List ID by Order Number for Undirected Pick"
	If I verify MOCA status is 0
		Then I echo "We have got List Picks"
	Else I fail step with error message "ERROR: We do not have any List Picks. Exiting...."
	EndIf

When I "perform Order List picks"
	Then I assign "FALSE" to variable "lists_done"
	While I see "Work Assignment" in element "className:appbar-title" in web browser within $wait_med seconds
	And I verify text $lists_done is equal to "FALSE"
		Given I "get the list ID for the list picks"
			Given I execute scenario "Get Pick List ID by Order Number for Undirected Pick"
			
		When I "perform the Undirected List Pick, if applicable"
			If I verify MOCA status is 0
				Then I assign row 0 column "list_id" to variable "list_id"
				And I echo "The Current Work is a List Case Pick. Proceeding...."

                When I execute scenario "Mobile Sign on to Work Assignment"
                And I execute scenario "Mobile Perform Picks for Work Assignment"
				Then I execute scenario "Mobile Deposit"
			Else I echo "No Picks. Exiting..."
				Then I assign "TRUE" to variable "lists_done"
			EndIf
	EndWhile
    Then I unassign variable "lists_done"

@wip @public
Scenario: Mobile Perform Picks for Work Assignment
#############################################################
# Description: This scenario performs List Picking to completion from the Work Assignment screen.
# MSQL Files:
#	None
# Inputs:
# 	Required:
#		list_id - pick list to be picked
# 	Optional:
#		cancel_pick_flag - If "TRUE" then pick will be Cancel with no reallocation
#       cancel_code - Cancel code to enter.  Default C-N-R (cancel no reallocation)
#		error_location_flag - If canceling pick, show location be errored (Default=FALSE)
#		short_pick_flag - should the pick be shorted (default=FALSE) (short pick is automatically followed with a cancel pick)
#		short_pick_qty - Amount to pick when short picking  (default is 1)
#       single_pick_flag - Indicates the utility should exit after first pick is completed
#		override_srclod - Overrides the value entered for source load (unassigned after entry)
#       override_srcloc - Overrides the value entered for the source location (unassigned after entry)
#		override_prtnum - Overrides the value entered for part number (unassigned after entry)
#		override_pick_qty- Overrides the value entered for pick quantity (unassigned after entry)
#		override_uomcod - Overrides the value entered for the UOM code (unassigned after entry)
# Outputs:
# 	picks_confirmed - The number of picks confirm by this call this scenario
#############################################################

Given I assign "FALSE" to variable "work_assignment_loop_done"
And I assign 0 to variable "picks_confirmed"
And I assign "NO" to variable "lpck_action_performed"


When I "perform work assignment picks"
	While I verify text $work_assignment_loop_done is equal to "FALSE"
	And I see "Order Pick" in element "className:appbar-title" in web browser within $wait_med seconds
		If I verify variable "cancel_pick_flag" is assigned
		And I verify text $cancel_pick_flag is equal to "TRUE" ignoring case
			Then I "cancel pick from tools menu"
				And I execute scenario "Mobile Cancel Pick from Tools Menu"

            And I "clear the cancel variables"
				Given I unassign variable "cancel_pick_flag"
				And I unassign variable "cancel_code"
		Else I wait $wait_short seconds
			Then I "check to see if I need to set down my list or if my vehicle is full after one pick is complete"
				If I verify number $picks_confirmed is greater than 0
					If I verify variable "lpck_action" is assigned
					And I verify text $lpck_action is equal to "VEHICLE_FULL" ignoring case
					And I verify text $lpck_action_performed is not equal to "DONE" ignoring case
						Then I execute scenario "Mobile List Pick Vehicle Full"
						And I assign "DONE" to variable "lpck_action_performed"
					ElsIf I verify variable "lpck_action" is assigned
					And I verify text $lpck_action is equal to "SET_DOWN" ignoring case
					And I verify text $lpck_action_performed is not equal to "DONE" ignoring case
						Then I execute scenario "Mobile List Pick Set Down"
						And I assign "TRUE" to variable "lpck_action_performed"
					EndIf
				EndIf
                
                
                When I "check if carton pick is required"
                If I see "Build Batch" in element "className:appbar-title" in web browser within $wait_med seconds
                    Once I see element "name:subnum" in web browser 
                    Then I press keys "ENTER" in web browser
                    Once I see element "name:pos_id" in web browser
                    Then I press keys "ENTER" in web browser
                EndIf
            
			Then I "read the source location to pick from"
				And I copy text inside element "xPath://span[contains(text(),'Location')]/ancestor::aq-displayfield[contains(@id,'dsploc')]/descendant::span[contains(@class,'data')]" in web browser to variable "srcloc" within $max_response seconds

			And I "read the Part number that needs to be picked"
				Then I copy text inside element "xPath://span[contains(text(),'Item Number')]/ancestor::aq-displayfield[contains(@id,'dspprt')]/descendant::span[contains(@class,'data')]" in web browser to variable "prtnum" within $max_response seconds

			And I "read the Item Client that needs to be picked"
				Then I copy text inside element "xPath://span[contains(text(),'Item Client ID')]/ancestor::aq-displayfield[contains(@id,'dspprtcli-')]/descendant::span[contains(@class,'data')]" in web browser to variable "client" within $max_response seconds
                
			And I "get a Load from the location to pick for the current Item And Client"	
				# This call populates prtnum and srclod
				Given I execute scenario "Get Source Subload ID for Terminal List Pick"
			  
			When I "enter the Lodnum, if applicable"
				And I assign "Item Identifier" to variable "input_field_with_focus"
				Given I assign variable "mobile_focus_elt" by combining "xPath://div[@class='mat-form-field-infix']/descendant::mat-label[contains(text(),'" $input_field_with_focus "')]"
				If I see element $mobile_focus_elt in web browser within $screen_wait seconds
					If I verify variable "override_srclod" is assigned
						Then I type $override_srclod in web browser
						And I unassign variable "override_srclod"
					Else I type $srclod in web browser
					EndIf
					And I press keys "ENTER" in web browser 
				Endif

			When I "enter the Source Location, if applicable"	
                Given I assign $srcloc to variable "verify_location"
                Then I execute scenario "Get Location Verification Code"

				Then I assign "Source Location" to variable "input_field_with_focus"
				And I assign variable "mobile_focus_elt" by combining "xPath://div[@class='mat-form-field-infix']/descendant::mat-label[contains(text(),'" $input_field_with_focus "')]"
				If I see element $mobile_focus_elt in web browser within $screen_wait seconds
					If I verify variable "override_srcloc" is assigned
						Then I type $override_srcloc in web browser
						And I unassign variable "override_srcloc"
					Else I type $location_verification_code in web browser
					EndIf
					And I press keys "ENTER" in web browser
				Endif

			When I "enter the Part Number, if applicable"
				And I assign "Item Number" to variable "input_field_with_focus"
				Then I execute scenario "Mobile Check for Input Focus Field"

				If I verify variable "override_prtnum" is assigned
					Then I type $override_prtnum in element "name:prtnum" in web browser within $max_response seconds
					And I unassign variable "override_prtnum"                     
				Else I type $prtnum in element "name:prtnum" in web browser within $max_response seconds
				EndIf
				And I press keys "ENTER" in web browser
   
			When I "enter the Qty To Pick"
				And I assign "Quantity" to variable "input_field_with_focus"
				Then I execute scenario "Mobile Check for Input Focus Field"

				If I verify variable "short_pick_flag" is assigned
				And I verify text $short_pick_flag is equal to "TRUE" ignoring case
					Given I assign "TRUE" to variable "cancel_pick_flag"
					If I verify variable "short_pick_qty" is assigned
					And I verify text $short_pick_qty is not equal to ""
					Else I assign "1" to variable "short_pick_qty"
					EndIf
					And I clear all text in element "name:untqty" in web browser within $max_response seconds
					Then I type $short_pick_qty in element "name:untqty" in web browser within $max_response seconds

					Then I unassign variable "short_pick_qty"
					And I unassign variable "short_pick_flag"
				ElsIf I verify variable "override_pick_qty" is assigned
					And I clear all text in element "name:untqty" in web browser within $max_response seconds
					Then I type $override_pick_qty in element "name:untqty" in web browser within $max_response seconds
					And I unassign variable "override_pick_qty"
				EndIf
				And I press keys "ENTER" in web browser
                
			And I "press enter UOM and complete Pick"
				Then I assign "UOM" to variable "input_field_with_focus"
				And I execute scenario "Mobile Check for Input Focus Field"

				If I verify variable "override_uomcod" is assigned
					Then I clear all text in element "name:uomcod" in web browser within $max_response seconds
					And I type $override_uomcod in element "name:uomcod" in web browser within $max_response seconds
					And I unassign variable "override_uomcod"
				EndIf
				And I press keys "ENTER" in web browser 
		 
            And I "process serialization if required/configured"
				If I see "Serial Number" in element "className:appbar-title" in web browser within $screen_wait seconds
					Then I execute scenario "Get Item Serialization Type"
					If I verify text $serialization_type is equal to "OUTCAP_ONLY"
						Then I execute scenario "Mobile Scan Serial Number Outbound Capture Picking"
					ElsIf I verify text $serialization_type is equal to "CRDL_TO_GRAVE"
						Then I execute scenario "Mobile Scan Serial Number Cradle to Grave Picking"
                    Else I fail step with error message "ERROR: Serial Number Screen seen, but serialization type cannot be determined"
                    EndIf
                EndIf
				
		  	And I "check if I am done with the list and increment the pick counter"
				Then I assign "List Pick Completed" to variable "mobile_dialog_message"
				And I execute scenario "Mobile Set Dialog xPath"
				If I see element $mobile_dialog_elt in web browser within $screen_wait seconds
					Then I press keys "ENTER" in web browser
				EndIf

		  		Then I wait $screen_wait seconds 
                And I increase variable "picks_confirmed"
		Endif

		If I verify variable "single_pick_flag" is assigned
		And I verify text $single_pick_flag is equal to "TRUE" ignoring case
           Then I assign "TRUE" to variable "work_assignment_loop_done"
           And I unassign variable "single_pick_flag"
        EndIf
        
	EndWhile 
    
#############################################################
# Private Scenarios:
#	Mobile Acknowledge Work Assignment - Acknowledge the directed work
#	Mobile Sign on to Work Assignment - Perform an undirect sign onto a work list
#	Mobile List Pick Vehicle Full - Handles logic to set down list pick pallet using Equipment Full option and resume the remaining picks on a different list.
#	Mobile List Pick Set Down - Handles logic to set down list pick pallet using Set Down option and resume the remaining picks on the same list.
#############################################################

@wip @private
Scenario: Mobile Acknowledge Work Assignment  
#############################################################
# Description: This scenario Acknowledges the assigne work assignment
# MSQL Files:
#	None
# Inputs:
# 	Required:
#		None
# 	Optional:
#		None
# Outputs:
# 	None
#############################################################

Given I "press Enter to Acknowledge"
	Once I see element "xPath://span[contains(text(),'Next [Enter]')]" in web browser
	Then I press keys "ENTER" in web browser
	And I wait $screen_wait seconds
	  
Given I "check to see if I am resuming a list"
	If I verify variable "lpck_action" is assigned
	And I verify text $lpck_action is equal to "SET_DOWN" ignoring case
	And I verify variable "set_down_mode" is assigned
	And I verify text $set_down_mode is equal to "TRUE" ignoring case
		Then I assign "Uncompleted" to variable "mobile_dialog_message"
		And I execute scenario "Mobile Set Dialog xPath"
		Once I see element $mobile_dialog_elt in web browser
		And I press keys "Y" in web browser

		Then I "am in the load pickup screen, I should pick up the pallet I set down in the PD location. I will input to_id from the last iteration of this scenario which is still on the stack"
			Once I see "Load Pickup" in element "className:appbar-title" in web browser

            Then I assign "LPN" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"
			Then I type $to_id in element "name:lodnum" in web browser within $max_response seconds
			And I press keys "ENTER" in web browser
			And I wait $wait_short seconds 
	Else I see "Work Assignment" in element "className:appbar-title" in web browser within $screen_wait seconds
		And I "enter Work Assignment"
        	Given I execute scenario "Get Load Id for Work Assignment"

            Then I assign "To ID" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"

            Then I execute groovy "to_id = to_id[1..-1].padLeft(9, '0')"
            Then I type $to_id in element "name:to_id" in web browser within $max_response seconds
			And I press keys "ENTER" in web browser
    EndIf

	Then I assign "Pos ID" to variable "input_field_with_focus"
	And I execute scenario "Mobile Check for Input Focus Field"	
	Then I press keys "ENTER" in web browser

@wip @private
Scenario: Mobile Sign on to Work Assignment
#############################################################
# Description: This scenario performs List Picking to completion from the Work Assignment screen.
# MSQL Files:
#	None
# Inputs:
# 	Required:
#		list_id - pick list to be picked
# 	Optional:
#		None
# Outputs:
# 	None
#############################################################

Given I "see the Work Assignment"
	If I see "Work Assignment" in element "className:appbar-title" in web browser within $screen_wait seconds
		Given I "enter the List Id"
			Then I assign "Work Asgnmt" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"
			Then I type $list_id in web browser
			And I press keys "ENTER" in web browser

		Then I "enter the Pick-to Id"
			And I execute scenario "Get Load Id for Work Assignment"
            
            Then I assign "To ID" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"
			Then I type $to_id in element "name:to_id" in web browser within $max_response seconds
			And I press keys "ENTER" in web browser

            Then I assign "Pos ID" to variable "input_field_with_focus"
			And I execute scenario "Mobile Check for Input Focus Field"
			Then I press keys "ENTER" in web browser
			And I wait $wait_short seconds

			Then I press keys "F6" in web browser
			And I execute scenario "Mobile Wait for Processing" 
	EndIf

@wip @private
Scenario: Mobile List Pick Vehicle Full
############################################################
# Description: Sets down the list to pallet LPN to the final staging     
# location with Equipment Full option. Handles logic to perform the      
# remaining picks using directed work.
# MSQL Files:
#	None
# Inputs:
# 	Required:
#		None
# 	Optional:
#       None
# Outputs:
#	None
#############################################################

Given I "press F1 to go to the Deposit Options screen"
	Then I press keys "F1" in web browser
	And I wait $screen_wait seconds

	Once I see "Deposit Options" in element "className:appbar-title" in web browser
	And I click element "xPath://span[contains(text(),'Equipment Full') and contains(@class,'label')]" in web browser within $max_response seconds

	Then I assign "List Pick Completed" to variable "mobile_dialog_message"
	And I execute scenario "Mobile Set Dialog xPath"
	Once I see element $mobile_dialog_elt in web browser
	Then I press keys "ENTER" in web browser

Then I "assign the other part of the list pick which is now generated under a new list ID to the same user"
	And I "wait some time for work generated to release" which can take between $wait_long seconds and $max_response seconds
	And I execute scenario "Assign Work to User by Order and Operation"
	Then I execute scenario "Mobile Deposit"

And I "should have the remaining picks in a new list in directed work"
	Once I see "Pick List At" in element "className:appbar-title" in web browser
	Then I "copy the list ID from the Mobile App screen"
		And I copy text inside element "xPath://span[contains(text(),'List ID')]/ancestor::aq-displayfield[contains(@id,'list_id')]/descendant::span[contains(@class,'data')]" in web browser to variable "list_id" within $max_response seconds

	When I execute scenario "Check List Pick Directed Work Assignment"
	And I verify MOCA status is 0

	Then I echo "The Current Work is a List Pick. Proceeding...."
		And I execute scenario "Mobile Acknowledge Work Assignment"

Once I see "Order Pick" in element "className:appbar-title" in web browser

@wip @private
Scenario: Mobile List Pick Set Down
############################################################
# Description: Sets down the list to pallet LPN to a PND location        
# with Set Down option. Handles logic to resume the list through         
# directed work.
# MSQL Files:
#	get_pndloc_for_lpck_set_down.msql
# Inputs:
# 	Required:
#		None
# 	Optional:
#       None
# Outputs:
#	None
#############################################################

Given I "press F1 to go to the Deposit Options screen"
	Then I press keys "F1" in web browser
	And I wait $screen_wait seconds

Then I "choose setdown from Deposit options"
	Once I see "Deposit Options" in element "className:appbar-title" in web browser
	Then I click element "xPath://span[contains(text(),'Set Down') and contains(@class,'label')]" in web browser within $max_response seconds

And I "select a PD location to set down this pallet"
	Then I assign "get_pndloc_for_lpck_set_down.msql" to variable "msql_file"
	When I execute scenario "Perform MSQL Execution"
	And I verify MOCA status is 0
	And I assign row 0 column "stoloc" to variable "dep_loc"
	Then I execute scenario "Mobile Deposit"
	And I wait $screen_wait seconds

Then I "assign the other part of the resume list pick work which is now generated to the same user"
	And I "wait some time for work generated to release" which can take between $wait_long seconds and $max_response seconds 
	Given I execute scenario "Mobile Navigate Quickly to Undirected Menu"
	And I assign "RLPCK" to variable "oprcod"
	Then I execute scenario "Assign Work to User by Order and Operation"
	And I execute scenario "Mobile Navigate to Directed Work Menu"
	Once I see "Pick List At" in element "className:appbar-title" in web browser
    
And I "copy the list ID from the Mobile App screen"
	Then I copy text inside element "xPath://span[contains(text(),'List ID')]/ancestor::aq-displayfield[contains(@id,'list_id')]/descendant::span[contains(@class,'data')]" in web browser to variable "list_id" within $max_response seconds

	When I execute scenario "Check List Pick Directed Work Assignment"
	And I verify MOCA status is 0

Then I "note, the Current Work is a List Pick. Proceeding...."
	And I assign "TRUE" to variable "set_down_mode"
	Then I execute scenario "Mobile Acknowledge Work Assignment"

Once I see "Order Pick" in element "className:appbar-title" in web browser

@wip @public @Threshold-Picking
Scenario: Mobile Perform Threshold Picking
Given I assign 20 to variable "max_loop_counter"
And I assign 0 to variable "current_count"

When I "confirm Directed Work exists"
	If I see "Pickup Product At" in element "className:appbar-title" in web browser within $screen_wait seconds
		Then I echo "I'm good to proceed as there are directed works"
	Else I assign variable "error_message" by combining "ERROR: No Directed Picks found. Exiting..."
		Then I fail step with error message $error_message
	EndIf
 
And I "perform all associated Threshold Picking"
	Then I assign "FALSE" to variable "DONE" 
	While I do not see element "xPath://span[text()='Looking for Work, Please Wait...']" in web browser within $max_response seconds
		If I see "Pickup Product At" in web browser 
			Then I press keys "ENTER" in web browser
		EndIf
		If I verify text $DONE is equal to "FALSE"
			Then I copy text inside element "xPath://span[contains(text(),'Location')]/ancestor::aq-displayfield[contains(@id,'dsploc')]/descendant::span[contains(@class,'data')]" in web browser to variable "srcloc" within $max_response seconds
		EndIf
 
		#And I execute scenario "Check Pick Directed Work Assignment by Operation and Location"
		#If I verify MOCA status is 0
		#	Then I assign row 0 column "reqnum" to variable "reqnum"
		#	And I assign row 0 column "wh_id" to variable "wh_id"
		#	Then I echo "The Current Work (reqnum = " $reqnum ") is a Threshold Pick. Proceeding...."
 
		#	If I verify text $cancel_and_reallocate is equal to "TRUE" ignoring case
		#		Once I see element "xPath://span[contains(text(),'Next [Enter]')]" in web browser
		#		Then I press keys "ENTER" in web browser
		#	If I see "Threshold Pick" in element "className:appbar-title" in web browser within $wait_med seconds
		#		Then I assign "C-RA" to variable "cancel_code"
		#		And I assign "TRUE" to variable "error_location_flag"
		#		Then I execute scenario "Mobile Cancel Pick from Tools Menu"
		#	Else I verify text $cancel_and_reallocate is not equal to "TRUE" ignoring case
		#		Then I execute scenario "Mobile Pallet Picking Process Detail"
		#		And I execute scenario "Get Directed Work Picking Work Reference by Order Number and Operation"
		#		If I verify variable "cnz_mode" is assigned
		#			And I verify text $cnz_mode is equal to "TRUE" ignoring case
		#			And I execute scenario "Mobile Check for Count Near Zero Prompt"
		#		EndIf
		#		Then I press keys "F6" in web browser
		#		If I see " Deposit" in element "className:appbar-title" in web browser within $wait_long seconds
		#		Else I echo "Retrying F6 operation"
		#			And I press keys "F6" in web browser
		#		EndIf
		#	EndIf
        #        And I execute scenario "Mobile Wait for Processing"
		#	EndIf
		#Else I echo "The current work is not a threshold pick or the work is not assigned to the current user. Exiting..."
		#	And I assign "TRUE" to variable "DONE"
		#EndIf 
		If I see "Threshold Pick" in web browser
			If I verify text $cancel_pick is equal to "YES" ignoring case
				And I execute scenario "Mobile Cancel Pick from Tools Menu"
				And I execute scenario "Mobile Logout"
			Elsif I verify text $cancel_pick is equal to "NO" ignoring case
				If I see element "name:lodnum" in web browser
					And I "enter inventory identifier"
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
					Then I "see Inventory falls outside of threshold pick variance. Ok to pickup? Y/N"
						If I see "Inventory falls outside of threshold pick variance. Ok to pickup? Y/N" in web browser 
							Then I press keys "Y" in web browser
						EndIf
				EndIf
				
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
			
			If I see "Threshold Split" in web browser within 3 seconds
				And I "get the Split LPN"
					Then I execute MOCA script "Scripts\MSQL_Files\Custom\generate_lpn.msql"
					And I verify MOCA status is 0
					Then I assign row 0 column "lodnum" to variable "spltlod"
					Then I type $spltlod in element "name:spltlod" in web browser within $max_response seconds
					And I press keys "ENTER" in web browser

				And I "copy split qty to input"
					Once I see element "name:usrspltqty" in web browser
					When I copy text inside element "xPath://span[contains(text(),'Splt Qty Rqd:')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "spltqty" within $short_sec_wait seconds
						And I echo $lodnum
					
					And I execute Groovy "spltqty = spltqty.split(' ')[0]" within $wait_med seconds
					Once I see element "name:usrspltqty" in web browser
					Then I type $spltqty in element "name:usrspltqty" in web browser
					And I press keys "ENTER" in web browser

				And I "see element UOM"
				If I see element "name:uomcod" in web browser within $wait_med seconds
					And I press keys "ENTER" in web browser
				EndIf
			EndIf
			If I see "MRG Threshold Deposit" in web browser
				And I execute scenario "Mobile Threshold Deposit"
			EndIf

        And I wait $wait_med seconds
	EndWhile

@wip @private
Scenario: Select Picking Process
############################################################
# Description: Sets down the list to pallet LPN to a PND location        
# with Set Down option. Handles logic to resume the list through         
# directed work.
# MSQL Files:
#	get_pndloc_for_lpck_set_down.msql
# Inputs:
# 	Required:
#		oprcod must be equal to LPCK, PCK or CART
# 	Optional:
#       None
# Outputs:
#	None
#############################################################
When I "perform verify the type of pick and perform the pick"
	If I verify text $oprcod is equal to "LPCK"
		And I execute scenario "Mobile Perform Directed List Pick"
	Elsif I verify text $oprcod is equal to "CHANNELWA"
		And I execute scenario "Mobile Perform Directed List Pick"
    Elsif I verify text $oprcod is equal to "PCK"
    	Then I execute scenario "Mobile Perform Pallet Pick for Order"
    Elsif I verify text $oprcod is equal to "CART"
    	Then I execute scenario "Mobile Perform Directed Carton Pick"
	Elsif I verify text $oprcod is equal to "TPCK"
		Then I execute scenario "Mobile Perform Threshold Picking"
	Elsif I verify text $oprcod is equal to "SPCK"
		Then I execute scenario "Mobile Perform Slotted Picking"
    EndIf