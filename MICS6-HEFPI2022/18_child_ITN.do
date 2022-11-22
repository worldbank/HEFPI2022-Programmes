//// Batch MICS6-dofiles
//Do-file for the indicator:
/// c_ITN

* Child under 5 - use of insecticide-treated bed nets (ITN)


	// Malawi2019: tn5 - 11-18 
	// tnln - 1~10
	// max value of tnln - 10; tn15_1-16; tn15_2-16; tn15_3-15; tn15_4-18
if inlist(country_name,"Malawi2019") {
			keep if inrange(tn5,10,18)
			by hh1 hh2, sort: gen rank_bednet = _n 

			replace tnln = rank_bednet
			drop rank_bednet

			forvalues t = 5 9 to 37 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 3 * (`t'- 1) / 4
			}
			forvalues t = 6 10 to 38 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 3 * (`t'- 2) / 4 - 1
			}
			forvalues t = 7 11 to 39 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 3 * (`t'- 3) / 4 - 2
			}
			forvalues t = 8 12 to 40 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 3 * (`t'- 4) / 4 - 3
			}

			order tn15_*, sequential
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
			} 

			collapse (sum) tn15_*, by(hh1 hh2) // collapse to household level
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-Malawi2019/MICS6-Malawi2019ch.dta", keepusing(hh1 hh2 ln cage)
	
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*

			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "Malawi2019"
		}



	// SaoTomeAndPrincipe2019: tn5 - 11/12/13/16:outra marca/18: ns marca
	// tnln - 1~10
	// max value of tnln - 10; tn15_1-12; tn15_2-15; tn15_3-14; tn15_4-13
if inlist(country_name,"SaoTomeAndPrincipe2019") {
			keep if inrange(tn5,10,18)
			by hh1 hh2, sort: gen rank_bednet = _n 

			replace tnln = rank_bednet
			drop rank_bednet

			forvalues t = 5 9 to 37 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 3 * (`t'- 1) / 4
			}
			forvalues t = 6 10 to 38 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 3 * (`t'- 2) / 4 - 1
			}
			forvalues t = 7 11 to 39 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 3 * (`t'- 3) / 4 - 2
			}
			forvalues t = 8 12 to 40 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 3 * (`t'- 4) / 4 - 3
			}

			order tn15_*, sequential
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
			} 

			collapse (sum) tn15_*, by(hh1 hh2) // collapse to household level
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-SaoTomeAndPrincipe2019/MICS6-SaoTomeAndPrincipe2019ch.dta", keepusing(hh1 hh2 ln cage)
	
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*

			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "SaoTomeAndPrincipe2019"
		}




	// CentralAfricanRepublic2018: tn5 - 11/12/13/14/15/16:other written down/36: other
	// tnln - 1~10
	// max value of tnln - 10; tn15_1-20; tn15_2-23; tn15_3-22; tn15_4-22
if inlist(country_name,"CentralAfricanRepublic2018") {
			keep if inrange(tn5,10,36)
			by hh1 hh2, sort: gen rank_bednet = _n 

			replace tnln = rank_bednet
			drop rank_bednet

			forvalues t = 5 9 to 37 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 3 * (`t'- 1) / 4
			}
			forvalues t = 6 10 to 38 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 3 * (`t'- 2) / 4 - 1
			}
			forvalues t = 7 11 to 39 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 3 * (`t'- 3) / 4 - 2
			}
			forvalues t = 8 12 to 40 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 3 * (`t'- 4) / 4 - 3
			}

			order tn15_*, sequential
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
			} 

			collapse (sum) tn15_*, by(hh1 hh2) // collapse to household level
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-CentralAfricanRepublic2018/MICS6-CentralAfricanRepublic2018ch.dta", keepusing(hh1 hh2 ln cage)
	
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*

			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "CentralAfricanRepublic2018"
		}

	// Guinea-Bissau2018: tn5 - 11/12/16/18; tnln - 1~10
	// max value of tnln - 10; tn15_1-49; tn15_2-45;tn15_3-39;tn15_4-33
