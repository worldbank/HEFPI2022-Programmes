////////////////////////////////////////////////////////////////////////////////
/////////         XXXXXXX          ///////////////////
////////////////////////////////////////////////////////////////////////////////

* set up																		
**********
tempfile tpf1 tpf2 tpf

local refid "MMR_2015_MPLCS_v01_M"

*******************************************************************************************
				***   IMPORT AND MERGE FILES AT HH LVL   ***
*******************************************************************************************
																				** </_import_>
																				
*INSERT1

use "${SOURCE}/WB MICRO DATA/`refid'/Data/mplcs_consaggregate_health.dta", clear

*INSERT2
																				// </_import_>

*******************************************************************************************
					***   COMMON VARIABLES   ***
*******************************************************************************************
																				** <_common_vars_>

* Health exp																		** <_hexp_>	
	gen hh_hexp= hlthex_self*spi_v3
																					// </_hexp_>
																																			
* Total household expenditure (annual)												** <_exp_>
	gen hh_exp= totex * spi_v3
																					// </_exp_>


* Food / non-food expenditure (annual)												** <_fexp_>

	gen hh_fexp= fdex
	gen hh_nfexp = hh_exp - hh_fexp
																					// </_fexp_>


* survey variables																	** <_svy_>
	gen hh_size=nhhm
	gen hh_strata=strata
	gen hh_psu=id6_ea_code
	ren id1 hh_region
	ren questionnaire hh_id
	gen hh_urban = id5 == 1
	
	gen hh_sampleweight=hh_wt
	gen popweight = int(hh_size*hh_sampleweight)
																					// </_svy_>
																				
* GAUL calssification
	tempfile tpf1
	preserve
	use "${OUT}/Subnational regions.dta",clear
		keep if iso3c=="MMR"
		list , sep(0)
		sort gl_adm1_code  
		save `tpf1' ,replace
	restore
	
	decode hh_region, gen (gl_adm1_name)
	replace gl_adm1_name = "Ayeyawaddy"  if gl_adm1_name =="Ayeyarwaddy"
	replace gl_adm1_name = "Kayar"  if gl_adm1_name =="Kayah"
	replace gl_adm1_name = "Bago (E)"  if id2 == 701 | id2 == 702
	replace gl_adm1_name = "Bago (W)"  if id2 == 703 | id2 == 704	
	replace gl_adm1_name = "Shan (E)"  if id2 == 1311 | id2 == 1313	
	replace gl_adm1_name = "Shan (N)"  if id2 == 1304 | id2 == 1305 | id2 == 1306	
	replace gl_adm1_name = "Shan (S)"  if id2 == 1301 | id2 == 1302 | id2 == 1303

	merge m:1 gl_adm1_name using `tpf1'	// NayPyitaw not added, which is the capital city that doesn't belong to any region or state 
	replace gl_adm0_code = -7	if _m ==1
	replace gl_adm1_code = -7	if _m ==1
	replace gl_adm1_name = "admin change" 	if _m ==1
	replace gl_adm1_name_alt = "admin change" if _m ==1
	drop if _m == 2
	drop _m // fully merged
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

gen cons = hh_expcapd*365/12/PPP
gen cons_LCU = hh_expcapd*365/12
mean cons* PPP [aw=popweight]


/*
----------------- PPP$ and local currency --------------
         PPP used in computation: 320.604
     Data mean in local currency: 64448.7
               Data mean in PPP$: 170.783
        Poverty line in PPP$/Day: 1.9
      Poverty line in PPP$/Month: 57.7917
  Poverty line in local currency: 21808.9
------------------------------------------------------- */
