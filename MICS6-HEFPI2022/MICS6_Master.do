////////////////////////////////////////////////////////////////////////////////////////////////////
*** MICS MONITORING
////////////////////////////////////////////////////////////////////////////////////////////////////

version 14.0
clear all
set matsize 3956, permanent
set more off, permanent
set maxvar 32767, permanent
capture log close
sca drop _all
matrix drop _all
macro drop _all

******************************
*** Define main root paths ***
******************************

* Define root depend on the stata user. 


global root "[ROOT DIRECTORY]"
global SOURCE "[RAW DATA DIRECTORY]" // DEFAULT RAW DATA DIRECTORY
global OUT "[FINAL OUTPUT DIRECTORY]" // DEFAULT DHS-VII WAVE OUTPUT PATH
global INTER "[INTERMEDIATE OUTPUT DIRECTORY]" // INTERMEDIATE DIRECTORY
	
global DO "${root}\do" // DEFAULT DO FILE FOLDER

* Define the country names (in globals)
do "${DO}/0_GLOBAL.do"	

*Survey countries defined as GLOBAL MACRO to be processed*

foreach name in $MICScountries {
	clear 
	tempfile wm ch ch_itn bh

*******************************
***** Domains using WOMEN DATA*
*******************************

	use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'wm.dta", clear	

* Prepare
	gen country_name = "`name'"
	gen bl2 = 1 if wdoi - wdoblc < 25 // Birth in last two years
	
* Run do files for women data
    do "${DO}/1_antenatal_care"
    do "${DO}/2_delivery_care"
    do "${DO}/3_postnatal_care"
	do "${DO}/4_sexual_health"

* Housekeeping for women data
	if inlist("`name'","Nepal2019") {
	drop welevel2  //there're both *level1 and *level2, to avoid the ambiguity of the specification, dropping the *level2 here. 
	}
	gen hm_male = 0 // Gender variable
	gen hm_educ = welevel // Educational level
	gen hm_age_yrs = wb4 // Age in years
	gen w_sampleweight = . // Woman's sample weight
	replace w_sampleweight = wmweight
	
	sort hh1 hh2 ln
	save `wm', replace

*******************************
***** Domains using CHILD DATA*
*******************************

	use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'ch.dta", clear	
* Prepare
	gen country_name = "`name'"
			
* Run do files for child data
    do "${DO}/7_child_vaccination"
	do "${DO}/8_child_illness"
    do "${DO}/9_child_anthropometrics"
	
* Housekeeping
	gen hm_male = hl4 // Child gender
	recode hm_male (2 = 0)	

	gen hm_age_yrs = ub2 // Child's age in years
	gen hm_age_mon = cage // Child's age in months
	gen c_sampleweight = chweight // Child's sample weight
		
	save `ch', replace

*******************************
***** Domains using ITN DATA*
*******************************	

	capture confirm file "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'tn.dta"
	if !_rc {
	
		use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'tn.dta", clear	
	
* Prepare
		gen country_name = "`name'"
	
* Run do file
	do "${DO}/18_child_ITN.do"		
	}

* Housekeeping
	drop country_name
			
* Merge with child_temp
	merge 1:1 hh1 hh2 ln using `ch'
	drop _merge
	

	else{
	gen c_ITN = .
	}

	save `ch_itn', replace

