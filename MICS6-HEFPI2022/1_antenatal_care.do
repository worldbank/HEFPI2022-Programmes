******************************
*** Antenatal care *********** 
******************************   

* c_anc: 4+ antenatal care visits of births in last 2 years
		gen c_anc = .
		if ~inlist(country_name,"Georgia2018","Chad2019") {
			replace c_anc = 0 if mn2 != .
			replace c_anc = 1 if mn5 > 3 & mn5 < 98				// 1 for 4+ anc visits
			replace c_anc = . if inlist(mn5,98,99) | mn2 == 9  	// missing for DK and missing
			replace c_anc = . if bl2 != 1 | ~inrange(wb4,15,49)		// missing for births > 24 months ago & mothers < 18
		}



* c_anc_any: any antenatal care visits of births in last 2 years
		gen c_anc_any = .
		if ~inlist(country_name,"Georgia2018","Chad2019") {
			replace c_anc_any = 0 if mn2 != .
			replace c_anc_any = 1 if mn2 == 1				// 1+ anc visits
			replace c_anc_any = . if mn2 == 9  			// missing for DK and missing
			replace c_anc_any = . if bl2 != 1 | ~inrange(wb4,15,49)			// missing for births > 24 months ago
		}

* c_anc_ear: First antenatal care visit in first trimester of pregnancy of births in last 2 years
		gen c_anc_ear = .
		replace c_anc_ear = 0 if mn2 != .
		if inlist(country_name,"LaoPDR2017","Togo2017","Algeria2018") {	
			replace c_anc_ear = 1 if mn4u == 1 & mn4n < 13				// 1st ANC in first trimester of pregnancy (in weeks)
			replace c_anc_ear = 1 if mn4u == 2 & mn4n < 4				// 1st ANC in first trimester of pregnancy (in months)
			replace c_anc_ear = . if inlist(mn4n,98,99)  		// missing for DK and missing
			replace c_anc_ear = . if bl2 != 1 | ~inrange(wb4,15,49)	| mn4u == 9		// missing for births > 24 months ago
		}
		#delimit ;
		if 	country_name == "SierraLeone2017" | 
			country_name == "Iraq2017" |
			country_name == "KyrgyzRepublic2018" |
		    country_name == "Suriname2018" |
			country_name == "Gambia2018" |
			country_name == "Tunisia2018" |
			country_name == "Lesotho2018" |
			country_name == "Madagascar2018" |
			country_name == "Zimbabwe2019" |
			country_name == "Bangladesh2019" |
			country_name == "Congodr2017" |
			country_name == "Ghana2017" |
			country_name == "Kiribati2018" |
			country_name == "Montenegro2018" |
			country_name == "Guinea-Bissau2018" |
			country_name == "CostaRica2018"|
			country_name == "Belarus2019" |
			country_name == "NorthMacedonia2018" |
			country_name == "StateofPalestine2019" |
			country_name == "Serbia2019" |
			country_name == "Nepal2019" | 
			country_name == "Kosovo2019" |
			country_name == "Cuba2019" |
			country_name == "CentralAfricanRepublic2018" | 
			country_name == "SaoTomeAndPrincipe2019" |
			country_name == "Samoa2019" |
			country_name == "Tuvalu2019" |
			country_name == "Argentina2019" |
			country_name == "TurksCaicosIslands2019" |
			country_name == "Vietnam2020" |
			country_name == "Tonga2019" |
			country_name == "Honduras2019" |
			country_name == "DominicanRepublic2019" |
			country_name == "Malawi2019" {;
	    #delimit cr 			
			replace c_anc_ear = 1 if mn4au == 1 & mn4an < 13				// 1st ANC in first trimester of pregnancy (in weeks)
			replace c_anc_ear = 1 if mn4au == 2 & mn4an < 4				// 1st ANC in first trimester of pregnancy (in months)
			replace c_anc_ear = . if inlist(mn4an,98,99)  		// missing for DK and missing
			replace c_anc_ear = . if bl2 != 1 | ~inrange(wb4,15,49)	| mn4au == 9		// missing for births > 24 months ago
		}
		if inlist(country_name,"Mongolia2018") {	
			replace c_anc_ear = 1 if mn4 < 13				// 1st ANC in first trimester of pregnancy (in weeks)
			replace c_anc_ear = . if inlist(mn4,98,99)  		// missing for DK and missing
			replace c_anc_ear = . if bl2 != 1 | ~inrange(wb4,15,49)	          	// missing for births > 24 months ago
		}
		if inlist(country_name,"Chad2019") {	
			replace c_anc_ear = . 
		}		
		
