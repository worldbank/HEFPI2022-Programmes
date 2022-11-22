//// MICS6-dofiles
//Do-file for the maternal education :
/// c_mateduclvl_raw
/// c_mateduc
	
		local name "$name"
		
	clonevar c_mateduclvl_raw = melevel // raw variable preserved

	recode hm_educ (0 = 1) (1 = 2) (2/6 = 3) (8/9 = .)     // recode woman education 
	recode melevel (0 = 1) (1 = 2) (2/6 = 3) (8/9 = .)		// recode mother education from child dataset
	label define w_label 1 "none" 2 "primary" 3 "lower sec or higher"
	label values hm_educ w_label
	label values melevel w_label

	gen matline = wm3                         // woman's line number
	bysort hh1 hh2 matline: egen mat_educ = max(hm_educ)  // assign maternal education to all of her children
	drop matline
	gen matline = uf4 
	bysort hh1 hh2 matline: egen helper = max(hm_educ)
	*order hh1 hh2 matline hm_educ mat_educ helper
	replace mat_educ = helper if mat_educ == .
	drop helper hm_educ 
	rename mat_educ c_mateduc
	replace c_mateduc = melevel if melevel!=.

	if ("`name'" == "Zimbabwe2019") {
		replace c_mateduc = . if c_mateduc > 3
	}	
