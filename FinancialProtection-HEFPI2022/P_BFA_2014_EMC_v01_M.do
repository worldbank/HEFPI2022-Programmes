********************************   T O C    ***********************************************
*																				*
*  INPUTS : SHIP Collections													    *
*		1) Import and merge files at HH levels									*
*		2) Common variables														*
*	OUTPUTS: ADEPT-READY FILE													*
*										*																				*
*********************************************************************************************


////////////////////////////////////////////////////////////////////////////////
/////////         BFA_2014_EMC_v01_M             ///////////////////
////////////////////////////////////////////////////////////////////////////////



/********************************************************************************************************************************************************
Preparation file for BFA2014

Data on total consumption and food and non-food consumption was given as an aggregate per household per year in the welfare.dta file.
Data on health expenditure was given in 4 different files, which contain all the non-food expenditure of households in a 3-month period.
To obtain the annual health expenditure, the values for the 8 categories of health-related products (as listed on the surveys) were added for each
passage. Then, the 4 passages were merged to obtain the total expenditure for the year. Each passage pertains to the same household
and pertains to expenditure for 3 months. 3 months*4 passages= 1 year ***
**********************************************************************************************************************************************************/


* set up																		
**********
		
local refid "BFA_2014_EMC_v01_M"


*******************************************************************************************
				***   IMPORT AND MERGE FILES AT HH LVL   ***
*******************************************************************************************
																				** </_import_>
*INSERT1

*HEALTH EXPENDITURE DATA*

* hexp passage 1
    use "${SOURCE}/WB MICRO DATA/`refid'/Data/BFA_2014_EMC_v01_M_Stata8/emc2014_p1_conso3mois_16032015.dta", clear
	generate health=0
	replace health = 1 if inlist(product,151,149,150,156,153,137,154,155)
	*create dummy that takes on value of 1 if product is health product and 0 if it is non-health product. List of health products is taken from surveys and is "medicaments modernes; medicaments traditionelles; services hospitalaires; services medicaux; appareilles et materielles; services de laboratoire; services des auxiliaires; produits medicaux"**
	replace achat=0 if health==0
	*Only health-related expenditures are accounted; other expenditures become zero*
	sort hhid
	collapse (sum) achat, by (hhid)
	*sum all categories of health expenditures into an aggregate health expenditure per household. This refers to household expenditures over the last 3 months of the year*
    *Observations are 0 when household had no health expenditures.This way, households that had only other expenses are not dropped, only appear as 0*
    rename achat health_exp1
    tempfile tpf1
	*save "$tmp/a.dta", replace
    save `tpf1', replace 
    
* hexp passage 2
	use "${SOURCE}/WB MICRO DATA/`refid'/DATA/BFA_2014_EMC_v01_M_Stata8/emc2014_p2_conso3mois_16032015.dta", clear
	generate health=0
	replace health = 1 if inlist(product,151,149,150,156,153,137,154,155)
	replace achat=0 if health==0
	sort hhid
	collapse (sum) achat, by (hhid)
    sort hhid
    rename achat health_exp2
	merge 1:1 hhid using `tpf1'
	*197 observations missing. These are households that are not in passage 2. They cannot be there but with missing ids, as passage 2*
	*has no missing values for hhid*
	tab _m
	sort hhid
	cap drop _m
	tempfile tpf2
	save `tpf2', replace 

	
* hexp passage 3			
	use "${SOURCE}/WB MICRO DATA/`refid'/DATA/BFA_2014_EMC_v01_M_Stata8/emc2014_p3_conso3mois_16032015.dta", clear
	generate health=0
	replace health = 1 if inlist(product,151,149,150,156,153,137,154,155)
	replace achat=0 if health==0
	sort hhid
	collapse (sum) achat, by (hhid)
    sort hhid
	rename achat health_exp3
	merge 1:1 hhid using `tpf2'
	tab _m
	sort hhid
	cap drop _m
	tempfile tpf3
	save `tpf3', replace 
	
	
* hexp passage 4	
	use "${SOURCE}/WB MICRO DATA/`refid'/DATA/BFA_2014_EMC_v01_M_Stata8/emc2014_p4_conso3mois_16032015.dta", clear
	generate health=0
	replace health = 1 if inlist(product,151,149,150,156,153,137,154,155)
	replace achat=0 if health==0
	sort hhid
	collapse (sum) achat, by (hhid)
	rename achat health_exp4
	merge 1:1 hhid using `tpf3'
	tab _m
	sort hhid
	drop _m
	drop if hhid==.
	tempfile tpf4
	save `tpf4'
	*total number of observations in merged file is 10,800, which is the number of households surveyed, according to the technical*
	*notes received with this dataset*

*HOUSEHOLD CONSUMPTION DATA*	
*welfare data 	
     use "${SOURCE}/WB MICRO DATA/`refid'/DATA/BFA_2014_EMC_v01_M_Stata8/emc2014_welfare.dta", clear
     sort hhid
     merge 1:1 hhid using `tpf4'
     drop if _m==2 /*dropping observations with health expenditure only*/
     drop _m
     save `tpf5', replace


*******************************************************************************************
					***   COMMON VARIABLES   ***
*******************************************************************************************

* Total household expenditure (annual)	
rename deptotnd hh_exp