* c_anc_ear_q: First antenatal care visit in first trimester of pregnancy among ANC users of births in last 2 years
		gen c_anc_ear_q = .
		replace c_anc_ear_q = 0 if c_anc_any == 1						// among ANC users
		replace c_anc_ear_q = 1 if c_anc_ear_q == 0  & c_anc_ear == 1
		replace c_anc_ear_q = . if c_anc_any == . | c_anc_ear == .
		if inlist(country_name,"Chad2019") {	
			replace c_anc_ear_q = . 
		}			
	
		
* c_anc_eff: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples) of births in last 2 years
		// always look up definition for skilled provider for different countries in the report
		gen c_anc_eff = . 
		if ~inlist(country_name,"Georgia2018","Chad2019") {
			replace c_anc_eff = 0 if mn2 != .
		#delimit ;
		if 	country_name == "LaoPDR2017" | 
			country_name == "SierraLeone2017" |
			country_name == "Iraq2017" |
			country_name == "KyrgyzRepublic2018" |
		    country_name == "Gambia2018" |
			country_name == "Madagascar2018" |
			country_name == "Ghana2017" |
			country_name == "Kiribati2018" |
			country_name == "Montenegro2018" |
			country_name == "Thailand2019" |
			country_name == "Belarus2019"|
			country_name == "Turkmenistan2019" |
			country_name == "Serbia2019" |
			country_name == "Tuvalu2019" |
			country_name == "Nepal2019" |
			country_name == "Honduras2019" {;

	    #delimit cr		
				global mn3 "mn3a mn3b mn3c"
			}
			if inlist(country_name,"Mongolia2018") {		
				global mn3 "mn3d mn3e mn3i mn3j mn3c mn3k"
			}
			if inlist(country_name,"Suriname2018") {	
				global mn3 "mn3a mn3d mn3e mn3g"
			}

			//Antenatal care does not involve agente de saude comunitaria, unlike post natal care

			//SaoTomeAndPrincipe2019: survey report only listed Medico / enfermeira / parteira. Parteira tradicional / agente de sante communautaira have no observations in respective variables.s
			if inlist(country_name,"Tunisia2018","Lesotho2018","Zimbabwe2019","Guinea-Bissau2018","StateofPalestine2019","Kosovo2019","Cuba2019","NorthMacedonia2018","SaoTomeAndPrincipe2019") | inlist(country_name,"Samoa2019","TurksCaicosIslands2019","Vietnam2020","Malawi2019") {
				global mn3 "mn3a mn3b"
			}
			if inlist(country_name,"Bangladesh2019") {	
				global mn3 "mn3a mn3b mn3c mn3d mn3e"
			}
			if inlist(country_name,"Congodr2017") {	
				global mn3 "mn3a mn3c mn3d"
			}
			if inlist(country_name,"Togo2017","CentralAfricanRepublic2018","Argentina2019","DominicanRepublic2019") {	
				global mn3 "mn3a mn3b mn3c mn3d"
			}
			if inlist(country_name,"CostaRica2018") {	
				global mn3 "mn3a mn3b mn3i"
			}
			if inlist(country_name,"Tonga2019","Algeria2018"){
				global mn3 "mn3a mn3b mn3d"
			}

			foreach var in $mn3 {
				replace `var' = "" if `var' == " "
				replace c_anc_eff = 1 if mn5 > 3 & mn5 < 98 & `var' != "" & `var' != "?" & mn6a == 1 & mn6b == 1 & mn6c == 1		// 1 for 4+ anc visits, doctor/nurse/midwife incl. auxiliary, blood pressure, blood and urine samples
				replace c_anc_eff = . if `var' == "?" // missing for DK/missing if no other skilled provider used
			}			
			replace c_anc_eff = . if mn6a == 9 | mn6b == 9 | mn6c == 9
			replace c_anc_eff = . if inlist(mn5,98,99)  	// missing for DK and missing
			replace c_anc_eff = . if bl2 != 1 | ~inrange(wb4,15,49)			// missing for births > 24 months ago		
		}
		

* c_anc_eff_q: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples) among ANC users of births in last 2 years
		gen c_anc_eff_q = .

		replace c_anc_eff_q = 0 if c_anc_any == 1						// among ANC users
		replace c_anc_eff_q = 1 if c_anc_eff_q == 0  & c_anc_eff == 1
		replace c_anc_eff_q = . if c_anc_any == . | c_anc_eff == .
		if inlist(country_name,"Chad2019") {	
			replace c_anc_eff_q = . 
		}			
		

* c_anc_ski: antenatal care visit with skilled provider for pregnancy of births in last 2 years
		gen c_anc_ski = . 
		if ~inlist(country_name,"Georgia2018","Chad2019") {
			replace c_anc_ski = 0 if mn2 != .
		
			foreach var in $mn3 {
				replace c_anc_ski = 1 if `var' != "" & `var' != "?"		// 1 for Obstetricion, Physician, Family/soum doctor, Midwife, Auxiliary midwife and Nurse
				replace c_anc_ski = . if `var' == "?"  // missing for DK/missing if no other skilled provider used
			}	
			replace c_anc_ski = . if bl2 != 1 | ~inrange(wb4,15,49)			// missing for births > 24 months ago
		}	
	
		
* c_anc_ski_q: antenatal care visit with skilled provider among ANC users for pregnancy of births in last 2 years
		gen c_anc_ski_q = .

		replace c_anc_ski_q = 0 if c_anc_any == 1						// among ANC users
		replace c_anc_ski_q = 1 if c_anc_ski_q == 0  & c_anc_ski == 1
		replace c_anc_ski_q = . if c_anc_any == . | c_anc_ski == .

		if inlist(country_name,"Chad2019") {	
			replace c_anc_ski_q = . 
		}			
		
* c_anc_bp: Blood pressure measured during pregnancy of births in last 2 years
		gen c_anc_bp = .
		if ~inlist(country_name,"Georgia2018","Chad2019") {
			replace c_anc_bp = 0 if mn2 != .
			replace c_anc_bp = 1 if mn6a == 1		// 1 for blood pressure
			replace c_anc_bp = . if mn6a == 9	// missing for DK/missing
			replace c_anc_bp = . if bl2 != 1 | ~inrange(wb4,15,49)			// missing for births > 24 months ago
		}
		
* c_anc_bp_q: Blood pressure measured during pregnancy among ANC users of births in last 2 years
		gen c_anc_bp_q = .

		replace c_anc_bp_q = 0 if c_anc_any == 1						// among ANC users
		replace c_anc_bp_q = 1 if c_anc_bp_q == 0  & c_anc_bp == 1
		replace c_anc_bp_q = . if c_anc_any == . | c_anc_bp == .
		
		if inlist(country_name,"Chad2019") {	
			replace c_anc_bp_q = . 
		}		
		
* c_anc_bs: Blood sample taken during pregnancy of births in last 2 years
		gen c_anc_bs = .
		if ~inlist(country_name,"Georgia2018","Chad2019") {
			replace c_anc_bs = 0 if mn2 != .
			replace c_anc_bs = 1 if mn6c == 1		// 1 for blood sample
			replace c_anc_bs = . if mn6c == 9	// missing for DK/missing
			replace c_anc_bs = . if bl2 != 1 | ~inrange(wb4,15,49)			// missing for births > 24 months ago
		}	
		
* c_anc_bs_q: Blood sample taken during pregnancy among ANC users of births in last 2 years
		gen c_anc_bs_q = .

		replace c_anc_bs_q = 0 if c_anc_any == 1						// among ANC users
		replace c_anc_bs_q = 1 if c_anc_bs_q == 0  & c_anc_bs == 1
		replace c_anc_bs_q = . if c_anc_any == . | c_anc_bs == .
		if inlist(country_name,"Chad2019") {	
			replace c_anc_bs_q = . 
		}				
		
		
* c_anc_ur: Urine sample taken during pregnancy of births in last 2 years
		gen c_anc_ur = .
		if ~inlist(country_name,"Georgia2018","Chad2019") {
			replace c_anc_ur = 0 if mn2 != .
			replace c_anc_ur = 1 if mn6b == 1		// 1 for urine sample taken
			replace c_anc_ur = . if mn6b == 9	// missing for DK/missing
			replace c_anc_ur = . if bl2 != 1 | ~inrange(wb4,15,49)			// missing for births > 24 months ago
		}
		
* c_anc_ur_q: Urine sample taken during pregnancy among ANC users of births in last 2 years
		gen c_anc_ur_q = .

		replace c_anc_ur_q = 0 if c_anc_any == 1						// among ANC users
		replace c_anc_ur_q = 1 if c_anc_ur_q == 0  & c_anc_ur == 1
		replace c_anc_ur_q = . if c_anc_any == . | c_anc_ur == .
		if inlist(country_name,"Chad2019") {	
			replace c_anc_ur_q = . 
		}			
* c_anc_ir: iron supplements taken during pregnancy of births in last 2 years
		gen c_anc_ir = .
		if inlist(country_name,"LaoPDR2017") {	
			replace c_anc_ir = 0 if mn2 != .
			replace c_anc_ir = 1 if mn14c == 1
			replace c_anc_ir = . if inlist(mn14c,8,9)   	// missing for DK and missing3
			replace c_anc_ir = . if bl2 != 1 | ~inrange(wb4,15,49)			// missing for births > 24 months age
		}
		if inlist(country_name,"Mongolia2018") {
			replace c_anc_ir = 0 if mn2 != .
			replace c_anc_ir = 1 if mn6aa == 1
			replace c_anc_ir = . if inlist(mn6aa,8,9)
	    }
		if inlist(country_name,"Kiribati2018") {
			replace c_anc_ir = 0 if mn2 != .
			replace c_anc_ir = 1 if mn7a == 1
			replace c_anc_ir = . if inlist(mn7a,8,9)
	    }
		if inlist(country_name,"Cuba2019") {
			replace c_anc_ir = 0 if mn2 != .
			replace c_anc_ir = 1 if mn6ba == 1
			replace c_anc_ir = . if inlist(mn6ba,8,9)
	    }
			replace c_anc_ir = . if bl2 != 1 | ~inrange(wb4,15,49)			// missing for births > 24 months age		
		
* c_anc_ir_q: iron supplements taken during pregnancy among ANC users of births in last 2 years
		gen c_anc_ir_q = .

		if inlist(country_name,"LaoPDR2017","Mongolia2018","Kiribati2018","Cuba2019") {
			replace c_anc_ir_q = 0 if c_anc_any == 1						// among ANC users
			replace c_anc_ir_q = 1 if c_anc_ir_q == 0  & c_anc_ir == 1
			replace c_anc_ir_q = . if c_anc_any == . | c_anc_ir == .
		}		
		
		
		
* c_anc_tet: pregnant women vaccinated against tetanus during pregnancy of births in last 2 years
		gen c_anc_tet = .

		if !(inlist(country_name,"KyrgyzRepublic2018","Mongolia2018","Tunisia2018","Georgia2018","Montenegro2018","Belarus2019","Turkmenistan2019","StateofPalestine2019","Serbia2019") | inlist(country_name,"Kosovo2019","NorthMacedonia2018","Cuba2019","Tonga2019","Samoa2019","TurksCaicosIslands2019","Tuvalu2019","Argentina2019","Honduras2019")) {
		     replace c_anc_tet = 0 if mn7 != .				// immunization question
		     
			 replace c_anc_tet = 1 if c_anc_tet == 0 & inlist(mn8,2,8) & inrange(mn12,5,7)		// No/DK injections during pregrancy for last child but 5+ before (woman is then protected for the childbearing years period)
		     replace c_anc_tet = 1 if c_anc_tet == 0 & inrange(mn9,2,7)   	// Yes injections during pregrancy for last child and 2+ injections
		     replace c_anc_tet = 1 if c_anc_tet == 0 & mn9 == 1 & inrange(mn12,1,7)   	// Yes injections during pregrancy for last child, only one but at least one before
		     replace c_anc_tet = . if bl2 != 1 | ~inrange(wb4,15,49)			// missing for births > 24 months age
        }               
		if inlist(country_name,"Tunisia2018","Algeria2018","Cuba2019","Tonga2019") {
		     replace c_anc_tet = 0 if inrange(mn8,1,8)				// immunization question
		     
			 replace c_anc_tet = 1 if c_anc_tet == 0 & inlist(mn8,2,8) & inrange(mn12,5,7)		// No/DK injections during pregrancy for last child but 5+ before (woman is then protected for the childbearing years period)
		     replace c_anc_tet = 1 if c_anc_tet == 0 & inrange(mn9,2,7)   	// Yes injections during pregrancy for last child and 2+ injections
		     replace c_anc_tet = 1 if c_anc_tet == 0 & mn9 == 1 & inrange(mn12,1,7)   	// Yes injections during pregrancy for last child, only one but at least one before
		     replace c_anc_tet = . if bl2 != 1 | ~inrange(wb4,15,49)			// missing for births > 24 months age
        }
		
		if inlist(country_name,"Chad2019") {	
			replace c_anc_tet = . 
		}		
		
// no tetanus vaccination data for "KyrgyzRepublic2018", "Mongolia2018" , "Belarus2019" , "StateofPalestine2019", "Serbia2019","Kosovo2019","NorthMacedonia2018"
// Following definition from WHO: https://extranet.who.int/rhl/topics/preconception-pregnancy-childbirth-and-postpartum-care/antenatal-care/who-recommendation-tetanus-toxoid-vaccination-pregnant-women
// Different than TM.7 from MICS

* c_anc_tet_q: pregnant women vaccinated against tetanus during pregnancy among ANC users of births in last 2 years
		gen c_anc_tet_q = .
		
		if ~inlist(country_name,"KyrgyzRepublic2018","Mongolia2018","Georgia2018","Montenegro2018","Belarus2019","StateofPalestine2019","Serbia2019","Kosovo2019","Chad2019") {

			replace c_anc_tet_q = 0 if c_anc_any == 1						// among ANC users
			replace c_anc_tet_q = 1 if c_anc_tet_q == 0  & c_anc_tet == 1
			replace c_anc_tet_q = . if c_anc_any == . | c_anc_tet == .		
		}

* c_anc_eff2: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination) of births in last 2 years
		gen c_anc_eff2 = .
		if ~inlist(country_name,"KyrgyzRepublic2018","Mongolia2018","Georgia2018","Montenegro2018","Belarus2019","Serbia2019","Kosovo2019","Chad2019") {
		     replace c_anc_eff2 = c_anc_eff
		     replace c_anc_eff2 = 0 if c_anc_tet == 0
		     replace c_anc_eff2 = . if c_anc_tet == . | c_anc_eff == .
		}
		
* c_anc_eff2_q: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination) among ANC users of births in last 2 years
		gen c_anc_eff2_q = .
		if ~inlist(country_name,"KyrgyzRepublic2018","Mongolia2018","Georgia2018","Montenegro2018","Belarus2019","Serbia2019","Kosovo2019","Chad2019") {
		     replace c_anc_eff2_q = c_anc_eff2
		     replace c_anc_eff2_q = . if c_anc_any == 0
		}
* c_anc_eff3: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination, start in first trimester) of births in last 2 years 
		gen c_anc_eff3 = .
		if ~inlist(country_name,"KyrgyzRepublic2018","Mongolia2018","Georgia2018","Montenegro2018","Belarus2019","Serbia2019","Kosovo2019","Chad2019") {
		     replace c_anc_eff3 = c_anc_eff2
		     replace c_anc_eff3 = 0 if c_anc_ear == 0
		     replace c_anc_eff3 = . if c_anc_ear == . | c_anc_eff2 == .
        }
* c_anc_eff3_q: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination, start in first trimester) among ANC users of births in last 2 years
		gen c_anc_eff3_q = .
		if ~inlist(country_name,"KyrgyzRepublic2018","Mongolia2018","Georgia2018","Montenegro2018","Belarus2019","Serbia2019","Kosovo2019","Chad2019") {
		     replace c_anc_eff3_q = c_anc_eff3
		     replace c_anc_eff3_q = . if c_anc_any == 0
        }

	* DW-RW 2021Oct Based on consultations with Sven, remove certain problematic indicators
	if inlist(country_name,"SaoTomeAndPrincipe2019") {
		replace c_anc = .
	}	