if inlist(country_name,"Guinea-Bissau2018") {
			by hh1 hh2, sort: gen rank_bednet = _n 

			replace tnln = rank_bednet
			drop rank_bednet

			forvalues t = 5 9 to 37 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 3 * (`t'- 1) / 4
			}
			forvalues t = 6 10 to 38 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 3 * (`t'- 2) / 4 - 1
			}
			forvalues t = 7 11 to 39 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 3 * (`t'- 3) / 4 - 2
			}
			forvalues t = 8 12 to 40 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 3 * (`t'- 4) / 4 - 3
			}

			order tn15_*, sequential
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
			} 

			collapse (sum) tn15_*, by(hh1 hh2) // collapse to household level
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-Guinea-Bissau2018/MICS6-Guinea-Bissau2018ch.dta", keepusing(hh1 hh2 ln cage)
	
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*

			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "Guinea-Bissau2018"
		}

	// LaoPDR2017
		
	if inlist(country_name,"LaoPDR2017") {
			keep if (inrange(tn5,10,18) | (inrange(tn5,21,98) & tn9 < 12))
			by hh1 hh2, sort: gen rank_bednet = _n 
			replace tnln = rank_bednet
			drop rank_bednet

			forvalues t = 5 9 to 37 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 3 * (`t'- 1) / 4
			}
			forvalues t = 6 10 to 38 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 3 * (`t'- 2) / 4 - 1
			}
			forvalues t = 7 11 to 39 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 3 * (`t'- 3) / 4 - 2
			}
			forvalues t = 8 12 to 40 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 3 * (`t'- 4) / 4 - 3
			}

			order tn15_*, sequential
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
			} 

			collapse (sum) tn15_*, by(hh1 hh2) // collapse to household level
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-LaoPDR2017/MICS6-LaoPDR2017ch.dta", keepusing(hh1 hh2 ln cage)
			
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*

			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "LaoPDR2017"
		}
		
		
    // SierraLeone2017
			
		if inlist(country_name,"SierraLeone2017") {
			keep if (inrange(tn5,10,18) | (inrange(tn5,21,98) & tn9 < 12))
			by hh1 hh2, sort: gen rank_bednet = _n
			replace tnln = rank_bednet
			drop rank_bednet
			 
			forvalues t = 8 15 to 64 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 6 * (`t'- 1) / 7
			}
			forvalues t = 9 16 to 65 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 6 * (`t'- 2) / 7 - 1
			}
			forvalues t = 10 17 to 66 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 6 * (`t'- 3) / 7 - 2
			}				
			forvalues t = 11 18 to 67 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 6 * (`t'- 4) / 7 - 3
			}
			forvalues t = 12 19 to 68 {
				gen tn15_`t' = tn15_5 if tnln == `t' - 6 * (`t'- 5) / 7 - 4
			}
			forvalues t = 13 20 to 69 {
				gen tn15_`t' = tn15_6 if tnln == `t' - 6 * (`t'- 6) / 7 - 5
			}
			forvalues t = 14 21 to 70 {
				gen tn15_`t' = tn15_7 if tnln == `t' - 6 * (`t'- 7) / 7 - 6
			}

			order tn15_*, sequential
			
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
				replace tn15_5 = . if tnln == `j'
				replace tn15_6 = . if tnln == `j'
				replace tn15_7 = . if tnln == `j'
			}

			collapse (sum) tn15_*, by(hh1 hh2)
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-SierraLeone2017/MICS6-SierraLeone2017ch.dta", keepusing(hh1 hh2 ln cage)
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*
			
			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "SierraLeone2017"
		}
		
	
	// Gambia2018
	
		if inlist(country_name,"Gambia2018") {
			keep if (inrange(tn5,10,18) | (inrange(tn5,21,98) & tn9 < 12))
			by hh1 hh2, sort: gen rank_bednet = _n
			replace tnln = rank_bednet
			drop rank_bednet
	
		    forvalues t = 8 15 to 330 {
			    gen tn15_`t' = tn15_1 if tnln == `t' - 6 * (`t'- 1) / 7
			}
			forvalues t = 9 16 to 331 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 6 * (`t'- 2) / 7 - 1
			}
			forvalues t = 10 17 to 332 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 6 * (`t'- 3) / 7 - 2
			}				
			forvalues t = 11 18 to 333 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 6 * (`t'- 4) / 7 - 3
			}
			forvalues t = 12 19 to 334 {
				gen tn15_`t' = tn15_5 if tnln == `t' - 6 * (`t'- 5) / 7 - 4
			}
			forvalues t = 13 20 to 335 {
				gen tn15_`t' = tn15_6 if tnln == `t' - 6 * (`t'- 6) / 7 - 5
			}
			forvalues t = 14 21 to 336 {
				gen tn15_`t' = tn15_7 if tnln == `t' - 6 * (`t'- 7) / 7 - 6
			}
           
		    order tn15_*, sequential
			
			forval j = 2/48 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
				replace tn15_5 = . if tnln == `j'
				replace tn15_6 = . if tnln == `j'
				replace tn15_7 = . if tnln == `j'
			}
			
			collapse (sum) tn15_*, by(hh1 hh2)
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-Gambia2018/MICS6-Gambia2018ch.dta", keepusing(hh1 hh2 ln cage)
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*
			
			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "Gambia2018"
		}
		
		
	// Madagascar2018
	
		if inlist(country_name,"Madagascar2018") {
			by hh1 hh2, sort: gen rank_bednet = _n
			replace tnln = rank_bednet
			drop rank_bednet
			 
			forvalues t = 9 17 to 73 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 7 * (`t'- 1) /8
			}
			forvalues t = 10 18 to 74 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 7 * (`t'- 2) / 8 - 1
			}
			forvalues t = 11 19 to 75 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 7 * (`t'- 3) / 8 - 2
			}				
			forvalues t = 12 20 to 76 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 7 * (`t'- 4) / 8 - 3
			}
			forvalues t = 13 21 to 77 {
				gen tn15_`t' = tn15_5 if tnln == `t' - 7 * (`t'- 5) / 8 - 4
			}
			forvalues t = 14 22 to 78 {
				gen tn15_`t' = tn15_6 if tnln == `t' - 7 * (`t'- 6) / 8 - 5
			}
			forvalues t = 15 23 to 79 {
				gen tn15_`t' = tn15_7 if tnln == `t' - 7 * (`t'- 7) / 8 - 6
			} 
			forvalues t = 16 24 to 80 {
				gen tn15_`t' = tn15_8 if tnln == `t' - 7 * (`t'- 7) / 8 - 7
			}  
			 

			order tn15_*, sequential
			
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
				replace tn15_5 = . if tnln == `j'
				replace tn15_6 = . if tnln == `j'
				replace tn15_7 = . if tnln == `j'
				replace tn15_8 = . if tnln == `j'
			}

			collapse (sum) tn15_*, by(hh1 hh2)
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-Madagascar2018/MICS6-Madagascar2018ch.dta", keepusing(hh1 hh2 ln cage)
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*
			
			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "Madagascar2018"
		}	
		
		
				
	// Zimbabwe2019
		
		if inlist(country_name,"Zimbabwe2019") {
			
			by hh1 hh2, sort: gen rank_bednet = _n 
			replace tnln = rank_bednet
			drop rank_bednet

			forvalues t = 5 9 to 37 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 3 * (`t'- 1) / 4
			}
			forvalues t = 6 10 to 38 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 3 * (`t'- 2) / 4 - 1
			}
			forvalues t = 7 11 to 39 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 3 * (`t'- 3) / 4 - 2
			}
			forvalues t = 8 12 to 40 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 3 * (`t'- 4) / 4 - 3
			}

			order tn15_*, sequential
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
			} 

			collapse (sum) tn15_*, by(hh1 hh2) // collapse to household level
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-Zimbabwe2019/MICS6-Zimbabwe2019ch.dta", keepusing(hh1 hh2 ln cage)
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*

			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "Zimbabwe2019"
		}
		
// Congodr2017
		
		if inlist(country_name,"Congodr2017") {
			keep if (inrange(tn5,10,18) | (inrange(tn5,21,98) & tn9 < 12))
			by hh1 hh2, sort: gen rank_bednet = _n 
			replace tnln = rank_bednet
			drop rank_bednet

			forvalues t = 5 9 to 37 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 3 * (`t'- 1) / 4
			}
			forvalues t = 6 10 to 38 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 3 * (`t'- 2) / 4 - 1
			}
			forvalues t = 7 11 to 39 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 3 * (`t'- 3) / 4 - 2
			}
			forvalues t = 8 12 to 40 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 3 * (`t'- 4) / 4 - 3
			}

			order tn15_*, sequential
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
			} 

			collapse (sum) tn15_*, by(hh1 hh2) // collapse to household level
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-Congodr2017/MICS6-Congodr2017ch.dta", keepusing(hh1 hh2 ln cage)
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*

			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "Congodr2017"
		}
		
			// Ghana2017
		
	if inlist(country_name,"Ghana2017") {
			keep if (inrange(tn5,10,18) | (inrange(tn5,21,98) & tn9 < 12))
			by hh1 hh2, sort: gen rank_bednet = _n 
			replace tnln = rank_bednet
			drop rank_bednet

			forvalues t = 5 9 to 37 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 3 * (`t'- 1) / 4
			}
			forvalues t = 6 10 to 38 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 3 * (`t'- 2) / 4 - 1
			}
			forvalues t = 7 11 to 39 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 3 * (`t'- 3) / 4 - 2
			}
			forvalues t = 8 12 to 40 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 3 * (`t'- 4) / 4 - 3
			}

			order tn15_*, sequential
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
			} 

			collapse (sum) tn15_*, by(hh1 hh2) // collapse to household level
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-Ghana2017/MICS6-Ghana2017ch.dta", keepusing(hh1 hh2 ln cage)
			
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*

			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "Ghana2017"
		}
		
		
			// Togo2017
		
	if inlist(country_name,"Togo2017") {
			keep if (inrange(tn5,10,18) | (inrange(tn5,21,98) & tn9 < 12))
			by hh1 hh2, sort: gen rank_bednet = _n 
			replace tnln = rank_bednet
			drop rank_bednet

			forvalues t = 5 9 to 37 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 3 * (`t'- 1) / 4
			}
			forvalues t = 6 10 to 38 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 3 * (`t'- 2) / 4 - 1
			}
			forvalues t = 7 11 to 39 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 3 * (`t'- 3) / 4 - 2
			}
			forvalues t = 8 12 to 40 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 3 * (`t'- 4) / 4 - 3
			}

			order tn15_*, sequential
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
			} 

			collapse (sum) tn15_*, by(hh1 hh2) // collapse to household level
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-Togo2017/MICS6-Togo2017ch.dta", keepusing(hh1 hh2 ln cage)
	
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*

			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "Togo2017"
		}
		

		// Kiribati2018
	
		if inlist(country_name,"Kiribati2018") {
			by hh1 hh2, sort: gen rank_bednet = _n 
			replace tnln = rank_bednet
			drop rank_bednet
			 
			forvalues t = 11 21 to 91 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 9 * (`t'- 1) /10
			}
			forvalues t = 12 22 to 92 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 9 * (`t'- 2) / 10 - 1
			}
			forvalues t = 13 23 to 93 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 9 * (`t'- 3) / 10 - 2
			}				
			forvalues t = 14 24 to 94 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 9 * (`t'- 4) / 10 - 3
			}
			forvalues t = 15 25 to 95 {
				gen tn15_`t' = tn15_5 if tnln == `t' - 9 * (`t'- 5) / 10 - 4
			}
			forvalues t = 16 26 to 96 {
				gen tn15_`t' = tn15_6 if tnln == `t' - 9 * (`t'- 6) / 10 - 5
			}
			forvalues t = 17 27 to 97 {
				gen tn15_`t' = tn15_7 if tnln == `t' - 9 * (`t'- 7) / 10 - 6
			} 
			forvalues t = 18 28 to 98 {
				gen tn15_`t' = tn15_8 if tnln == `t' - 9 * (`t'- 8) / 10 - 7
			}  
			forvalues t = 19 29 to 99 {
				gen tn15_`t' = tn15_9 if tnln == `t' - 9 * (`t'- 9) / 10 - 8
			}   
			forvalues t = 20 30 to 100 {
				gen tn15_`t' = tn15_10 if tnln == `t' - 9 * (`t'- 10) / 10 - 9
			}  
			
			order tn15_*, sequential
			
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
				replace tn15_5 = . if tnln == `j'
				replace tn15_6 = . if tnln == `j'
				replace tn15_7 = . if tnln == `j'
				replace tn15_8 = . if tnln == `j'
				replace tn15_9 = . if tnln == `j'
				replace tn15_10 = . if tnln == `j'
			}

			collapse (sum) tn15_*, by(hh1 hh2)
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-Kiribati2018/MICS6-Kiribati2018ch.dta", keepusing(hh1 hh2 ln cage)
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*
			
			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "Kiribati2018"
		}	

    // Chad2019
if inlist(country_name,"Chad2019") {
			by hh1 hh2, sort: gen rank_bednet = _n 
			replace tnln = rank_bednet
			drop rank_bednet

			forvalues t = 5 9 to 37 {
				gen tn15_`t' = tn15_1 if tnln == `t' - 3 * (`t'- 1) / 4
			}
			forvalues t = 6 10 to 38 {
				gen tn15_`t' = tn15_2 if tnln == `t' - 3 * (`t'- 2) / 4 - 1
			}
			forvalues t = 7 11 to 39 {
				gen tn15_`t' = tn15_3 if tnln == `t' - 3 * (`t'- 3) / 4 - 2
			}
			forvalues t = 8 12 to 40 {
				gen tn15_`t' = tn15_4 if tnln == `t' - 3 * (`t'- 4) / 4 - 3
			}

			order tn15_*, sequential
			
			forval j = 2/10 {
				replace tn15_1 = . if tnln == `j'
				replace tn15_2 = . if tnln == `j'
				replace tn15_3 = . if tnln == `j'
				replace tn15_4 = . if tnln == `j'
			} 

			collapse (sum) tn15_*, by(hh1 hh2) // collapse to household level
			sort hh1 hh2
			
			merge 1:m hh1 hh2 using "${SOURCE}/MICS/MICS6-Chad2019/MICS6-Chad2019ch.dta", keepusing(hh1 hh2 ln cage)
	
			tab _merge
			drop if _ == 1
			drop _merge
		
			sort hh1 hh2
			keep hh1 hh2 ln cage tn*

			foreach v of varlist tn15_* {
				replace `v' = `v' - ln
			}
			foreach v of varlist tn15_* {
				replace `v' = . if `v' != 0
			}
			foreach v of varlist tn15_* {
				replace `v' = 1 if `v' == 0
			}

			egen c_ITN = rowtotal(tn15_*)
			replace c_ITN = . if cage == .
			
			gen country_name = "Chad2019"
		}
