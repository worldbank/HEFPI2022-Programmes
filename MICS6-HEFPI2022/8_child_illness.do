///// Batch MICS6-dofiles
// Childhood illness
// Do-file for the indicators:
/*
c_diarrhea
c_ari
c_illness
c_treatdiarrhea
c_diarrhea_hmf
c_diarrhea_med
c_diarrhea_medfor
c_diarrhea_pro
c_diarrheaact
c_diarrheaact_q
c_diarrhea_mof
c_sevdiarrhea
c_sevdiarrheatreat
c_sevdiarrheatreat_q
c_treatARI
c_illtreat
*/


	if ~inlist(country_name,"Montenegro2018","Thailand2019","Turkmenistan2019","Serbia2019","Kosovo2019","NorthMacedonia2018") {	

* c_diarrhea: Child under 5 with diarrhea
		gen c_diarrhea = .
		
		replace c_diarrhea = 1 if ca1 == 1
		replace c_diarrhea = 0 if ca1 == 2
		replace c_diarrhea = . if cage == . | inlist(ca1,8,9)
		

* c_ari: Child under 5 with symptoms of acute respiratory infection (ARI)
		gen c_ari = .
		
		replace c_ari = 1 if ca16 == 1 & ca17 == 1 & inlist(ca18,1,3)		// children with cough and rapid breathing originating from chest
		replace c_ari = 0 if ca16 == 2 | ca17 == 2 | inlist(ca18,2,6)
		replace c_ari = . if cage == . | inlist(ca16,8,9) | inlist(ca17,8,9) | inlist(ca18,8,9) 

* c_illness: Child with any illness symptoms (fever/ARI/diarrhea)
		gen c_illness = .
		
		replace c_illness = 1 if ca1 == 1 | ca14 == 1 | c_ari == 1
		replace c_illness = 0 if ca1 == 2 & ca14 == 2 & c_ari == 0
		replace c_illness = . if cage == . 
		replace c_illness = . if  (inlist(ca1,8,9) | inlist(ca14,8,9) | c_ari == .)
		


* c_treatdiarrhea: Child under 5 with diarrhea in last 2 weeks received oral rehydration saltes (ORS)
		gen c_treatdiarrhea = .
		
		#delimit ;
		if 	country_name == "LaoPDR2017" | 
			country_name == "SierraLeone2017" | 
			country_name == "Iraq2017" |
			country_name == "KyrgyzRepublic2018" |
			country_name == "Mongolia2018" |
		    country_name == "Suriname2018" |
			country_name == "Gambia2018" |
			country_name == "Tunisia2018" |
			country_name == "Madagascar2018" |
			country_name == "Bangladesh2019" |
			country_name == "Congodr2017" |
			country_name == "Togo2017" |
			country_name == "Kiribati2018" |
			country_name == "CostaRica2018" |
			country_name == "Guinea-Bissau2018" |
			country_name == "Belarus2019"|
			country_name == "Chad2019" |
			country_name == "StateofPalestine2019"|
			country_name == "Nepal2019" |
			country_name == "CentralAfricanRepublic2018"|
			country_name == "Cuba2019"|
			country_name == "Samoa2019"|
			country_name == "TurksCaicosIslands2019"|
			country_name == "Tuvalu2019"|
			country_name == "Argentina2019"|
			country_name == "SaoTomeAndPrincipe2019"|
			country_name == "Honduras2019" |
			country_name == "Malawi2019" {;
	    #delimit cr 
			replace c_treatdiarrhea = 0 if ca1 == 1						// children with diarrhea in last 2 weeks
			replace c_treatdiarrhea = 1 if c_treatdiarrhea == 0 & (ca7a == 1 | ca7b == 1)	// received ORS
			replace c_treatdiarrhea = . if cage == . | ca1 != 1   
			replace c_treatdiarrhea = . if inlist(ca7a, 8, 9) | inlist(ca7b, 8, 9)	// missing when both ORS variables are missing and none o	
		}                                                               // no CARE OF ILLNESS module for Iraq
		if inlist(country_name,"Lesotho2018","Zimbabwe2019","Georgia2018","Ghana2017","Algeria2018") {	
			replace c_treatdiarrhea = 0 if ca1 == 1						// children with diarrhea in last 2 weeks
			replace c_treatdiarrhea = 1 if c_treatdiarrhea == 0 & ca7a == 1	// received ORS
			replace c_treatdiarrhea = . if cage == . | ca1 != 1   
			replace c_treatdiarrhea = . if inlist(ca7a, 8, 9)      // missing when both ORS variables are missing and none o	
		}
		if inlist(country_name,"Tonga2019","Vietnam2020") {
					replace c_treatdiarrhea = 0 if ca1 == 1			// children with diarrhea in last 2 weeks
					replace c_treatdiarrhea = 1 if c_treatdiarrhea == 0 & (ca7b == 1)	// received ORS
					replace c_treatdiarrhea = . if cage == . | ca1 != 1
					replace c_treatdiarrhea = . if inlist(ca7b, 8, 9)   // missing when both ORS variables are missing and none o	
		}
		if inlist(country_name,"DominicanRepublic2019") {
					replace c_treatdiarrhea = 0 if ca1 == 1			// children with diarrhea in last 2 weeks
					replace c_treatdiarrhea = 1 if c_treatdiarrhea == 0 & (bd5 == 1)	// received ORS
					replace c_treatdiarrhea = . if cage == . | ca1 != 1
					replace c_treatdiarrhea = . if inlist(bd5, 8, 9)   // missing when both ORS variables are missing and none o	
		}	
	
* c_diarrhea_hmf:  Child under 5 with diarrhea in last 2 weeks received	Government recommended homemade fluid (Coconut water or rice water with salt)		
		
		gen c_diarrhea_hmf = .
		
		foreach var in ca7a ca7b ca7c ca7d {		
			cap gen `var' = .
		}
		replace c_diarrhea_hmf = 0 if ca1 == 1	         // children with diarrhea in last 2 weeks
		
		if ~inlist(country_name,"KyrgyzRepublic2018","Guinea-Bissau2018","Tonga2019","SaoTomeAndPrincipe2019","Samoa2019","TurksCaicosIslands2019","Tuvalu2019") | ~inlist("DominicanRepublic2019","Malawi2019","Vietnam2020") {		
			replace c_diarrhea_hmf = 1 if c_diarrhea_hmf == 0 & ca7d == 1 	// received Government recommended homemade fluid 
			replace c_diarrhea_hmf = . if inlist(ca7d, 8, 9) 	// missing when Government recommended homemade fluid  variable is missing and none o	
		}
		
		if inlist(country_name,"KyrgyzRepublic2018") {		
			replace c_diarrhea_hmf = 1 if c_diarrhea_hmf == 0 & (ca7d == 1 | ca7e == 1) 	// received Government recommended homemade fluid 
			replace c_diarrhea_hmf = . if inlist(ca7d, 8, 9) | inlist(ca7e, 8, 9) 	// missing when Government recommended homemade fluid  variable is missing and none o	
		}
		if inlist(country_name,"Tonga2019","DominicanRepublic2019") {
			replace c_diarrhea_hmf = 1 if c_diarrhea_hmf == 0 & ca7b == 1
			replace c_diarrhea_hmf = . if inlist(ca7b, 8, 9)	// missing when Government recommended homemade fluid  variable is missing and none o	
		}
		replace c_diarrhea_hmf = . if cage == . | ca1 != 1  
		
		
* c_diarrhea_med: Child under 5 with diarrhea in last 2 weeks received any medicine treatment other than ORS and homemade fluid

		gen c_diarrhea_med = .
		
		replace c_diarrhea_med = 0 if ca1 == 1	
		#delimit ;
		if 	country_name == "LaoPDR2017" | 
			country_name == "SierraLeone2017" | 
			country_name == "Lesotho2018" |
			country_name == "KyrgyzRepublic2018" |
			country_name == "Mongolia2018" |
		    country_name == "Suriname2018" |
			country_name == "Gambia2018" |
			country_name == "Tunisia2018" |
			country_name == "Madagascar2018" |
			country_name == "Zimbabwe2019" |
			country_name == "Georgia2018" |
			country_name == "Togo2017" |
			country_name == "Kiribati2018" |
			country_name == "Guinea-Bissau2018" |
			country_name == "Belarus2019"|
			country_name == "Chad2019"|
			country_name == "StateofPalestine2019"|
			country_name == "CentralAfricanRepublic2018" |
			country_name == "Cuba2019" |
			country_name == "Samoa2019" |
			country_name == "TurksCaicosIslands2019" |
			country_name == "CentralAfricanRepublic2018"|
			country_name == "SaoTomeAndPrincipe2019" |
			country_name == "Honduras2019" |
			country_name == "Malawi2019" {;
	    #delimit cr 
			replace c_diarrhea_med = 1 if c_diarrhea_med == 0 &  ca7c == 1 
			replace c_diarrhea_med = . if inlist(ca7c,8,9)   // OR treatment/consultation variable missing
		}
		if inlist(country_name,"Iraq2017") {
			replace c_diarrhea_med = 1 if c_diarrhea_med == 0 &  ca7c == 1 | ca7c1 == 1
			replace c_diarrhea_med = . if inlist(ca7c,8,9) | inlist(ca7c1,8,9)   // OR treatment/consultation variable missing
		}
		if inlist(country_name,"Bangladesh2019") {
			replace c_diarrhea_med = 1 if c_diarrhea_med == 0 &  (ca7c == 1 | ca7e == 1 | ca7f == 1 | ca7g == 1)
			replace c_diarrhea_med = . if inlist(ca7c,8,9) | inlist(ca7e,8,9) | inlist(ca7f,8,9) | inlist(ca7g,8,9)    // OR treatment/consultation variable missing
		}
		if inlist(country_name,"Congodr2017") {
			replace c_diarrhea_med = 1 if c_diarrhea_med == 0 &  (ca7c == 1 | ca7e == 1 | ca7f == 1 | ca7g == 1 | ca7h == 1 | ca7i == 1 | ca7j == 1)
			replace c_diarrhea_med = . if inlist(ca7c,8,9) | inlist(ca7e, 8, 9) | inlist(ca7f, 8, 9) | inlist(ca7g, 8, 9) | inlist(ca7h, 8, 9) | inlist(ca7i, 8, 9) | inlist(ca7j, 8, 9)     // OR treatment/consultation variable missing
		}
		if inlist(country_name,"Ghana2017") {
			replace c_diarrhea_med = 1 if c_diarrhea_med == 0 &  (ca7c == 1 | ca7aa == 1 | ca7ab == 1 | ca7ac == 1)
			replace c_diarrhea_med = . if inlist(ca7c,8,9) | inlist(ca7aa,8,9) | inlist(ca7ab,8,9) | inlist(ca7ac,8,9)    // OR treatment/consultation variable missing
		}
		if inlist(country_name,"CostaRica2018","Tonga2019") {
			replace c_diarrhea_med = 1 if c_diarrhea_med == 0 &  (ca7c == 1 | ca7d == 1)
			replace c_diarrhea_med = . if inlist(ca7c,8,9)  | inlist(ca7d,8,9)
		}	
		//Algeria2018: ca12 - anything else for treaating diarrhea
		if inlist(country_name,"Algeria2018") {
			replace c_diarrhea_med = 1 if c_diarrhea_med == 0 &  ca12 == 1
			replace c_diarrhea_med = . if inlist(ca12,8,9)   // OR treatment/consultation variable missing
		}
		if inlist(country_name,"Tuvalu2019") {
			replace c_diarrhea_med = 1 if c_diarrhea_med == 0 &  (ca7c == 1 | ca7d == 1 | ca73 == 1)
			replace c_diarrhea_med = . if inlist(ca7c,8,9) | inlist(ca7d,8,9) | inlist(ca7e,8,9)      // OR treatment/consultation variable missing
		}
		if inlist(country_name,"Vietnam2020") {
			replace c_diarrhea_med = 1 if c_diarrhea_med == 0 &  (ca7a == 1 | ca7c == 1)
			replace c_diarrhea_med = . if inlist(ca7a,8,9) | inlist(ca7c,8,9)      // OR treatment/consultation variable missing
		}
		if inlist(country_name,"DominicanRepublic2019") {
			replace c_diarrhea_med = 1 if c_diarrhea_med == 0 &  (ca12 == 1)
			replace c_diarrhea_med = . if inlist(ca12,8,9)      // OR treatment/consultation variable missing
		}

		replace c_diarrhea_med = 1 if  c_diarrhea_med == 0 & (ca13a == "A" | ca13b == "B" | ca13g == "G"| ca13h == "H" | ca13l == "L" | ca13m == "M" | ca13n == "N" | ca13o == "O" | ca13q == "Q" | ca13x == "X")
		replace c_diarrhea_med = . if  ca13a == "?" | ca13b == "?" | ca13g == "?"| ca13h == "?" | ca13l == "?" | ca13m == "?" | ca13n == "?" | ca13o == "?" | ca13q == "?" | ca13x == "?"
		replace c_diarrhea_med = . if cage == . | ca1 != 1           // Child age missing OR diarrhea variable missing 
		
		
* c_diarrhea_medfor: Child under 5 with diarrhea in last 2 weeks received any formal medicine treatment other than ORS and homemade fluid
		
		gen c_diarrhea_medfor = .
		
		replace c_diarrhea_medfor = 0 if ca1 == 1
		#delimit ;
		if 	country_name == "LaoPDR2017" | 
			country_name == "SierraLeone2017" | 
			country_name == "Lesotho2018" |
			country_name == "KyrgyzRepublic2018" |
			country_name == "Mongolia2018" |
		    country_name == "Suriname2018" |
			country_name == "Gambia2018" |
			country_name == "Tunisia2018" |
			country_name == "Madagascar2018" |
			country_name == "Zimbabwe2019" |
			country_name == "Georgia2018" |
			country_name == "Togo2017" |
			country_name == "Kiribati2018"|
			country_name == "Guinea-Bissau2018" |
			country_name == "Belarus2019"|
			country_name == "Samoa2019"|
			country_name == "CentralAfricanRepublic2018"|
			country_name == "Vietnam2020"|
			country_name == "Cuba2019" |
			country_name == "Honduras2019" |
			country_name == "Malawi2019" {;
	    #delimit cr 
			replace c_diarrhea_medfor = 1 if c_diarrhea_medfor == 0 &  ca7c == 1 
			replace c_diarrhea_medfor = . if inlist(ca7c,8,9)   // OR treatment/consultation variable missing
		}
		if inlist(country_name,"SaoTomeAndPrincipe2019","TurksCaicosIslands2019","Tuvalu2019") {
			replace c_diarrhea_medfor = 1 if c_diarrhea_medfor == 0 &  (ca7c == 1 | ca5 == 1)
			replace c_diarrhea_medfor = . if inlist(ca7c,8,9)   // OR treatment/consultation variable missing
			replace c_diarrhea_medfor = . if c_diarrhea_medfor == 0 & inlist(ca5,8,9)   // OR treatment/consultation variable missing
		}
		if inlist(country_name,"Iraq2017") {
			replace c_diarrhea_medfor = 1 if c_diarrhea_medfor == 0 &  ca7c == 1 | ca7c1 == 1
			replace c_diarrhea_medfor = . if inlist(ca7c,8,9) | inlist(ca7c1,8,9)   // OR treatment/consultation variable missing
		}
		if inlist(country_name,"Bangladesh2019") {
			replace c_diarrhea_medfor = 1 if c_diarrhea_medfor == 0 &  (ca7c == 1 | ca7e == 1 | ca7f == 1 | ca7g == 1)
			replace c_diarrhea_medfor = . if inlist(ca7c,8,9) | inlist(ca7e,8,9) | inlist(ca7f,8,9) | inlist(ca7g,8,9)    // OR treatment/consultation variable missing
		}
		if inlist(country_name,"Congodr2017") {
			replace c_diarrhea_medfor = 1 if c_diarrhea_medfor == 0 &  (ca7c == 1 | ca7e == 1 | ca7f == 1 | ca7g == 1 | ca7h == 1 | ca7i == 1 | ca7j == 1)
			replace c_diarrhea_medfor = . if inlist(ca7c,8,9) | inlist(ca7e, 8, 9) | inlist(ca7f, 8, 9) | inlist(ca7g, 8, 9) | inlist(ca7h, 8, 9) | inlist(ca7i, 8, 9) | inlist(ca7j, 8, 9)     // OR treatment/consultation variable missing
		}
		if inlist(country_name,"Ghana2017") {
			replace c_diarrhea_medfor = 1 if c_diarrhea_medfor == 0 &  (ca7c == 1 | ca7aa == 1 | ca7ab == 1 | ca7ac == 1)
			replace c_diarrhea_medfor = . if inlist(ca7c,8,9) | inlist(ca7aa,8,9) | inlist(ca7ab,8,9) | inlist(ca7ac,8,9)    // OR treatment/consultation variable missing
		}
		if inlist(country_name,"CostaRica2018","Tonga2019") {
			replace c_diarrhea_medfor = 1 if c_diarrhea_medfor == 0 &  (ca7c == 1 | ca7d == 1)
			replace c_diarrhea_medfor = . if inlist(ca7c,8,9)  | inlist(ca7d,8,9)
		}
		if inlist(country_name,"DominicanRepublic2019") {
			replace c_diarrhea_medfor = 1 if c_diarrhea_med == 0 &  (ca12 == 1)
			replace c_diarrhea_medfor = . if inlist(ca12,8,9)      // OR treatment/consultation variable missing
		}
		
		replace c_diarrhea_medfor = 1 if c_diarrhea_medfor == 0 & (ca13a == "A" | ca13b == "B" | ca13g == "G"| ca13h == "H" | ca13l == "L" | ca13m == "M" | ca13n == "N" | ca13o == "O")
		replace c_diarrhea_medfor = . if ca13a == "?" | ca13b == "?" | ca13g == "?"| ca13h == "?" | ca13l == "?" | ca13m == "?" | ca13n == "?" | ca13o == "?"
		replace c_diarrhea_medfor = . if cage == . | ca1 != 1           // Child age missing OR diarrhea variable missing 
		
		
		
		
* c_diarrhea_pro: Child under 5 with diarrhea in last 2 weeks seen by formal healthcare provider
		gen c_diarrhea_pro = .
		
		replace c_diarrhea_pro = 0 if ca1 == 1
			
		if inlist(country_name,"LaoPDR2017") {
		    global ca6 "ca6a ca6b ca6d ca6e ca6i ca6j ca6m"
		}
		if inlist(country_name,"SierraLeone2017","Gambia2018","Madagascar2018","Congodr2017","Ghana2017","CentralAfricanRepublic2018") {
		    global ca6 "ca6a ca6b ca6c ca6d ca6e ca6i ca6j ca6l ca6m"
		}	
		if inlist(country_name,"Iraq2017") {
		    global ca6 "ca6a ca6b ca6c ca6e ca6f ca6i ca6j ca6n ca6l"
	    }
		if inlist(country_name,"KyrgyzRepublic2018") {
		    global ca6 "ca6a ca6b ca6c ca6e ca6i ca6j ca6m"
	    }		
        if inlist(country_name,"Mongolia2018") {	
		    global ca6 "ca6a ca6b ca6d ca6f ca6i ca6j ca6w"
	    }		
		if inlist(country_name,"Suriname2018","Kiribati2018") {
		    global ca6 "ca6a ca6b ca6d ca6e ca6i ca6j ca6l ca6m ca6w"
	    }	
		if inlist(country_name,"Tunisia2018") {
		    global ca6 "ca6a ca6b ca6e ca6i ca6j"
	    }			
		if inlist(country_name,"Lesotho2018") {
		    global ca6 "ca6a ca6b ca6c ca6d ca6e ca6g ca6h ca6i ca6j ca6k ca6m ca6n ca6p"
		}
		if inlist(country_name,"Zimbabwe2019") {
			global ca6 "ca6a ca6b ca6d ca6e ca6f ca6i ca6j ca6l ca6m ca6t ca6u ca6w"
		}
		if inlist(country_name,"Georgia2018") {
			global ca6 "ca6s ca6t ca6u ca6j ca6v ca6f ca6g"
		}
		if inlist(country_name,"Bangladesh2019") {
			global ca6 "ca6a ca6b ca6c ca6d ca6e ca6i ca6j ca6l ca6m ca6n ca6w"
		}	
		if inlist(country_name,"Togo2017") {
			global ca6 "ca6a ca6b ca6c ca6d ca6f ca6g ca6h ca6i ca6j ca6l"
		}
		if inlist(country_name,"CostaRica2018") {
			global ca6 "ca6a ca6b ca6c ca6e ca6i ca6j ca6m"
		}
		if inlist(country_name,"Tonga2019"){
			global ca6 "ca6a ca6b ca6h ca6i ca6j ca6k ca6o"
		}
		if inlist(country_name,"Belarus2019") {
			global ca6 "ca6a ca6b ca6c ca6f ca6j ca6i"
		}
		if inlist(country_name,"Chad2019") {
			global ca6 "ca6a ca6b ca6c ca6d ca6i ca6j ca6l"
		}
		if inlist(country_name,"StateofPalestine2019","Nepal2019") {
			global ca6 "ca6a ca6b ca6i ca6j"
		}			
		if inlist(country_name,"Guinea-Bissau2018") {
		    global ca6 "ca6a ca6b ca6d ca6e ca6i ca6j ca6k ca6m"
		}		/*no Outro Publico or Outro Privado*/
		if inlist(country_name,"Algeria2018") {
		    global ca6 "ca6a ca6b ca6c ca6h ca6i ca6j ca6k ca6o"
		}      /*Inclut tous les etablissements de sante et prestataires de sante publiics et prives (excluding traditional providers)*/
    if inlist(country_name,"Cuba2019") {
			global ca6 "ca6a ca6b ca6c ca6d ca6e"
		}  /*  CONSULTORIO DEL MÉDICO Y ENFERMERA DE LA FAMILIA / médico pariente / enfermera pariente*/
		if inlist(country_name,"SaoTomeAndPrincipe2019") {
			global ca6 "ca6a ca6b ca6c ca6d ca6e ca6h ca6i ca6j ca6l ca6m ca6o"
		}	
		if inlist(country_name,"Samoa2019") {
			global ca6 "ca6a ca6b ca6j"
		}
		if inlist(country_name,"TurksCaicosIslands2019") {
			global ca6 "ca6a ca6i"
		}
		if inlist(country_name,"Tuvalu2019") {
			global ca6 "ca6a ca6b ca6c ca6d ca6e ca6h ca6i ca6j ca6l ca6m ca6o ca6w"
		}
		if inlist(country_name,"Vietnam2020") {
			global ca6 "ca6a ca6b ca6c ca6d ca6f ca6h ca6i ca6j"
		}
		if inlist(country_name,"Argentina2019") {
			global ca6 "ca6a ca6b ca6d ca6h ca6j ca6o"
		}
		if inlist(country_name,"Honduras2019") {
			global ca6 "ca6a ca6b ca6d ca6e ca6f ca6i ca6j ca6l ca6m"
		}
		if inlist(country_name,"DominicanRepublic2019") {
			global ca6 "ca6a ca6b ca6c ca6d ca6e ca6i ca6j ca6m"
		}
		if inlist(country_name,"Malawi2019") {
		    global ca6 "ca6a ca6b ca6c ca6d ca6e ca6i ca6j ca6l ca6m ca6s ca6t"
		}			
		
		foreach var in $ca6 {
		    replace `var' = "" if `var' == " "
			replace c_diarrhea_pro = 1 if c_diarrhea_pro == 0 & `var' != "" & `var' != "?" 
			replace c_diarrhea_pro = . if `var' == "?"
		}
		replace c_diarrhea_pro = . if cage == . | ca1 != 1           // Child age missing OR diarrhea variable missing 

		

* c_diarrheaact: Child under 5 with diarrhea in last 2 weeks seen by formal healthcare provider or given any form of treatment
		gen c_diarrheaact = .
		
		replace c_diarrheaact = 0 if ca1 == 1
		replace c_diarrheaact = 1 if c_diarrhea_pro == 1

		if inlist(country_name,"Guinea-Bissau2018") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1 | ca7c == 1 | ca7d == 1)
		}		

		if inlist(country_name,"SaoTomeAndPrincipe2019","TurksCaicosIslands2019","Malawi2019") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1 | ca7c == 1)
		}		
		if inlist(country_name,"LaoPDR2017","SierraLeone2017","Mongolia2018","Gambia2018","Tunisia2018","Madagascar2018","Togo2017","Kiribati2018", "CostaRica2018")| inlist(country_name,"Belarus2019","Chad2019","StateofPalestine2019","CentralAfricanRepublic2018","Tuvalu2019","Guinea-Bissau2018","Honduras2019","Vietnam2020"){
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1 | ca7c == 1 | ca7d == 1)
		}
		if inlist(country_name,"Iraq2017") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1 | ca7c == 1 | ca7c1 == 1 | ca7d == 1)
		}
		if inlist(country_name,"KyrgyzRepublic2018") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1 | ca7c == 1 | ca7d == 1 | ca7e == 1)
		}
		if inlist(country_name,"Suriname2018") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1)
		}
		if inlist(country_name,"Lesotho2018","Zimbabwe2019") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7c == 1 | ca7d == 1)
		}
		if inlist(country_name,"Georgia2018") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7c == 1)
		}
		if inlist(country_name,"Bangladesh2019") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1 | ca7c == 1 | ca7d == 1 | ca7e == 1 | ca7f == 1 | ca7g == 1)
			replace c_diarrheaact = . if ca7a == 9 | ca7b == 9 | ca7c == 9 | ca7d == 9 | ca7e == 9 | ca7f == 9 | ca7g == 9
		}
		if inlist(country_name,"Congodr2017") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1 | ca7c == 1 | ca7d == 1 | ca7e == 1 | ca7f == 1 | ca7g == 1 | ca7h == 1 | ca7i == 1 | ca7j == 1)
			replace c_diarrheaact = . if ca7a == 9 | ca7b == 9 | ca7c == 9 | ca7d == 9 | ca7e == 9 | ca7f == 9 | ca7g == 9 | ca7h == 9 | ca7i == 9 | ca7j == 9
		}
		if inlist(country_name,"Ghana2017") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7d == 1 | ca7c == 1 | ca7aa == 1 | ca7ab == 1 | ca7ac == 1)
			replace c_diarrheaact = . if ca7a == 9 | ca7d == 9 | ca7c == 9 | ca7aa == 9 | ca7ab == 9 | ca7ac == 9 
		}
		if inlist(country_name,"Algeria2018") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7d == 1)
			replace c_diarrheaact = . if ca7a == 9 | ca7d == 9 
    }
		if inlist(country_name,"Nepal2019","StateofPalestine2019") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1| ca7d == 1)
		}
		if inlist(country_name,"Tonga2019"){
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7b == 1)
		}
		if inlist(country_name,"Cuba2019") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1| ca7c == 1)
		}
		if inlist(country_name,"Samoa2019") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1| ca7c == 1 | ca7d == 1 | ca7e == 1)
		}
		if inlist(country_name,"Argentina2019") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1)
		}
		if inlist(country_name,"DominicanRepublic2019") {
			replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca7a == 1 | ca7b == 1 | ca12)
		}
		
		replace c_diarrheaact = 1 if c_diarrheaact == 0 & (ca13a == "A" | ca13b == "B" | ca13g == "G"| ca13h == "H" | ca13l == "L" | ca13m == "M" | ca13n == "N" | ca13o == "O" | ca13q == "Q" | ca13x == "X")
		replace c_diarrheaact = . if ca13a == "?" | ca13b == "?" | ca13g == "?"| ca13h == "?" | ca13l == "?" | ca13m == "?" | ca13n == "?" | ca13o == "?" | ca13q == "?" | ca13x == "?"
		replace c_diarrheaact = . if cage == . | ca1 != 1           // Child age missing OR diarrhea variable missing 
		replace c_diarrheaact = . if c_diarrhea_pro == .	

		
* c_diarrheaact_q: Child under 5 with diarrhea in last 2 weeks seen by formal healthcare provider or given any form of treatment who received ORS
		gen c_diarrheaact_q = .
		
		replace c_diarrheaact_q = 0 if c_diarrheaact == 1
		replace c_diarrheaact_q = 1 if c_diarrheaact_q == 0 & c_treatdiarrhea == 1
		replace c_diarrheaact_q = . if cage == . | ca1 != 1
		replace c_diarrheaact_q = . if c_diarrheaact_q == 0 & c_treatdiarrhea == .
		
		
* c_diarrhea_mof: Child under 5 with diarrhea offered more than usual to drink
		gen c_diarrhea_mof = .
		
		replace c_diarrhea_mof = 0 if ca1 == 1
		replace c_diarrhea_mof = 1 if c_diarrhea_mof == 0 & ca3 == 4
		replace c_diarrhea_mof = . if inlist(ca3,8,9)
		
		
* c_sevdiarrhea: Child under 5 with severe diarrhea in last 2 weeks
		gen c_sevdiarrhea = .
		replace c_sevdiarrhea = 1 if ca1 == 1 & (ca3 == 4 | inlist(ca4,1,5,6,7) | ca14 == 1) // Child has either of the three conditions: fever OR offered more than usual to drink OR given much less or nothing to eat or stopped eating
        replace c_sevdiarrhea = 0 if ca1 == 1 & (~inlist(ca3,4,8,9) & ~inlist(ca4,1,5,6,7,8,9) & ca14 == 2)
		replace c_sevdiarrhea = . if cage == . | ca1 != 1  
		replace c_sevdiarrhea = . if (inlist(ca3,8,9) | inlist(ca4,8,9) | inlist(ca14,8,9))


		
* c_sevdiarrheatreat: Child under 5 with severe diarrhea in last 2 weeks seen by formal healthcare provider
		gen c_sevdiarrheatreat = .
		replace c_sevdiarrheatreat = 0 if ca1 == 1 & (ca3 == 4 | inlist(ca4,1,5,6,7) | ca14 == 1) // Child has either of the three conditions: fever OR offered more than usual to drink OR given much less or nothing to eat or stopped eating
      
	    foreach var in $ca6 {
		    replace `var' = "" if `var' == " "
			replace c_sevdiarrheatreat = 1 if c_sevdiarrheatreat == 0 & `var' != "" & `var' != "?" 
			replace c_sevdiarrheatreat = . if  `var' == "?"
		}
		replace c_sevdiarrheatreat = . if cage == . | ca1 != 1
		replace c_sevdiarrheatreat = . if ~inrange(ca3,1,5) & ~inrange(ca4,1,7) & ~inlist(ca14,1,2)
		
		
		
* c_sevdiarrheatreat_q: Child under 5 with severe diarrhea in last 2 weeks seen by fromal healthcare provider who received IV (intravenous) treatment
		gen c_sevdiarrheatreat_q = .
		replace c_sevdiarrheatreat_q = 0 if c_sevdiarrheatreat == 1
		replace c_sevdiarrheatreat_q = 1 if c_sevdiarrheatreat_q == 0 & ca13o != "" & ca13o != "?" 
		replace c_sevdiarrheatreat_q = . if ca13o == "?"
		replace c_sevdiarrheatreat_q = . if cage == . | ca1 != 1


		
		
* c_treatARI: Child under 5 with acute respiratory infection (ARI) visited formal healthcare provider (not merely pharmacy) -- note that "dispensaries" are considered formal providers
		gen c_treatARI = .
		replace c_treatARI = 0 if ca16 == 1 & ca17 == 1 & inlist(ca18,1,3)		// children with cough and rapid breathing originating from chest

		if inlist(country_name,"LaoPDR2017") {
		    global ca21 "ca21a ca21b ca21d ca21e ca21i ca21j ca21m"
		}
		if inlist(country_name,"SierraLeone2017","Gambia2018","Madagascar2018","Congodr2017","Ghana2017") {
		    global ca21 "ca21a ca21b ca21c ca21d ca21e ca21i ca21j ca21l ca21m"
		}	
		if inlist(country_name,"Iraq2017") {
		    global ca21 "ca21a ca21b ca21c ca21f ca21e ca21i ca21j ca21l ca21n"
	    }
		if inlist(country_name,"KyrgyzRepublic2018") {
		    global ca21 "ca21a ca21b ca21c ca21e ca21i ca21j ca21m "
	    }		
        if inlist(country_name,"Mongolia2018") {	
		    global ca21 "ca21a ca21b ca21d ca21f ca21i ca21j ca21w "
	    }		
		if inlist(country_name,"Suriname2018","Kiribati2018") {
		    global ca21 "ca21a ca21b ca21d ca21e ca21i ca21j ca21l ca21m ca21w"
	    }	
		if inlist(country_name,"Tunisia2018") {
		    global ca21 "ca21a ca21b ca21e ca21i ca21j"
	    }			
		if inlist(country_name,"Lesotho2018") {
		    global ca21 "ca21a ca21b ca21c ca21d ca21e ca21g ca21h ca21i ca21j ca21k ca21m ca21n ca21p"
		}
		if inlist(country_name,"Zimbabwe2019") {
			global ca21 "ca21a ca21b ca21d ca21e ca21f ca21i ca21j ca21l ca21m ca21t ca21u ca21w"
		}
		if inlist(country_name,"Georgia2018") {
			global ca21 "ca21s ca21t ca21u ca21j ca21v ca21f ca21g"
		}
		if inlist(country_name,"Bangladesh2019") {
			global ca21 "ca21a ca21b ca21c ca21d ca21e ca21i ca21j ca21l ca21m ca21n ca21w"
		}	
		if inlist(country_name,"Togo2017") {
			global ca21 "ca21a ca21b ca21c ca21d ca21f ca21g ca21h ca21i ca21j ca21l"
		}
		if inlist(country_name,"CostaRica2018") {
			global ca21 "ca21a ca21b ca21c ca21e ca21i ca21j ca21m"
		}
		if inlist(country_name,"Tonga2019") {
			global ca21 "ca21a ca21b ca21h ca21i ca21j ca21k ca21o"
		}		
		if inlist(country_name,"Guinea-Bissau2018") {
		    global ca21 "ca21a ca21b ca21d ca21e ca21i ca21j ca21k ca21m"
		}		//no Outro Publico or Outro Privado
		
		if inlist(country_name,"Belarus2019") {
			global ca21 "ca21a ca21b ca21c ca21f ca21i ca21j"
		}	
		if inlist(country_name,"Chad2019") {
			global ca21 "ca21a ca21b ca21c ca21d ca21i ca21j ca21l"
		}
		if inlist(country_name,"StateofPalestine2019","Nepal2019") {
			global ca21 "ca21a ca21b ca21i ca21j"
		}
		if inlist(country_name,"Algeria2018") {
			global ca21 "ca21a ca21b ca21c ca21h ca21i ca21j ca21o"
		}		//exclut les pharmacies privees

		if inlist(country_name,"CentralAfricanRepublic2018") {
		    global ca21 "ca21a ca21b ca21c ca21d ca21e ca21h ca21i ca21j ca21l ca21m ca21o"
		}	

		if inlist(country_name,"Cuba2019") {
		    global ca21 "ca21a ca21b ca21c ca21d ca21e"
		}

		if inlist(country_name,"SaoTomeAndPrincipe2019") {
			global ca21 "ca21a ca21b ca21c ca21d ca21e ca21h ca21i ca21j ca21k ca21l ca21m ca21o"
		}	

		if inlist(country_name,"Samoa2019") {
			global ca21 "ca21a ca21b ca21j"
		} 
		if inlist(country_name,"TurksCaicosIslands2019") {
			global ca21 "ca21a ca21b ca21i ca21j"
		} 
		if inlist(country_name,"Tuvalu2019") {
			global ca21 "ca21a ca21b ca21c ca21d ca21e ca21h ca21i ca21j ca21l ca21m ca21o ca21w"
		} 
		if inlist(country_name,"Vietnam2020") {
			global ca21 "ca21a ca21b ca21c ca21d ca21e ca21f ca21h ca21i ca21j ca21o"
		} 
		if inlist(country_name,"Argentina2019") {
			global ca21 "ca21a ca21b ca21d ca21h ca21i ca21j ca21o"
		} 
		if inlist(country_name,"Honduras2019") {
			global ca21 "ca21a ca21b ca21d ca21e ca21f ca21i ca21j ca21l ca21m"
		}
		if inlist(country_name,"DominicanRepublic2019") {
			global ca21 "ca21a ca21b ca21c ca21d ca21e ca21i ca21j ca21m"
		}
		if inlist(country_name,"Malawi2019") {
		    global ca21 "ca21a ca21b ca21c ca21d ca21e ca21i ca21j ca21l ca21m ca21s ca21t"
		}			
		
	    foreach var in $ca21 {
		    replace `var' = "" if `var' == " "
		    replace c_treatARI = 1 if c_treatARI == 0 & `var' != "" & `var' != "?" 
			replace c_treatARI = . if `var' == "?"                 // treatment/consultation variable missing for any formal provider and all formal providers for which data is available are not seen (=0).
		}
		replace c_treatARI = . if cage == . 
		replace c_treatARI = . if ~inlist(ca16,1,2) | ~inlist(ca17,1,2) | ~inlist(ca18,1,3) //  any ARI symptom variable missing 
	
		
			
* any childhood illness: Child with any illness symptoms taken to formal provider
	    gen c_illtreat = .
	    replace c_illtreat = 0 if ca1 == 1 | ca14 == 1 | inlist(ca18,1,3)
	
		if inlist(country_name,"LaoPDR2017") {
		    global ca621 "ca6a ca6b ca6d ca6e ca6i ca6j ca6m ca21a ca21b ca21d ca21e ca21i ca21j ca21m"
		}
		if inlist(country_name,"SierraLeone2017","Gambia2018","Madagascar2018","Congodr2017","Ghana2017") {
		    global ca621 "ca6a ca6b ca6c ca6d ca6e ca6i ca6j ca6l ca6m ca21a ca21b ca21c ca21d ca21e ca21i ca21j ca21l ca21m"
		}	
		if inlist(country_name,"Iraq2017") {
		    global ca621 "ca6a ca6b ca6e ca6f ca6i ca6j ca6n ca21a ca21b ca21e ca21f ca21i ca21j ca21n"
	    }
		if inlist(country_name,"KyrgyzRepublic2018") {
		    global ca621 "ca6a ca6b ca6c ca6e ca6i ca6j ca6m ca21a ca21b ca21c ca21e ca21i ca21j ca21m"
	    }		
        if inlist(country_name,"Mongolia2018") {	
		    global ca621 "ca6a ca6b ca6d ca6f ca6i ca6j ca6w ca21a ca21b ca21d ca21f ca21i ca21j ca21w"
	    }		
		if inlist(country_name,"Suriname2018","Kiribati2018") {
		    global ca621 "ca6a ca6b ca6d ca6e ca6i ca6j ca6l ca6m ca6w ca21a ca21b ca21d ca21e ca21i ca21j ca21l ca21m ca21w"
	    }	
		if inlist(country_name,"Tunisia2018") {
		    global ca621 "ca6a ca6b ca6e ca6i ca6j ca21a ca21b ca21e ca21i ca21j "
	    }			
		if inlist(country_name,"Lesotho2018") {
		    global ca621 "ca6a ca6b ca6c ca6d ca6e ca6g ca6h ca6i ca6j ca6k ca6m ca6n ca6p ca21a ca21b ca21c ca21d ca21e ca21g ca21h ca21i ca21j ca21k ca21m ca21n ca21p"
		}	
		if inlist(country_name,"Zimbabwe2019") {
			global ca621 "ca6a ca6b ca6d ca6e ca6f ca6i ca6j ca6l ca6m ca6t ca6u ca6w ca21a ca21b ca21d ca21e ca21f ca21i ca21j ca21l ca21m ca21t ca21u ca21w"
		}
		if inlist(country_name,"Georgia2018") {
			global ca621 "ca6s ca6t ca6u ca6j ca6v ca6f ca6g ca21s ca21t ca21u ca21j ca21v ca21f ca21g"
		}
		if inlist(country_name,"Bangladesh2019") {
			global ca621 "ca6a ca6b ca6c ca6d ca6e ca6i ca6j ca6l ca6m ca6n ca6w ca21a ca21b ca21c ca21d ca21e ca21i ca21j ca21l ca21m ca21n ca21w"
		}	
		if inlist(country_name,"Togo2017") {
			global ca621 "ca6a ca6b ca6c ca6d ca6f ca6g ca6h ca6i ca6j ca6l ca21a ca21b ca21c ca21d ca21f ca21g ca21h ca21i ca21j ca21l"
		}
		if inlist(country_name,"CostaRica2018") {
			global ca621 "ca6a ca6b ca6c ca6e ca6i ca6j ca6m ca21a ca21b ca21c ca21e ca21i ca21j ca21m"
		}
		if inlist(country_name,"Tonga2019"){
			global ca621 "ca6a ca6b ca6h ca6i ca6j ca6k ca6o ca21a ca21b ca21h ca21i ca21j ca21k ca21o"
		}		
		if inlist(country_name,"Guinea-Bissau2018") {
		    global ca621 "ca6a ca6b ca6d ca6e ca6i ca6j ca6k ca6m ca21a ca21b ca21d ca21e ca21i ca21j ca21k ca21m"
		}		//no Outro Publico or Outro Privado		

		if inlist(country_name,"Belarus2019") {
			global ca621 "ca6a ca6b ca6c ca6f ca6i ca6j ca21a ca21b ca21c ca21f ca21i ca21j"
		}	
		if inlist(country_name,"Chad2019") {
			global ca621 "ca6a ca6b ca6c ca6d ca6i ca6j ca6l ca21a ca21b ca21c ca21d ca21i ca21j ca21l"
		}	
		if inlist(country_name,"Algeria2018") {
		    global ca621 "ca6a ca6b ca6c ca6h ca6i ca6j ca6k ca6o ca21a ca21b ca21c ca21h ca21i ca21j ca21o"
		}		
		if inlist(country_name,"StateofPalestine2019","Nepal2019") {
			global ca621 "ca6a ca6b ca6i ca6j ca21a ca21b ca21i ca21j"
		}
		if inlist(country_name,"CentralAfricanRepublic2018") {
		    global ca621 "ca6a ca6b ca6c ca6d ca6e ca6i ca6j ca6l ca6m ca21a ca21b ca21c ca21d ca21e ca21h ca21i ca21j ca21l ca21m ca21o"
		}	

		if inlist(country_name,"Cuba2019") {
		    global ca621 "ca6a ca6b ca6c ca6d ca6e ca21a ca21b ca21c ca21d ca21e"
		}

		if inlist(country_name,"SaoTomeAndPrincipe2019") {
			global ca621 "ca6a ca6b ca6c ca6d ca6e ca6h ca6i ca6j ca6l ca6m ca6o ca21a ca21b ca21c ca21d ca21e ca21h ca21i ca21j ca21k ca21l ca21m ca21o"
		}	
		
		if inlist(country_name,"Samoa2019") {
			global ca621 "ca6a ca6b ca6j ca21a ca21b ca21j"
		}	
		if inlist(country_name,"TurksCaicosIslands2019") {
			global ca621 "ca6a ca6i ca21a ca21b ca21i ca21j"
		}	
		if inlist(country_name,"Tuvalu2019") {
			global ca621 "ca6a ca6b ca6c ca6d ca6e ca6h ca6i ca6j ca6l ca6m ca6o ca6w ca21a ca21b ca21c ca21d ca21e ca21h ca21i ca21j ca21l ca21m ca21o ca21w"
		}	
		if inlist(country_name,"Vietnam2020") {
			global ca621 "ca6a ca6b ca6c ca6d ca6f ca6h ca6i ca6j ca21a ca21b ca21c ca21d ca21e ca21f ca21h ca21i ca21j ca21o"
    }  
		if inlist(country_name,"Argentina2019") {
			global ca621 "ca6a ca6b ca6d ca6h ca6j ca6o ca21a ca21b ca21d ca21h ca21i ca21j ca21o"
		}
		if inlist(country_name,"Honduras2019") {
			global ca621 "ca6a ca6b ca6d ca6e ca6f ca6i ca6j ca6l ca6m ca21a ca21b ca21d ca21e ca21f ca21i ca21j ca21l ca21m"
		}
		if inlist(country_name,"DominicanRepublic2019") {
			global ca621 "ca6a ca6b ca6c ca6d ca6e ca6i ca6j ca6m ca21a ca21b ca21c ca21d ca21e ca21i ca21j ca21m"
		}
		if inlist(country_name,"Malawi2019") {
		    global ca621 "ca6a ca6b ca6c ca6d ca6e ca6i ca6j ca6l ca6m ca6s ca6t ca21a ca21b ca21c ca21d ca21e ca21i ca21j ca21l ca21m ca21s ca21t"
		}	
		
		foreach var in $ca621 {
				replace `var' = "" if `var' == " "
				replace c_illtreat = 1 if c_illtreat == 0 & `var' != "" & `var' != "?" 
			    replace c_illtreat = . if  `var' == "?" 
		}
	    replace c_illtreat = . if cage == . 
        replace c_illtreat = . if (~inlist(ca1,1,2) | ~inlist(ca14,1,2) | ~inlist(ca18,1,3))
	
    }		

		
		else {
			foreach var in c_diarrhea c_ari c_illness c_treatdiarrhea c_diarrhea_hmf c_diarrhea_med c_diarrhea_medfor c_diarrhea_pro c_diarrheaact c_diarrheaact_q c_diarrhea_mof c_sevdiarrhea c_sevdiarrheatreat c_sevdiarrheatreat_q c_treatARI c_illtreat{
				cap gen `var'=.
			}
		}		
