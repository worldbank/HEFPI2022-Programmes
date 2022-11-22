*																				*
*			DO FILE CREATED BY /generic/ENAHO_populate.sh						*
*						subject to be wiped anytime								*
*																				*
* Raw files still processed in /RAW DATA/PERU/									*

////////////////////////////////////////////////////////////////////////////////
/////////         PER_2016_ENAHO_v01_M          ///////////////////
////////////////////////////////////////////////////////////////////////////////

* set up																		
**********
tempfile tpf1 tpf2 tpf temp1 temp2 temp3
local refid "PER_2016_ENAHO_v01_M"
local year = substr("`refid'",5,4)


* do "$SOURCE\WB MICRO DATA\`refid'\Data\P_prepare_HHEXP_2018.do"	\\ --> ENAHO-Peru2018-oop.dta


*******************************************************************************************
				***   IMPORT AND MERGE FILES AT HH LVL   ***
*******************************************************************************************
																				** </_import_>
																				
*INSERT1

use "${SOURCE}/WB MICRO DATA/`refid'/Data/ENAHO-Peru`year'.dta", clear
sort conglome vivienda hogar
save `tpf', replace

use "${SOURCE}/WB MICRO DATA/`refid'/Data/ENAHO-Peru`year'-oop.dta", clear
sort conglome vivienda hogar
merge 1:1 conglome vivienda hogar using `tpf'
tab _m
drop _m


*INSERT2
																				// </_import_>
*******************************************************************************************
					***   COMMON VARIABLES   ***
*******************************************************************************************
																				** <_common_vars_>

* Health exp																		** <_hexp_>	
	gen hh_hexp=oop_cantidad

																					// </_hexp_>
																				
																					
* Total household expenditure (annual)												** <_exp_>
	gen hh_exp=gashog2d
																					// </_exp_>


* Food / non-food expenditure (annual)												** <_fexp_>
	gen hh_fexp=gru11hd+gru12hd1+gru12hd2+gru13hd1+gru13hd2+gru13hd3+gru13hd4+gru14hd+gru14hd1+gru14hd2+gru14hd3+gru14hd4+gru14hd5+gru14hd6
	gen hh_nfexp = hh_exp-hh_fexp
																					// </_fexp_>
																				
																				
* survey variables																	** <_svy_>
	gen hh_id = conglome + vivienda + hogar
	gen hh_size=mieperho
	gen hh_sampleweight=factor07
	gen popweight = hh_size*hh_sampleweight
	gen hh_strata=estrato
	gen hh_psu=vivienda
	gen hh_region=dominio
	gen rururb=urbano
	gen hh_urban=urbano
																					// </_svy_>
																				

																				** </_common_vars_>


																				
********************************************************************************************
				***   Survey Specific modifications  ***
********************************************************************************************
																				** <_currency_adj_>
*INSERT3

																				// </_currency_adj_>

*******************************************************************************************
				*** SURVEY IDENTIFICATION VARIABLES   ***
*******************************************************************************************
																				** <_survey_id_>
cap label drop _all
** Reference ID follows DDI see IHSN (http://catalog.ihsn.org/index.php/catalog)
	gen referenceid=    "`refid'"
** First v position
	local v1 = strpos(referenceid,"v")
** Second v position
	local v2 = strpos(subinstr(referenceid, "v", "x", 1), "v")
** String length
	local len = strlen(referenceid)
** Extract survey from referenceid
	cap drop survey
	generate str1 survey = ""
	cap replace survey = substr(referenceid,10,`v1' - 11)
** Extract adaptation from referenceid
	generate str1 adapt = ""
	replace adapt = substr(referenceid,`v2'+6,`len' - (`v2'+5)) if `v2'!=0
** Extract year from referenceid
	cap drop year
	gen year = substr(referenceid,5,4)
	destring year, replace
** Extract iso3c from referenceid
	cap drop iso3c
	gen iso3c = substr(referenceid,1,3)
	local iso3c = iso3c
** Merge with CountryCodes.dta
	save `tpf', replace
	merge m:1 iso3c using "${SOURCE}/CountryCodes.dta"
	labmask iso3n, value(iso3c)
	drop if _merge==2
	drop _merge
	order referenceid iso3c iso3n year survey adapt WB_cname WHO_cname
																				// </_survey_id_>
local cname = iso3c
local year = year


*******************************************************************************************
				***   STANDARD EXPENDITURE   ***
*******************************************************************************************
																				
**Add poverty lines
	merge m:1 iso3c year using "${OUT}/PPPfactors_2011.dta"
	tab _merge
	keep if _merge==3
	drop _merge

** std exp	
	qui do "${DO}/Standard-Expenditure${stdexp_v}.do"	

** labels
	qui do "${DO}/Label-Variables.do"
																				
** save																				
	saveold "${OUT}/ADePT READY/`refid'_ADEPT.dta",replace

////////////////////////////////////////////////////////////////////////////////
////////////////////         E N D           ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

/*
	local refid ""
	use "${OUT}/ADePT READY/`refid'_ADEPT.dta" , clear 
	
	qui do "${DO}/Standard-Indicators_2011PPP_n"
	gen cons_month_PPP = hh_expcapd*365/12/PPP
	gen cons_month_LCU = hh_expcapd*365/12
	mean cons* pos_oop sh_fexp sh_hexp_1 hh_expcapd hh_hexpcapd cata_tot_10 P0_190 PPP [aw=popweight] if inlist(hh_urban,1,0)

*/
