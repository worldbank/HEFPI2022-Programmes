///MICS6-dofiles
// Delivery care
// Do-file for the indicators:
/*
c_hospdel
c_facdel
c_earlybreast
c_skin2skin
c_sba
c_sba_q
c_caesarean
c_sba_eff1
c_sba_eff1_q
c_sba_eff2
c_sba_eff2_q
*/

* c_hospdel: Child born in hospital of births in last 2 years
		gen c_hospdel = .
		
		#delimit ;
		if 	country_name == "LaoPDR2017" | 
			country_name == "SierraLeone2017" |
			country_name == "Iraq2017" |
			country_name == "KyrgyzRepublic2018" |
		    country_name == "Suriname2018" |
			country_name == "Gambia2018" |
			country_name == "Tunisia2018" |
			country_name == "Madagascar2018" |
			country_name == "Bangladesh2019" |
			country_name == "Congodr2017" |
			country_name == "Ghana2017" |
			country_name == "Togo2017" |
			country_name == "Kiribati2018" |
			country_name == "Montenegro2018" |
			country_name == "CostaRica2018" |
			country_name == "Guinea-Bissau2018" |
			country_name == "Belarus2019"|
			country_name == "Chad2019"|
			country_name == "NorthMacedonia2018"|
			country_name == "TurksCaicosIslands2019"|
			country_name == "Nepal2019"|
			country_name == "Tuvalu2019"|
			country_name == "Argentina2019"|
			country_name == "CentralAfricanRepublic2018"{;
	    #delimit cr		
			replace c_hospdel = 0 if mn20 != .
			replace c_hospdel = 1 if inlist(mn20,21,31)		// 1 for private/public hospital
		}
		if inlist(country_name, "Mongolia2018") {
			replace c_hospdel = 0 if mn20 != .
			replace c_hospdel = 1 if inrange(mn20,21,23) | inlist(mn20,31,32)		// 1 for private/public hospital
		}	
		if inlist(country_name, "Lesotho2018","Zimbabwe2019") {
			replace c_hospdel = 0 if mn20 != .
			replace c_hospdel = 1 if inlist(mn20,21,31,41)		// 1 for private/public hospital
		}			
		if inlist(country_name, "Georgia2018") {
			replace c_hospdel = 0 if mn20 != .
			replace c_hospdel = 1 if mn20 == 41		// 1 for private/public hospital
		}
		if inlist(country_name,"Tonga2019","Algeria2018","Kosovo2019","Cuba2019","SaoTomeAndPrincipe2019","Saomoa2019") {
			replace c_hospdel = 0 if mn20 != .
			replace c_hospdel = 1 if mn20 == 21 	// 1 for public hospital
		}
		if inlist(country_name, "StateofPalestine2019") {
			replace c_hospdel = 0 if mn20 != .
			replace c_hospdel = 1 if inlist(mn20,21,31,41,51,61) 		// 1 for private/public hospital
		}
		if inlist(country_name,"Serbia2019") {
			replace c_hospdel = 0 if mn20 != .
			replace c_hospdel = 1 if inlist(mn20,21,23) // 1 for public hospital
		}	
		if inlist(country_name,"Vietnam2020") {
			replace c_hospdel = 0 if mn20 != .
      replace c_hospdel = 1 if inlist(mn20,21,24,31) // 1 for private/public hospital
		}	
		if inlist(country_name,"Honduras2019") {
			replace c_hospdel = 0 if mn20 != .
			replace c_hospdel = 1 if inlist(mn20,21,22,31) // 1 for public hospital
		}	
		if inlist(country_name,"DominicanRepublic2019") {
			replace c_hospdel = 0 if mn20 != .
			replace c_hospdel = 1 if inlist(mn20,21,22) // 1 for public hospital
		}	
		if inlist(country_name,"Malawi2019") {
			replace c_hospdel = 0 if mn20 != .
			replace c_hospdel = 1 if inlist(mn20,21,31,41) // 1 for public hospital
		}	
		
		replace c_hospdel = . if bl2 != 1 | ~inrange(wb4,15,49)						// missing for births > 24 months ago
		