* Health expenditure
egen health_exp1_mean = rowmean(health_exp2 health_exp3 health_exp4) if health_exp1==.
egen health_exp2_mean = rowmean(health_exp1 health_exp3 health_exp4) if health_exp2==.	
egen health_exp3_mean = rowmean(health_exp1 health_exp2 health_exp4) if health_exp3==.	
egen health_exp4_mean = rowmean(health_exp1 health_exp2 health_exp3) if health_exp4==.	
egen hh_hexp = rowtotal(health_exp1 health_exp2 health_exp3 health_exp4 health_exp1_mean health_exp2_mean health_exp3_mean health_exp4_mean)

	
*MR: there are 35 observations where it is greater than 30% and 2968 observations where it is smaller than 1%, out of 10,411 observations*

* Food / non-food expenditure (annual)
rename dalim hh_fexp
rename dnalim hh_nfexp	

* survey variables
cap drop zref
rename hhsize hh_size
rename hhid hh_id
gen hh_urban=1 if milieu==1
replace hh_urban=0 if milieu==2
rename hhweight hh_weight
rename hpwei popweight
*population weights are already defined in the data as hh_weight*hh_size. It was verified they are computed as hh_weight* hh_size*
rename strate hh_strata
drop deflateur	
drop pcnorm
rename region hh_region
rename grappe hh_psu

********************************************************************************************
				***   Survey Specific modifications  ***
********************************************************************************************
																				** <_currency_adj_>
gen int  IP_recall = 90
gen      IP_level =	"hh"
gen byte IP_itemN = 1
gen int  OP_recall = 90
gen      OP_level =	"hh"
gen byte OP_itemN =	7
gen spec =	"Cc"


* Gaul Codes
	clonevar Region=hh_region
	decode Region, gen(gl_adm1_name)
	replace gl_adm1_name="Hauts-bassins" if hh_region==1
	replace gl_adm1_name="Boucle Du Mouhoun" if hh_region==2
	replace gl_adm1_name="Sahel" if hh_region==3
	replace gl_adm1_name="Est" if hh_region==4
	replace gl_adm1_name="Sud-ouest" if hh_region==5
	replace gl_adm1_name="Centre-nord" if hh_region==6
	replace gl_adm1_name="Centre-ouest" if hh_region==7
	replace gl_adm1_name="Plateau Central" if hh_region==8
	replace gl_adm1_name="Nord" if hh_region==9
	replace gl_adm1_name="Centre-est" if hh_region==10
	replace gl_adm1_name="Centre" if hh_region==11
	replace gl_adm1_name="Cascades" if hh_region==12
	replace gl_adm1_name="Centre-sud" if hh_region==13
	sort gl_adm1_name

	save "'tpf1'", replace 
	
	use "${OUT}/Subnational regions.dta"
	keep if iso3c=="BFA"
	merge 1:m gl_adm1_name using "'tpf1'"
	tab _merge 
	keep if _merge==3           //all from using matched 
	drop _merge 
	
*INSERT3

																				// </_currency_adj_>

*******************************************************************************************
				*** SURVEY IDENTIFICATION VARIABLES   ***
*******************************************************************************************

																				** <_common_vars_>
** Reference ID follows DDI see IHSN for example: http://catalog.ihsn.org/index.php/catalog
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
	replace adapt = substr(referenceid,`v2'+6,`len' - (`v2'+5)) if `v2'!= 0
** Extract year from referenceid
	cap drop anne
	gen year = substr(referenceid,5,4)
	destring year, replace
** Extract iso3c from referenceid
	cap drop iso3c
	gen iso3c = substr(referenceid,1,3)
** Merge with CountryCodes.dta
    tempfile tpf5
	save `tpf5', replace
	use "${SOURCE}/CountryCodes.dta"
	merge 1:m iso3c using `tpf5'
	labmask iso3n, value(iso3c)
	keep if _merge==3
	drop _merge
	order referenceid iso3c iso3n year survey adapt WB_cname WHO_cname

local cname = iso3c
local year = year
tempfile tpf6
save `tpf6'

******************************************************************************************
				***   STANDARD EXPENDITURE   ***
*******************************************************************************************
																				
**Add poverty lines
	use "${OUT}/PPPfactors_2011.dta"
	merge 1:m iso3c year using `tpf6'
	tab _merge
	keep if _merge==3
	drop _merge

** std exp	
	qui do "${DO}/Standard-Expenditure${stdexp_v}.do"	

** labels
	qui do "${DO}/Label-Variables.do"
																				
** save																				
	saveold "${OUT}/ADePT READY/`refid'_ADEPT.dta",replace
														
******************************************************************************************
				***   Verification   ***
*******************************************************************************************
gen cons_LCU = hh_expcapd*365/12
gen cons = hh_expcapd*365/12/PPP
mean cons cons_LCU PPP [aw=popweight] 


/*
PCN OUTPUT:
----------------- PPP$ and local currency --------------
         PPP used in computation: 222.242
     Data mean in local currency: 18632.77
               Data mean in PPP$: 83.84
        Poverty line in PPP$/Day: 1.9

NOTE: Data from PNC is close to our data.
*/

	
	do "${DO}/Standard-Indicators_2011PPP_n.do"
	tabstat cata_tot_10 imp_np190 imp_p190 [aw=popw], s(mean )

	/* PL we use: 190 320 550 SPL relPL60 */
	