***********************************
***** Domains using BIRTH DATA    *
***********************************
	
	capture confirm file "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'bh.dta"
	if !_rc{					
		
	use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'bh.dta", clear
		global name = "`name'"
	do "${DO}/10_child_mortality.do"
	}
	
	else{
		foreach var in mor_dob mor_wln mor_ali mor_ade mor_afl hm_doi hm_dob mor_male mor_bord mor_int hm_live mor_wght hm_birthorder c_magebrt {
		gen `var' = .
		}
	}
	save `bh', replace
	
***********************************
***** Merge bh + ch + wm         **
***********************************	
	
	use `bh', clear
	
	// Give each birth unique line number - consistent with hh line number
	capture confirm var bh8
	if !_rc{
		rename bh8 ln
		}

	replace ln = 100 if (ln == 0 | ln == .)
	
	by hh1 hh2 ln, sort: gen check = _n
	forvalues i = 2 3 to 30 {
		replace ln = ln + `i' - 1 if check == `i'
	}                                       
	
	// Extra steps required for certain countries
	by hh1 hh2 ln, sort: gen check1 = _n
	if inlist("`name'","SierraLeone2017") {
		gen check2 = 1 if ((hh1 == 115 & hh2 == 24 & ln == 8) | (hh1 == 277 & hh2 == 15 & ln == 9) | (hh1 == 279 & hh2 == 12 & ln == 12) | (hh1 == 426 & hh2 == 10 & ln == 6) | (hh1 == 587 & hh2 == 25 & ln == 9))
		drop if check == 2 & check1 == 1 & check2 == 1
	}
	if inlist("`name'","Togo2017") {
		gen check2 = 1 if ((hh1 == 246 & hh2 == 11 & ln == 8 & mor_dob == 1372) | (hh1 == 246 & hh2 == 11 & ln == 7 & mor_dob == 1372))
		drop if check2 == 1
	}
	
	mmerge hh1 hh2 ln using `ch_itn'
	drop _merge

* merge with women
	mmerge hh1 hh2 ln using `wm'
	drop _merge
		
	if inlist("`name'","Nepal2019") {
	drop melevel2 //there're both *level1 and *level2, to avoid the ambiguity of the specification, dropping the *level2 here. 
	}

	do "${DO}/19_child_maternal_edu.do"

* Housekeeping
	keep hh1 hh2 hh7 ln c_* w_* mor_* hm_* 	
	rename ln hl1

***********************************
*****      Merge ind with hl     **
***********************************

* Merge individual level data with household listing
	mmerge hh1 hh2 hl1 using "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hl.dta"
	drop _merge

* Housekeeping
	replace hl1 = . if hl1 > 99	// "NOT listed" children in "bh" dataset
	rename hl1 ln
	replace hm_male = hl4
	recode hm_male (2 = 0)
	replace hm_age_yrs = hl6 
	clonevar hm_headrel = hl3
	gen country_name = "`name'"
	
	capture confirm variable hl7
	if !_rc {
		gen hm_stay = hl7
		recode hm_stay (7/9 = .)
		recode hm_stay (2 = 0)
	}
	else {
		gen hm_stay = .
	}
	
	keep hh1 hh2 ln c_* w_* mor_*  hm_*

***********************************
*****      Merge with hh         **
***********************************	

	global trigger_change_structure = 1	
	
	if ${trigger_change_structure} == 1 {
		tempfile pre_hh
		save `pre_hh', replace

		use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hh.dta", replace
		merge 1:m hh1 hh2 using `pre_hh'

		drop if _merge != 3 /*as the base is now HH.dta, must ensure _merge == 1 is screened out*/
		drop _merge		
	}
	if ${trigger_change_structure} == 0 {
	mmerge hh1 hh2 using "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hh.dta", nolabel
	drop if _merge == 2
	drop _merge
	}
	
	gen country_name = "`name'"
		
	if inlist("`name'","Nepal2019") {
		drop helevel2 //there're both *level1 and *level2, to avoid the ambiguity of the specification, dropping the *level2 here. 
	}	
	do "${DO}/20_hh_sanitation.do" 
	do "${DO}/15_household.do"
	do "${DO}/21_subnational_regions.do"

* Housekeeping
	keep hh1 hh2 ln hh_* c_* w_* mor_*  hm_* gl_adm1_code gl_adm0_code

***********************************
*****      Merge with iso        **
***********************************	

	gen survey = "MICS"
	gen year = substr("`name'",-4,4)
	display "`name'"
	gen WB_cname = regexs(0) if regexm("`name'","([a-zA-Z]+)")
	
	replace WB_cname = "Lao PDR" if WB_cname == "LaoPDR"
	replace WB_cname = "Sierra Leone" if WB_cname == "SierraLeone"
	replace WB_cname = "Kyrgyz Republic" if WB_cname == "KyrgyzRepublic"
	replace WB_cname = "The Gambia" if WB_cname == "Gambia"
	replace WB_cname = "Dem. Rep. Congo" if WB_cname == "Congodr"
	replace WB_cname = "Costa Rica" if WB_cname == "CostaRica"
	replace WB_cname = "West Bank and Gaza" if WB_cname == "StateofPalestine"
	replace WB_cname = "Macedonia" if WB_cname == "NorthMacedonia"
	replace WB_cname = "Central African Republic" if WB_cname == "CentralAfricanRepublic"
	replace WB_cname = "Sao Tome and Principe" if WB_cname == "SaoTomeAndPrincipe"
	replace WB_cname = "Turks and Caicos Islands" if WB_cname == "TurksCaicosIslands"
	replace WB_cname = "Dominican Republic" if WB_cname == "DominicanRepublic"
	

			
	* Label variables
	do "${DO}/Lab_var.do"
		
* Save micro-dataset
	order survey year country hh1 hh2 ln  c_* w_* mor_* ln hm_* hh_*
		
	saveold "${OUT}/MICS6-`name'Adept.dta", replace


}		