* c_facdel: Child born in formal health facility of births in last 2 years
		gen c_facdel = . 
		
		#delimit ;
		if 	country_name == "LaoPDR2017" | 
			country_name == "SierraLeone2017" |
			country_name == "Iraq2017" |
			country_name == "KyrgyzRepublic2018" |
		    country_name == "Suriname2018" |
			country_name == "Gambia2018" |
			country_name == "Tunisia2018" |
			country_name == "Madagascar2018" |
			country_name == "Ghana2017" |
			country_name == "Kiribati2018" |
			country_name == "Montenegro2018" |
			country_name == "Thailand2019"|
			country_name == "Belarus2019" |
			country_name == "Chad2019" |
			country_name == "Tonga2019" |
			country_name == "Serbia2019"|
			country_name == "Nepal2019"|
			country_name == "CentralAfricanRepublic2018"{;
	    #delimit cr		
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,23)		// 1 for public health facility
			replace c_facdel = 1 if inrange(mn20,31,33)		// 1 for private health facility
		}
		if inlist(country_name,"Mongolia2018") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,24)		// 1 for public health facility
			replace c_facdel = 1 if inlist(mn20,31,32)	    // 1 for private health facility
		}	
		if inlist(country_name,"Lesotho2018","Zimbabwe2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,23)	| inrange(mn20,41,43)	// 1 for public health facility
			replace c_facdel = 1 if inrange(mn20,31,33)	    // 1 for private health facility
		}	
		if inlist(country_name,"Georgia2018") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,41,43)		// 1 for public health facility
		}	
		if inlist(country_name,"Bangladesh2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,23)		// 1 for public health facility
			replace c_facdel = 1 if inrange(mn20,31,34)	    // 1 for private health facility
		}	
		if inlist(country_name,"Congodr2017") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,23)		// 1 for public health facility
			replace c_facdel = 1 if inrange(mn20,31,36)	    // 1 for private health facility
		}	
		if inlist(country_name,"Togo2017") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,24)		// 1 for public health facility
			replace c_facdel = 1 if inrange(mn20,31,35)	    // 1 for private health facility
		}	
		if inlist(country_name,"CostaRica2018","Kosovo2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,26)		// 1 for public health facility
			replace c_facdel = 1 if inrange(mn20,31,32)	    // 1 for private health facility
		}
		if inlist(country_name,"TurksCaicosIslands2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,26)		// 1 for public health facility
			replace c_facdel = 1 if mn20 == 31	    // 1 for private health facility
		}
		if inlist(country_name,"Turkmenistan2019") {
		    replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,23)		// 1 for public health facility
		}
		if inlist(country_name,"StateofPalestine2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,22)		// 1 for public health facility
			replace c_facdel = 1 if inrange(mn20,31,61)	    // 1 for private health facility
		}
		if inlist(country_name,"Tuvalu2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,22)		// 1 for public health facility
			replace c_facdel = 1 if inrange(mn20,31,36)	    // 1 for private health facility
		}
		if inlist(country_name, "Guinea-Bissau2018") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inlist(mn20,21,22) | inlist(mn20,31,32,33)		// 1 for hospital/maternidade do governo, clinica/centro de saude do governo, and for hospital privado, cliinica privada, e maternidade privada
		}			
		if inlist(country_name, "Algeria2018") {
			replace c_facdel = 0 if mn20 != .
			*replace c_facdel = 1 if inlist(mn20,21,32)		// 1 for  hopital / Clinique privee
			replace c_facdel = 1 if inrange(mn20,20,36)		// 1 for  CHU/hopital/Polyclinique Maternite/Salle de soin maternite/autre public/ Clinique privee / maternite privee/autre CORRECTION1013RW
		}	
		if inlist(country_name, "Cuba2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,23)		// 1 for  hopital /  POLICLÍNICO / CONSULTORIO DEL MÉDICO Y ENFERMERA DE LA FAMILIA
		}					

		if inlist(country_name, "SaoTomeAndPrincipe2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,26)		// 1 for unidade de saude do sector publico: hospital, centro de saude, posto de saude, also 26 for Outro publico
		}		

		if inlist(country_name,"NorthMacedonia2018") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inlist(mn20,21,22,31,32,33)
		}
		if inlist(country_name,"Samoa2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inlist(mn20,21,22,41)
		}
		if inlist(country_name,"Vietnam2020") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,24)		// 1 for public health facility
			replace c_facdel = 1 if inlist(mn20,31,36)	    // 1 for private health facility
		}	
		if inlist(country_name,"Argentina2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,22)		// 1 for public health facility
			replace c_facdel = 1 if inrange(mn20,31,33)	    // 1 for private health facility
		}
		if inlist(country_name,"Honduras2019","DominicanRepublic2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,26)		// 1 for public health facility
			replace c_facdel = 1 if inrange(mn20,31,36)	    // 1 for private health facility
		}
		if inlist(country_name,"Malawi2019") {
			replace c_facdel = 0 if mn20 != .
			replace c_facdel = 1 if inrange(mn20,21,26)		// 1 for public health facility
			replace c_facdel = 1 if inrange(mn20,31,36)	    // 1 for private health facility
			replace c_facdel = 1 if inrange(mn20,41,42)	    // 1 for CHAM/MISSION facility
		}		
		replace c_facdel = . if bl2 != 1 | ~inrange(wb4,15,49)						// missing for births > 24 months ago
