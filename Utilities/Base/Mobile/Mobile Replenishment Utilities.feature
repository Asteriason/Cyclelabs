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
# Utility: Mobile Replenishment Utilities.feature
# 
# Functional Area: Replenishment
# Author: Netlogistik
# Blue Yonder WMS Version: Consult Bundle Release Notes
# Test Case Type: Utility
# Blue Yonder Interfaces Interacted With: Mobile, MOCA
#
# Description: Utilities that are common across all replenishment operations - including getting and validating data in the Mobile App
#
# Public Scenarios:
#	- Mobile Replenishment - performs Case or Pallet Replenishment
#
# Assumptions:
# None
#
# Notes:
# None
#
############################################################
Feature: Mobile Replenishment Utilities


@wip @public
Scenario: Mobile Perform Pallet Replenishment
#While I verify number "current_count" is less than "max_loop_counter"
While I do not see "Looking for Work" in web browser within $wait_med seconds

	If I see "Pickup Product At" in element "className:appbar-title" in web browser
    	Once I see "Source Location" in web browser
		Then I press keys "ENTER" in web browser
    EndIf
    
    If I see "Replenish Pick" in element "className:appbar-title" in web browser
    	Once I see element "name:lodnum" in web browser
        When I copy text inside element "xPath://div[contains(@class, 'center')]//span" in web browser to variable "lodnum"
        Then I type $lodnum in element "name:lodnum" in web browser
        And I press keys "ENTER" in web browser

		Once I see element "name:stoloc" in web browser
    	When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
        Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
        Given I assign row 0 column "locvrc" to variable "location_verification_code"
        Then I type $location_verification_code in element "name:stoloc" in web browser
        And I press keys "ENTER" in web browser
	EndIf

	If I see "Order Pick *" in web browser 
		And I "enter inventory identifier"
			Once I see element "name:lodnum" in web browser
			When I copy text inside element "xPath://div[contains(@class, 'center')]//span" in web browser to variable "lodnum"
			Then I type $lodnum in element "name:lodnum" in web browser
			And I press keys "ENTER" in web browser
		Then I "enter location"
			Once I see element "name:stoloc" in web browser
			When I copy text inside element "xPath://span[contains(text(),'Location')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "verify_location"
			Then I execute MOCA script "Scripts\MSQL_Files\Base\get_location_verification_code.msql"
			Given I assign row 0 column "locvrc" to variable "location_verification_code"
			Then I type $location_verification_code in element "name:stoloc" in web browser
			And I press keys "ENTER" in web browser
		And I "enter item number"
			Once I see element "name:prtnum" in web browser 
			When I copy text inside element "xPath://span[contains(text(),'Item Number')]/following-sibling::div/span[@class='data ng-star-inserted']" in web browser to variable "prtnum"
			Then I type $prtnum in element "name:prtnum" in web browser
			And I press keys "ENTER" in web browser
		And I "enter unit qty"
			Once I see element "name:untqty" in web browser 
			And I press keys "ENTER" in web browser
		And I "enter uom"
			Once I see element "name:uomcod" in web browser 
			And I press keys "ENTER" in web browser
	EndIf
    If I see "MRG Product Deposit" in web browser
    	If I see element "name:lodnum" in web browser within $wait_short seconds
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
EndWhile

@wip @public
Scenario: Mobile Replenishment
#############################################################
# Description: This scenario performs top-level work for a
# case or pallet replenishment
# MSQL Files:
#	None
# Inputs:
#	Required:
#		One of the optional parameters
#	Optional:
#		palloc - pallet location where replenishment should occur
#		casloc - case location where replenishment should occur
# Outputs:
# 	None           
#############################################################

Given I "wait some time for Replenishment Work to release" which can take between $wait_med seconds and $wait_long seconds 

And I "obtain the Work Reference"
	If I verify variable "palloc" is assigned
    	Then I assign $palloc to variable "t_storage_location"
		And I assign "pallet" to variable "replen_type"
	Elsif I verify variable "casloc" is assigned
    	Then I assign $casloc to variable "t_storage_location"
		And I assign "case" to variable "replen_type"
	Else I fail step with error message "ERROR: Neither palloc or casloc location variables were defined"
	Endif

	When I execute scenario "Get Replenishment Pick Work Reference"
	And I execute scenario "Get Directed Replenishment Work by Work Reference and Operation"
	If I verify MOCA status is 0
	Else I assign variable "error_message" by combining "ERROR: We do not have any Replenishment Picks. Exiting..."
		Then I fail step with error message $error_message
	EndIf 
	
