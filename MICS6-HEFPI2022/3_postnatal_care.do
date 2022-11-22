/// MICS6-dofiles
// Postnatal care
// Do-file for the indicators:
/*
c_pnc_any
c_pnc_eff
c_pnc_eff_q
c_pnc_eff2
c_pnc_eff2_q

*/


// c_pnc_any : mother OR child receive PNC in first six weeks by skilled health worker
	gen c_pnc_any = .	
	
	if ~inlist(country_name,"Georgia2018","Thailand2019","Turkmenistan2019","Serbia2019"，"TurksCaicosIslands2019") {
		replace c_pnc_any = 0 if bl2 == 1
		* pnc for SBA facility births
		replace c_pnc_any = 1 if c_sba == 1 & (pn4 == 1 | pn5 == 1)     // baby OR mother checked within six weeks of birth and before leaving facility by skilled provider
		* pnc for non-facility SBA births
		replace c_pnc_any = 1 if c_sba == 1 & (pn8 == 1 | pn9 == 1)   // baby OR mother checked within six weeks of birth and before skilled birth attendant left after delivery
		* pnc for SBA facility births, non-facility SBA births, and non-facility non-SBA births
		
		#delimit ;
		if 	country_name == "LaoPDR2017" | 
			country_name == "SierraLeone2017" |
			country_name == "Iraq2017" |
			country_name == "KyrgyzRepublic2018" |
			country_name == "Gambia2018" |
			country_name == "Madagascar2018" |
			country_name == "Ghana2017" |
			country_name == "Kiribati2018" |
			country_name == "Montenegro2018"|
			country_name == "Belarus2019"|
			country_name == "Chad2019"|
			country_name == "Tuvalu2019"|
			country_name == "Nepal2019" |
			country_name == "Honduras2019" {;
	    #delimit cr	
			global pnc "a b c"
		}
		if inlist(country_name,"Mongolia2018") {
			global pnc "d e i j c k"
		}
		if inlist(country_name,"Suriname2018") {
			global pnc "a d e g"
		}

		if inlist(country_name,"Tunisia2018","Lesotho2018","Zimbabwe2019","Guinea-Bissau2018","StateofPalestine2019","Kosovo2019","Cuba2019", "SaoTomeAndPrincipe2019","NorthMacedonia2018") | inlist(country_name,"TurksCaicosIslands2019","Malawi2019","Vietnam2020") {
			global pnc "a b"
		}
		if inlist(country_name,"Bangladesh2019") {
			global pnc "a b c d e"
		}
		if inlist(country_name,"Congodr2017") {
			global pnc "a c d"
		}

		if inlist(country_name,"Togo2017","Tonga2019","Argentina2019","DominicanRepublic2019") {
			global pnc "a b c d"
		}		
		if inlist(country_name,"CostaRica2018") {
			global pnc "a b i"
		}	
		if inlist(country_name,"Algeria2018") {
			global pnc "a b d"
		}
		if inlist(country_name,"CentralAfricanRepublic2018") {
			global pnc "a b c d e f g"
		}		
		if inlist(country_name,"Samoa2019") {
			global pnc "a b f h x"
		}		
		foreach x in $pnc {	
			replace c_pnc_any = 1 if (((pn13u == 3 & pn13n<7) | inrange(pn13u,1,2)) & (~inlist(pn14`x',"","?"))) | (((pn22u == 3 & pn22n<7) | inrange(pn22u,1,2)) & (~inlist(pn23`x',"","?"))) // baby OR mother checked within six weeks of birth (after leaving facility OR after birth attendant left)
			replace c_pnc_any = . if pn14`x' == "?" | pn23`x' == "?" 
		}	
		* only for children with PNC info
		replace c_pnc_any = . if c_sba == . | pn3u == 9 | inrange(pn3n,97,99) | pn4 == 9 | pn5 ==9 | pn8 == 9 | pn9 == 9 | pn13u == 9 | inrange(pn13n,97,99) | pn22u == 9 | inrange(pn22n,97,99)
		* only for children born in last two years to women age 15-49
		replace c_pnc_any = . if bl2 != 1 | ~inrange(wb4,15,49)
	}
	    

// c_pnc_eff: mother AND child in first 24h by skilled health worker
	// assumption: for mother and child stay in health facility and "yes" to health check, assume the checks are done in 24h
	
	gen c_pnc_eff = .
	
	if ~inlist(country_name,"Georgia2018","Thailand2019","Turkmenistan2019","Serbia2019","TurksCaicosIslands2019","Tuvalu2019","Argentina2019") {
		replace c_pnc_eff = 0 if bl2 == 1
		* pnc for SBA facility births
		replace c_pnc_eff = 1 if c_sba == 1 & pn4 == 1 & pn5 == 1  // baby AND mother checked within 24h of birth and before leaving facility by skilled provider
		* pnc for non-facility SBA births
		replace c_pnc_eff = 1 if c_sba == 1 & pn8 == 1 & pn9 == 1   // baby AND mother checked within 24h of birth and before skilled birth attendant left after delivery
		* pnc for SBA facility births, non-facility SBA births, and non-facility non-SBA births

		
	        foreach x in $pnc {	
			    replace c_pnc_eff = 1 if (((pn13u == 2 & pn13n==1) | inrange(pn13u,1,1)) & (~inlist(pn14`x',"","?"))) & (((pn22u == 2 & pn22n==1) | inrange(pn22u,1,1)) & (~inlist(pn23`x',"","?"))) // baby AND mother checked within 24h of birth (after leaving facility OR after birth attendant left)
	            replace c_pnc_eff = . if pn14`x' == "?" | pn23`x' == "?" 
	        }	
		* only for children with PNC info
		replace c_pnc_eff = . if pn3u == 9 | inrange(pn3n,97,99) | pn4 == 9 | pn5 ==9 | pn8 == 9 | pn9 == 9 | pn13u == 9 | inrange(pn13n,97,99) | pn22u == 9 | inrange(pn22n,97,99)	
		* only for children born in last two years to women age 15-49
		replace c_pnc_eff = . if bl2 != 1 | ~inrange(wb4,15,49)
	}


// c_pnc_eff_q: mother AND child in first 24h by skilled health worker among those with any PNC
	gen c_pnc_eff_q = c_pnc_eff
	if ~inlist(country_name,"Georgia2018") {
		replace c_pnc_eff_q = . if c_pnc_any == 0
		replace c_pnc_eff_q = . if c_pnc_any == . | c_pnc_eff == .
	}
	
// c_pnc_eff2: mother AND child in first 24h by skilled health worker and cord check, temperature check and breastfeeding counselling within first two days
	gen c_pnc_eff2 = c_pnc_eff
	if ~inlist(country_name,"Georgia2018","Thailand2019","Turkmenistan2019","Serbia2019","Tuvalu2019","Argentina2019") {
		replace c_pnc_eff2 = 0 if pn25a == 2 | pn25b == 2| pn25c == 2
		replace c_pnc_eff2 = . if c_pnc_eff == . | inrange(pn25a,8,9) | inrange(pn25b,8,9) | inrange(pn25c,8,9)  
	}

// c_pnc_eff2_q: mother AND child in first 24h by skilled health worker and cord check, temperature check and breastfeeding counselling within first two days among those with any PNC
	gen c_pnc_eff2_q = c_pnc_eff2
	if ~inlist(country_name,"Georgia2018") {
		replace c_pnc_eff2_q = . if c_pnc_any == 0
		replace c_pnc_eff2_q = . if c_pnc_any == . | c_pnc_eff2 == .
	}			
