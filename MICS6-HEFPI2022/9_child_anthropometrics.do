///// Batch MICS6-dofiles
//Do-file for the indicator:
/// c_stunted
/// c_underweight
/// c_stu_was
/// c_stu_was_sev
/// c_motherln

if inlist(country_name,"Belarus2019","Vietnam2020") {
	gen c_height = .
	gen c_weight = .
	gen c_hfa = .
	gen c_stunted = .
	gen c_stunted_sev = .
	gen c_wfa = .
	gen c_underweight = .
	gen c_underweight_sev = .
	gen c_wfh = .
	gen c_wasted = .
	gen c_wasted_sev = .
	
	gen c_stu_was = .
	gen c_stu_was_sev = .
}

else {
	* c_height and c_weight
		gen c_height = .
		gen c_weight = .
		replace c_height = an11
		replace c_height = . if an11>900
		replace c_weight = an8
		replace c_weight = . if an8>90

*c_stunted: Child under 5 stunted
		gen c_haz = .
		gen c_stunted = .
		gen c_stunted_sev = .
		replace c_haz = haz2
		replace c_stunted = haz2 < -2						// stunted if child is more than 2 SDs below HAZ reference
		replace c_stunted_sev = haz2 < -3					// severly stunted if child is more than 3 SDs below HAZ reference
		for var c_stunted c_stunted_sev c_haz: replace X = . if inlist(hazflag,.,1)		// missing if height or age flagged
		rename c_haz c_hfa
	

*c_underweight: Child under 5 underweight
		gen c_waz = .
		gen c_underweight = .
		gen c_underweight_sev = .
		replace c_waz = waz2
		replace c_underweight = waz2 < -2					// stunted if child is more than 2 SDs below WAZ reference
		replace c_underweight_sev = waz2 < -3					// severly stunted if child is more than 3 SDs below WAZ reference
		for var c_underweight c_underweight_sev c_waz: replace X = . if inlist(wazflag,.,1)	// missing if weight or age flagged
		rename c_waz c_wfa

*c_wasted: Child under 5 wasted
		gen c_whz = .
		gen c_wasted = .
		gen c_wasted_sev = .
		replace c_whz = whz2
		replace c_wasted = whz2 < -2						// stunted if child is more than 2 SDs below WAZ reference
		replace c_wasted_sev = whz2 < -3						// stunted if child is more than 2 SDs below WAZ reference
		for var c_wasted c_wasted_sev c_whz: replace X = . if inlist(whzflag,.,1)	// missing if weight or age flagged
		rename c_whz c_wfh
		
*c_stu_was: Both stunted and wasted
		gen c_stu_was = (c_stunted == 1 & c_wasted ==1) 
		replace c_stu_was = . if c_stunted == . | c_wasted == . 
		label define l_stu_was 1 "Both stunted and wasted"
		label values c_stu_was l_stu_was		

*c_stu_was_sev: Both severely stunted and severely wasted		
		gen c_stu_was_sev = (c_stunted_sev == 1 & c_wasted_sev == 1)
		replace c_stu_was_sev = . if c_stunted_sev == . | c_wasted_sev == . 
		label define l_stu_was_sev 1 "Both severely stunted and severely wasted"
		label values c_stu_was_sev l_stu_was_sev
}

*c_motherln
clonevar c_motherln = uf4