// Not taking into account "Others"
    

* c_earlybreast: child breastfed within 1 hours of birth in last 2 years
		gen c_earlybreast = .
		replace c_earlybreast = 0 if mn36 != .
		replace c_earlybreast = 1 if mn37u == 1 & mn37n == 0 	// < 1 hour (strictly)
		replace c_earlybreast = 1 if mn37u == 0							// immediately
		replace c_earlybreast = . if mn37u == 9 | inlist(mn37n,98,99,998)
		replace c_earlybreast = . if bl2 != 1 | ~inrange(wb4,15,49)						// missing for births > 24 months ago

		

* c_skin2skin: child placed on mother's bare skin immediately after birth of births in last 2 years
		gen c_skin2skin = .
		replace c_skin2skin = 0 if bl2 == 1
		replace c_skin2skin = 1 if mn23 == 1 & mn24 == 2		// on mother's bare skin but non-wrapped up
		replace c_skin2skin = . if inlist(mn23,8,9) | inlist(mn24,8,9)
		replace c_skin2skin = . if bl2 != 1 | ~inrange(wb4,15,49)						// missing for births > 24 months ago		

		
* c_sba: Skilled birth attendance of births in last 2 years: go to report to verify how "skilled is defined"
		gen c_sba = . 
		if ~inlist(country_name,"Georgia2018") {
			replace c_sba = 0 if mn20 != .
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
			country_name == "Turkmenistan2019" |
			country_name == "Belarus2019"|
			country_name == "Chad2019" |
			country_name == "Serbia2019"|
			country_name == "Nepal2019" |
			country_name == "Tuvalu2019" |
			country_name == "Turkmenistan2019" |
			country_name == "Honduras2019" {;
	    #delimit cr	
				global mn19 "mn19a mn19b mn19c"
			}
			if inlist(country_name,"Mongolia2018") {
				global mn19 "mn19d mn19e mn19i mn19j mn19c mn19k"
			}
			if inlist(country_name,"Suriname2018") {
				global mn19 "mn19a mn19d mn19e mn19g"
			}
      
			if inlist(country_name,"Tunisia2018","Lesotho2018","Zimbabwe2019","Guinea-Bissau2018","StateofPalestine2019","Kosovo2019","NorthMacedonia2018","Cuba2019","SaoTomeAndPrincipe2019")|inlist(country_name,"Samoa2019","TurksCaicosIslands2019","Malawi2019","Vietnam2020"){
				global mn19 "mn19a mn19b"
			}
			if inlist(country_name,"Bangladesh2019") {	
				global mn19 "mn19a mn19b mn19c mn19d mn19e"
			}
			if inlist(country_name,"Congodr2017") {	
				global mn19 "mn19a mn19c mn19d"
			}
			if inlist(country_name,"Togo2017","Tonga2019","CentralAfricanRepublic2018","Argentina2019","DominicanRepublic2019") {	
				global mn19 "mn19a mn19b mn19c mn19d"
			}
			if inlist(country_name,"CostaRica2018") {	
				global mn19 "mn19a mn19b mn19i"
			} 
			if inlist(country_name,"Algeria2018") {	
				global mn19 "mn19a mn19b mn19d"
			} 


			foreach var in $mn19 {
				replace `var' = "" if `var' == " "
				replace c_sba = 1 if c_sba == 0 & `var' != "" & `var' != "?"	// 1 for Govt. and private doctor/nurse/midwife incl. auxiliary
				replace c_sba = . if `var' == "?"                  // missing for DK/missing if no other skilled provider used
			}		
			replace c_sba = . if bl2 != 1 | ~inrange(wb4,15,49)						// missing for births > 24 months ago
		}

		
* c_sba_q: child placed on mother's bare skin and breastfeeding initiated immediately after birth among children with sba of births in last 2 years
		gen c_sba_q = .
	
		if ~inlist(country_name,"Georgia2018") {
			replace c_sba_q = 0 if c_sba == 1
			replace c_sba_q = 1 if c_sba_q == 0 & c_skin2skin == 1 & c_earlybreast == 1
			replace c_sba_q = . if c_skin2skin == .
			replace c_sba_q = . if c_earlybreast == .
			replace c_sba_q = . if c_sba != 1
			replace c_sba_q = . if bl2 != 1 | ~inrange(wb4,15,49)						// missing for births > 24 months ago
		}
* c_caesarean: Caesarean used for last birth in last 2 years
		gen c_caesarean = .
		replace c_caesarean = 0 if mn20 != . 
		replace c_caesarean = 1 if mn21 == 1
		replace c_caesarean = . if inlist(mn21,8,9)
		replace c_caesarean = . if bl2 != 1 | ~inrange(wb4,15,49)

* Helper: stayed in facility for 24 hours after birth
		gen onedayfac = .

		if ~inlist(country_name,"Georgia2018","Thailand2019","Turkmenistan2019","Guinea-Bissau2018","Algeria2018","Tonga2019","NorthMacedonia2018","Serbia2019","TurksCaicosIslands2019") {
			replace onedayfac = 0 if bl2 == 1
			replace onedayfac = 1 if pn3u == 1 & inrange(pn3n,24,90)
			replace onedayfac = 1 if pn3u == 2 & inrange(pn3n,1,7)
			replace onedayfac = 1 if pn3u == 3 & inrange(pn3n,1,52)
			replace onedayfac = . if bl2 != 1 | ~inrange(wb4,15,49)
		}
		// pn3u shows unit as Semanas/weeks, but actual numbers seem to be in days, 0-22.
		if inlist(country_name,"Guinea-Bissau2018") {
			replace onedayfac = 0 if bl2 == 1
			replace onedayfac = 1 if pn3u == 1 & inrange(pn3n,1,7)
			replace onedayfac = . if bl2 != 1 | ~inrange(wb4,15,49)
		}		
		
		
* c_sba_eff1: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth)
		gen c_sba_eff1 = .
		if ~inlist(country_name,"Georgia2018") {
			replace c_sba_eff1 = 0 if bl2 == 1
			replace c_sba_eff1 = 1 if c_sba == 1 & c_facdel == 1 & c_earlybreast == 1 & onedayfac == 1
			replace c_sba_eff1 = . if c_sba == . | c_facdel == . | c_earlybreast == . | onedayfac == .
			replace c_sba_eff1 = . if bl2 != 1 | ~inrange(wb4,15,49)
		}
		
		
* c_sba_eff1_q: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth) among those with any SBA
		gen c_sba_eff1_q = c_sba_eff1
		if ~inlist(country_name,"Georgia2018") {
			replace c_sba_eff1_q = . if c_sba == 0 | c_sba == .
			replace c_sba_eff1_q = . if bl2 != 1 | ~inrange(wb4,15,49)
		}
		
* c_sba_eff2: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth, skin2skin contact)
		gen c_sba_eff2 = .
		if ~inlist(country_name,"Georgia2018") {
			replace c_sba_eff2 = 0 if bl2 == 1
			replace c_sba_eff2 = 1 if c_sba == 1 & c_facdel == 1 & c_earlybreast == 1 & onedayfac == 1 & c_skin2skin == 1
			replace c_sba_eff2 = . if c_sba == . | c_facdel == . | c_earlybreast == . | onedayfac == . | c_skin2skin == .
			replace c_sba_eff2 = . if bl2 != 1 | ~inrange(wb4,15,49)
		}
		
* c_sba_eff2_q: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth, skin2skin contact) among those with any SBA
		gen c_sba_eff2_q = c_sba_eff2
		if ~inlist(country_name,"Georgia2018") {
			replace c_sba_eff2_q = . if c_sba == 0 | c_sba == .
			replace c_sba_eff2_q = . if bl2 != 1 | ~inrange(wb4,15,49)
		}

drop onedayfac