And I "confirm Directed Work exists"
	If I see "Pickup Product At" in element "className:appbar-title" in web browser within $wait_long seconds
		Then I echo "I'm good to proceed as there are directed works"
   	Else I assign variable "error_message" by combining "ERROR: There are no directed replenishment picks. Exiting..."
		Then I fail step with error message $error_message
	EndIf

Then I "perform all of the Replenishment picks"
	Given I assign 0 to variable "DONE"
	While I see "Pickup Product At" in element "className:appbar-title" in web browser within $screen_wait seconds
	And I verify number $DONE is equal to 0
		Given I "copy the Source Location from the Mobile App screen"
			Then I copy text inside element "xPath://span[contains(text(),'Source Location')]/ancestor::aq-displayfield[contains(@id,'dsploc')]/descendant::span[contains(@class,'data')]" in web browser to variable "srcloc" within $max_response seconds
		
		When I "perform each Replenishment pick"
			When I execute scenario "Check Pick Directed Work Assignment by Operation and Location"
			If I verify MOCA status is 0
				Given I assign row 0 column "reqnum" to variable "reqnum"
				And I assign row 0 column "wh_id" to variable "wh_id"
				When I execute scenario "Mobile Process Replenishment Pick"
				Then I execute scenario "Get Directed Replenishment Work by Work Reference and Operation"
				And I execute scenario "Mobile Deposit"
			Else I echo "ERROR: The Current Work is not a Pallet Replen Pick or the Work is not assigned to the Current User. Exiting..."
				Then I assign "1" to variable "DONE"
			EndIf
	EndWhile

#############################################################
# Private Scenarios:
#	Mobile Process Replenishment Pick - Directed work pickup and process.
#############################################################

@wip @private
Scenario: Mobile Process Replenishment Pick
#############################################################
# Description: From directed work, once you are on the 
# Replenish Pick Screen, process the screen inputs.
# These inputs are slightly different for case versus pallet
# replenishments.
# MSQL Files:
#	None
# Inputs:
#	Required:
#		replen_type - either case or pallet
#	Optional:
#		None
# Outputs:
# 	None           
#############################################################

Given I "press Enter to Acknowledge"
	And I see element "xPath://span[contains(text(),'Next [Enter]')]" in web browser
	Then I press keys "ENTER" in web browser
	Once I see "Replenish Pick" in element "className:appbar-title" in web browser
 
And I "copy the replenishment pick source location from the Mobile App screen"
	Then I copy text inside element "xPath://span[contains(text(),'Location')]/ancestor::aq-displayfield[contains(@id,'dsploc')]/descendant::span[contains(@class,'data')]" in web browser to variable "srcloc" within $max_response seconds
	And I wait $wait_short seconds
	And I execute groovy "srcloc = srcloc.trim()"
 
And I "copy the part number from the Mobile App screen"
	Then I copy text inside element "xPath://span[contains(text(),'Item Number')]/ancestor::aq-displayfield[contains(@id,'dspprt')]/descendant::span[contains(@class,'data')]" in web browser to variable "prtnum" within $max_response seconds
	And I wait $wait_short seconds
	And I execute groovy "prtnum = prtnum.trim()"
 
And I "copy the client ID from the Mobile App screen"
	Then I copy text inside element "xPath://span[contains(text(),'Item Client ID')]/ancestor::aq-displayfield[contains(@id,'dspprtcli')]/descendant::span[contains(@class,'data')]" in web browser to variable "client_id" within $max_response seconds
	And I wait $wait_short seconds
	And I execute groovy "client_id = client_id.trim()"
 
And I "get a case or pallet number from the pick location that will be the case we will pick"
	Then I execute scenario "Get Case Number from Source Location for Picking"
	If I verify MOCA status is 0
		Then I assign row 0 column "lodnum" to variable "srclod"
	Else I assign variable "error_message" by combining "ERROR: The inventory in this location is not equal to what we expect to pick"
		Then I fail step with error message $error_message
	EndIf 
 
When I "complete Replenishment Screen for either case or pallet replenishment"
	Then I type $srclod in web browser
	And I press keys "ENTER" in web browser
	If I verify text $replen_type is equal to "case"
		And I wait $screen_wait seconds
		Then I press keys "ENTER" in web browser
	EndIf