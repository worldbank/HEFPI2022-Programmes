/// Batch MICS6-dofiles
//Do-file for the indicator:
/// c_measles
/// c_bcg
/// c_dpt1
/// c_dpt2
/// c_dpt3
/// c_polio1
/// c_polio2
/// c_polio3
/// c_fullimm
/// c_vaczero

/*  For polio:
    If the info is available from the vaccination card, code for polio1-3
	If the info is only available from the mother, the way the question is asked differs across MICS surveys
	Some surveys asks mothers of kids without a vaccination card a question about whether the child was given a polio vaccination at birth. 
         If the mother answers that the child DID receive this vaccination, we code polio1 = 1 if total # of polio vaccinations >= 2, polio2 = 1 if total # number of polio vaccinations >=3 and polio3 = 1 if total # of polio vaccinations >=4.
	     If the mother answers that the child did NOT receive this vaccination, we code polio1 = 1 if total # of polio vaccinations >= 1, polio2 = 1 if total # number of polio vaccinations >=2 and polio3 = 1 if total # of polio vaccinations >=3.
	Other surveys don’t ask mothers without a vaccination card a question about polio at birth. In this case, we assume that polio at birth was not given, and therefore code polio1 = 1 if total # of polio vaccinations >= 1, polio2 = 1 if total # number of polio vaccinations >=2 and polio3 = 1 if total # of polio vaccinations >=3.
*/

	*c_measles: Child age 15-23 immunized against measles/MMR
		foreach var in im6my im26 im2 im5 im11 {		// create empty variables for surveys without immunization modules
			cap gen `var' = .
		}
		gen c_measles = .
		replace c_measles = 0 if inrange(cage,15,23) & im2 != .				// children aged 15-23 months						
		
		if inlist(country_name,"LaoPDR2017","SierraLeone2017","Togo2017","Guinea-Bissau2018","CentralAfricanRepublic2018","Cuba2019") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6my,2000,6666) | inlist(im6md,44,66))			// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & im26 == 1				// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6my,6667,9999) | inrange(im6md,97,98))) | (im11 == 1 & inlist(im26,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}

		if inlist(country_name,"Iraq2017") {
			replace c_measles = 1 if c_measles == 0 & ((inrange(im6my,2000,6666) | inlist(im6md,44,66)) | (inrange(im6mey,2000,6666) | inlist(im6med,44,66)))			// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & (im26b == 1 | im26c == 1)    		// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6my,6667,9999) | inrange(im6md,97,99) & (inrange(im6mey,6667,9999) | inrange(im6med,97,98)))) | (im11 == 1 & inlist(im26c,8,9) & inlist(im26d,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}	

		// no immunization module for Iraq
		if inlist(country_name,"KyrgyzRepublic2018","Mongolia2018","NorthMacedonia2018") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6m1y,2000,6666) | inlist(im6m1d,44,66) | inrange(hf12m1y,2000,6666) | inlist(hf12m1d,44,66))			// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & im26 == 1				// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6m1y,6667,9999) | inrange(im6m1d,97,98) | inrange(hf12m1y,6667,9999) | inlist(hf12m1d,0,97,98))) | (im11 == 1 & inlist(im26,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}		

       //  need to combine with FORM FOR VACCINATION RECORDS AT HEALTH FACILITY	   
		if inlist(country_name,"Suriname2018","Gambia2018","Zimbabwe2019","Kiribati2018", "CostaRica2018","Thailand2019","StateofPalestine2019","Honduras2019") | inlist("DominicanRepublic2019","Malawi2019") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6m1y,2000,6666) | inlist(im6m1d,44,66))			// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & im26 == 1				// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6m1y,6667,9999) | inrange(im6m1d,97,98))) | (im11 == 1 & inlist(im26,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}	
		
		if inlist(country_name,"Tunisia2018") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6rr1y,2000,6666) | inlist(im6rr1d,44,66))                         		// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & (im26 == 1 | imp26 == 1 | impp26 == 1 | imp29 == 1 | impp29 == 1)    		// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6rr1y,6667,9999) | inrange(im6rr1d,97,99))) | (im11 == 1 & inlist(im26,8,9) & inlist(imp26,8,9) & inlist(impp26,8,9) & inlist(imp29,8,9) & inlist(impp29,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}		

		if inlist(country_name,"Lesotho2018") {   
			replace c_measles = 1 if c_measles == 0 & (inrange(im6mr1y,2000,6666) | inlist(im6mr1d,44,66) | inrange(im6m1y,2000,6666) | inlist(im6m1d,44,66))                         		// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & (im26 == 1 | im26b == 1)   		       // measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6mr1y,6667,9999) | inrange(im6mr1d,97,99) | inrange(im6m1y,6667,9999) | inrange(im6m1d,97,99))) | (im11 == 1 & inlist(im26,8,9) & inlist(im26b,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}	

		if inlist(country_name,"Tuvalu2019") {  
		replace c_measles = 1 if c_measles == 0 & (inrange(im6mr1y,2000,6666) | inlist(im6mr1d,44,66))            // measles/MMR from card
		replace c_measles = 1 if c_measles == 0 & (im26 == 1 | inrange(im26a,1,3))   		       // measles/MMR from memory
		replace c_measles = . if ((inrange(im5,4,9) & (inrange(im6mr1y,6667,9999) | inrange(im6mr1d,97,99))) |inlist(im26,8) & inlist(im26b,8)) | (inlist(im2,4,9)))	// missing if measles DK/missing for card and memory
		}

		if inlist(country_name,"Madagascar2018") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6vary,2000,6666) | inlist(im6vard,44,66))			// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & im26 == 1				// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6vary,6667,9999) | inrange(im6vard,97,98))) | (im11 == 1 & inlist(im26,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}	   

		if inlist(country_name,"Congodr2017") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6my,2000,6666) | inlist(im6md,44,66) | inrange(hf12my,2000,6666) | inlist(hf12md,44,66))			// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & im26 == 1				// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6my,6667,9999) | inrange(im6md,97,98) | inrange(hf12my,6667,9999) | inlist(hf12md,0,97,98))) | (im11 == 1 & inlist(im26,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}		
		if inlist(country_name,"Kosovo2019") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6my,2000,6666) | inlist(im6md,66) | inrange(hf12my,2000,6666) | inlist(hf12md,44,66))			// measles/MMR from card and mather report
			replace c_measles = 1 if c_measles == 0 & im26 == 1				// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6my,6667,9999) | inrange(im6md,97,98) | inrange(hf12my,6667,9999) | inlist(hf12md,97,98))) | (im11 == 1 & inlist(im26,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}		
		if inlist(country_name,"Ghana2017") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6my,2000,6666) | inlist(im6md,44,66))			// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & im26a == 1				// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6my,6667,9999) | inrange(im6md,97,98))) | (im11 == 1 & inlist(im26a,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}
		
		if inlist(country_name,"Tonga2019") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6m2y,2000,6666) | inlist(im6m2d,44))		// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & im26 == 1												// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6m2y,6667,9999) | inrange(im6m2d,97,98))) | (inlist(im2,4,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}

		if inlist(country_name,"Nepal2019","Samoa2019","TurksCaicosIslands2019") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6m1y,2000,6666) | inlist(im6m1d,44,66))
			replace c_measles = 1 if c_measles == 0 & (inrange(im6m2y,2000,6666) | inlist(im6m2d,44,66))			// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & im26 == 1				// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6m1y,6667,9999) | inrange(im6m1d,97,98))) | (im11 == 1 & inlist(im26,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6m2y,6667,9999) | inrange(im6m2d,97,98))) | (im11 == 1 & inlist(im26,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}

		if inlist(country_name,"Vietnam2020") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6m1y,2000,6666) | inlist(im6m1d,44,66) | inrange(hf12m1y,2000,6666) | inlist(hf12m1d,44,66))      
			replace c_measles = 1 if c_measles == 0 & (inrange(im6m2y,2000,6666) | inlist(im6m2d,44,66) | inrange(hf12m2y,2000,6666) | inlist(hf12m2d,44,66))			// measles/MMR from card
	
			replace c_measles = 1 if c_measles == 0 & (im26 == 1 | im26a == 1 | im26b == 1 | im26c == 1)   		       // measles/MMR from memory

			replace c_measles = . if (inrange(im5,1,3) & (inrange(im6m1y,6667,9999) | inrange(im6m1d,97,98) | inrange(im6m2y,6667,9999) | inrange(im6m2d,97,98)) & (inrange(hf12m1y,6667,9999) | inrange(hf12m1d,97,98) | inrange(hf12m2y,6667,9999) | inrange(hf12m2d,97,98))) | (im11 == 1 & inlist(im26,8,9) & inlist(im26a,8) & inlist(im26b,8,9) & inlist(im26c,8)) | (inlist(im2,8,9) & inlist(im11,8,9)) // missing if measles DK/missing for card and memory
		}

		if inlist(country_name,"Serbia2019") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6mmry,2000,6666) | inlist(im6mmrd,44,66))		// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & (inrange(hf12mmry,2000,6666) | inlist(hf12mmrd,44,66))	// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & im26 == 1												// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6mmry,6667,9999) | inrange(im6mmrd,97,98))) | (inrange(im5,1,3) & (inrange(hf12mmry,6667,9999) | inrange(hf12mmrd,97,98))) | (im11 == 1 & inlist(im26,2,8)) | (inlist(im2,4,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}
		if inlist(country_name,"Algeria2018") {
			replace c_measles = 1 if c_measles == 0 & ((inrange(im3rory,2000,6666) | inlist(im3rord,44,66)) | (inrange(im6rory,2000,6666) | inlist(im6rord,44,66)) | (inrange(im6ror1y,2000,6666) | inlist(im6ror1d,44,66))) // measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & im26 == 1				// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im3rory,6667,9999) | inrange(im3rord,97,98)) & (inrange(im6rory,6667,9999) | inrange(im6rord,97,98)) & (inrange(im6ror1y,6667,9999) | inrange(im6ror1d,97,98)) ) | (im11 == 1 & inlist(im26,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}	


		if inlist(country_name,"SaoTomeAndPrincipe2019") {
			replace c_measles = 1 if c_measles == 0 & (inrange(im6my,2000,6666) | inlist(im6md,44,66))			// measles/MMR from card
			replace c_measles = 1 if c_measles == 0 & im26 == 1				// measles/MMR from memory
			replace c_measles = . if ((inrange(im5,1,3) & (inrange(im6my,6667,9999) | inrange(im6md,97,98) )) | (im11 == 1 & inlist(im26,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	// missing if measles DK/missing for card and memory
		}	

		
    * c_bcg: Child age 15-23M had BCG vaccination
	    gen c_bcg = .
		replace c_bcg = 0 if inrange(cage,15,23) & im2 != .                         // children aged 15-23 months	
		#delimit ;
		if 	country_name == "LaoPDR2017" | 
			country_name == "SierraLeone2017" |
			country_name == "Iraq2017" |
			country_name == "Gambia2018" |
		    country_name == "Lesotho2018" |
			country_name == "Madagascar2018" |
			country_name == "Zimbabwe2019" |
			country_name == "Ghana2017" |
			country_name == "Togo2017" |
			country_name == "Kiribati2018" |
			country_name == "CostaRica2018" |
			country_name == "Thailand2019" |
			country_name == "Serbia2019" |
			country_name == "Guinea-Bissau2018"|
			country_name == "StateofPalestine2019"|
			country_name == "Nepal2019" |
			country_name == "CentralAfricanRepublic2018"|
			country_name == "Cuba2019" |
			country_name == "Samoa2019" |
			country_name == "TurksCaicosIslands2019" |
            country_name == "NorthMacedonia2018" |
			country_name == "SaoTomeAndPrincipe2019" |
			country_name == "DominicanRepublic2019" |
			country_name == "Malawi2019" {;
	    #delimit cr		
		    replace c_bcg = 1 if c_bcg == 0 & (inrange(im6by,2000,6666) | inlist(im6bd,44,66))
			replace c_bcg = 1 if c_bcg == 0 & im14 == 1                             // BCG from memory
			replace c_bcg = . if ((inrange(im5,1,3) & (inrange(im6by,6667,9999) | inrange(im6bd,97,98))) | (im11 == 1 & inlist(im14,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	  // missing if BCG DK/missing for card and memory
		}
		if inlist(country_name,"Kosovo2019","Tonga2019") {
		    replace c_bcg = 1 if c_bcg == 0 & (inrange(im6by,2000,6666) | inlist(im6bd,44,66))
			replace c_bcg = 1 if c_bcg == 0 & (inrange(hf12by,2000,6666) | inlist(hf12bd,44,66))
			replace c_bcg = 1 if c_bcg == 0 & im14 == 1                             // BCG from memory
			replace c_bcg = . if ((inrange(im5,1,3) & (inrange(im6by,6667,9999) | inrange(im6bd,97,98))) | (im11 == 1 & inlist(im14,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	  // missing if BCG DK/missing for card and memory
		}
		if inlist(country_name,"KyrgyzRepublic2018","Mongolia2018","Congodr2017") {
		    replace c_bcg = 1 if c_bcg == 0 & (inrange(im6by,2000,6666) | inlist(im6bd,44,66) | inrange(hf12by,2000,6666) | inlist(hf12bd,44,66))
			replace c_bcg = 1 if c_bcg == 0 & im14 == 1                             // BCG from memory
			replace c_bcg = . if ((inrange(im5,1,3) & (inrange(im6by,6667,9999) | inrange(im6bd,97,98) | inrange(hf12by,6667,9999) | inrange(hf12bd,97,98) )) | (im11 == 1 & inlist(im14,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	  // missing if BCG DK/missing for card and memory
		}
		if inlist(country_name,"Tunisia2018") {
		    replace c_bcg = 1 if c_bcg == 0 & (inrange(im6by,2000,6666) | inlist(im6bd,44,66))
			replace c_bcg = 1 if c_bcg == 0 & (im14 == 1 | imp14 == 1 | impp14 == 1)                           // BCG from memory
			replace c_bcg = . if ((inrange(im5,1,3) & (inrange(im6by,6667,9999) | inrange(im6bd,97,98))) | (im11 == 1 & inlist(im14,8,9) & inlist(imp14,8,9) & inlist(impp14,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	  // missing if BCG DK/missing for card and memory
		}
		if inlist(country_name,"Chad2019") {
		    replace c_bcg = 1 if c_bcg == 0 & (inrange(im6by,2000,6666) | inlist(im6bd,44,66))
			replace c_bcg = 1 if c_bcg == 0 & im14corr == 1                         // BCG from memory
			replace c_bcg = . if ((inrange(im5,1,3) & (inrange(im6by,6667,9999) | inrange(im6bd,97,98))) | (im11 == 1 & inlist(im14corr,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	  // missing if BCG DK/missing for card and memory
		}		
		if inlist(country_name,"Algeria2018") {		
		    replace c_bcg = 1 if c_bcg == 0 & (inrange(im3by,2000,6666) | inlist(im3bd,44,66))
		    replace c_bcg = 1 if c_bcg == 0 & (inrange(im6by,2000,6666) | inlist(im6bd,44,66))
			replace c_bcg = 1 if c_bcg == 0 & im14 == 1                             // BCG from memory
			replace c_bcg = . if ((inrange(im5,1,3) & (inrange(im6by,6667,9999) | inrange(im6bd,97,98)) & (inrange(im3by,6667,9999) | inrange(im3bd,97,98))) | (im11 == 1 & inlist(im14,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9)))	  // missing if BCG DK/missing for card and memory
		}		
		if inlist(country_name,"Tuvalu2019","Honduras2019") {					
			replace c_bcg = 1 if c_bcg == 0 & (inrange(im6by,2000,6666) | inlist(im6bd,44,66))
			replace c_bcg = 1 if c_bcg == 0 & im14 == 1                             // BCG from memory
			replace c_bcg = . if ((inlist(im5,4,9) & (inrange(im6by,6667,9999) | inrange(im6bd,97,98))) | inlist(im14,2,8) | (inlist(im2,4,9) & inlist(im11,8,9)))	  // missing if BCG DK/missing for card and memory
		}
		if inlist(country_name,"Vietnam2020") {					
			replace c_bcg = 1 if c_bcg == 0 & (inrange(im6by,2000,6666) | inlist(im6bd,44,66) | inrange(hf12by,2000,6666) | inlist(hf12bd,44,66))
			replace c_bcg = 1 if c_bcg == 0 & im14 == 1                             // BCG from memory
			replace c_bcg = . if ((inlist(im5,4,9) & (inrange(im6by,6667,9999) | inrange(im6bd,97,98) |inrange(hf12by,6667,9999) | inrange(hf12bd,97,98))) | inlist(im14,2,8) | (inlist(im2,4,9) & inlist(im11,8,9)))	  // missing if BCG DK/missing for card and memory
		}
	
	* c_dpt1: Child age 15-23M had DPT1 or Pentavalent 1 vaccination
	* c_dpt2: Child age 15-23M had DPT2 or Pentavalent 2 vaccination
	* c_dpt3: Child age 15-23M had DPT3 or Pentavalent 3 vaccination

	forvalues x = 1 2 to 3 {
			gen c_dpt`x' = . 
			replace c_dpt`x' = 0 if inrange(cage,15,23) & im2 != . 
			
		#delimit ;
		if 	country_name == "LaoPDR2017" | 
			country_name == "SierraLeone2017" |
			country_name == "Gambia2018" |
		    country_name == "Lesotho2018" |
			country_name == "Madagascar2018" |
			country_name == "Zimbabwe2019" |
			country_name == "Ghana2017" |
			country_name == "Togo2017" |
			country_name == "Kiribati2018" |
			country_name == "CostaRica2018" |
			country_name == "Guinea-Bissau2018" |
			country_name == "Chad2019" |
			country_name == "Algeria2018" |
			country_name == "StateofPalestine2019"|
			country_name == "Nepal2019"|
			country_name == "Samoa2019"|
			country_name == "TurksCaicosIslands2019"|
			country_name == "CentralAfricanRepublic2018"|
			country_name == "SaoTomeAndPrincipe2019"|
			country_name == "Honduras2019" |
			country_name == "Malawi2019" {;
	    #delimit cr		
			    replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6penta`x'y,2000,6666) | inlist(im6penta`x'd,44,66))
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & im20 == 1 & inrange(im21,`x',7)               // dpt1-3 from memory
				replace c_dpt`x' = . if ((inrange(im5,1,3) & (inrange(im6penta`x'y,6667,9999) | inrange(im6penta`x'd,97,98))) | (im11 == 1 & (inlist(im20,8,9) | inlist(im21,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if DPT1-3 DK/missing for card and memory
			}

            if inlist(country_name,"Tuvalu2019") {
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6penta`x'y,2000,6666) | inlist(im6penta`x'd,44,66))
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & im20 == 1 & inrange(im21,`x',7)               // dpt1-3 from memory
				replace c_dpt`x' = . if ((inrange(im5,4,9) & (inrange(im6penta`x'y,6667,9999) | inrange(im6penta`x'd,97,98))) | (inlist(im20,2,8) | inlist(im21,8)))|(inlist(im2,4,9) )) // missing if DPT1-3 DK/missing for card and memory
			}
			
			if inlist(country_name,"Iraq2017") {
			    replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6hexa`x'y,2000,6666) | inlist(im6hexa`x'd,44,66))
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & im20 == 1 & inrange(im21,`x',7)               // dpt1-3 from memory
				replace c_dpt`x' = . if ((inrange(im5,1,3) & (inrange(im6hexa`x'y,6667,9999) & inrange(im6hexa`x'd,97,98))) | (im11 == 1 & (inlist(im20,8,9) | inlist(im21,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if DPT1-3 DK/missing for card and memory
			}
			if inlist(country_name,"KyrgyzRepublic2018","Mongolia2018","Congodr2017","Tonga2019"){
			    replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6penta`x'y,2000,6666) | inlist(im6penta`x'd,44,66) | inrange(hf12penta`x'y,2000,6666) | inlist(hf12penta`x'd,44,66))
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & im20 == 1 & inrange(im21,`x',7)               // dpt1-3 from memory
				replace c_dpt`x' = . if ((inrange(im5,1,3) & (inrange(im6penta`x'y,6667,9999) | inrange(im6penta`x'd,97,98) | inrange(hf12penta`x'y,6667,9999) | inrange(hf12penta`x'd,97,98))) | (im11 == 1 & (inlist(im20,8,9) | inlist(im21,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if DPT1-3 DK/missing for card and memory
			}		
			if inlist(country_name,"Tunisia2018") {
			    replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6penta`x'y,2000,6666) | inlist(im6penta`x'd,44,66) | impp20a == 1 | imp20b == 1 | inrange(im6pentaxim`x'y,2000,6666) | inlist(im6pentaxim`x'd,44,66))
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & im20 == 1 & (inrange(im21,`x',7) | inrange(impp21a,`x',7) | inrange(imp21b ,`x',7))              // dpt1-3 from memory
				replace c_dpt`x' = . if ((inrange(im5,1,3) & (inrange(im6penta`x'y,6667,9999) | inrange(im6penta`x'd,97,98))) | (im11 == 1 & (inlist(im20,8,9) | inlist(im21,8,9) | inlist(impp21a ,8,9) | inlist(imp21b,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if DPT1-3 DK/missing for card and memory
			}	
			if inlist(country_name,"Thailand2019") {
			    replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6dtp`x'y,2000,6666) | inlist(im6dtp`x'd,44,66))
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & im29 == 1 & inrange(im30,`x',7)               // dpt1-3 from memory
				replace c_dpt`x' = . if ((inrange(im5,1,3) & (inrange(im6dtp`x'y,6667,9999) & inrange(im6dtp`x'd,97,98))) | (im11 == 1 & (inlist(im29,8,9) | inlist(im30,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if DPT1-3 DK/missing for card and memory
			}			
			
			if inlist(country_name,"NorthMacedonia2018") {
			    replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6dtp`x'y,2000,6666) | inlist(im6dtp`x'd,44,66)) // with response, marked on card, mother reported
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & im20 == 1 &inrange(im21,`x',7)   // dpt1-3 from memory
				replace c_dpt`x' = . if ((inrange(im5,1,3) & (inrange(im6dtp`x'y,6667,9999) & inrange(im6dtp`x'd,97,98))) | (im11 == 1 & (inlist(im20,8,9) | inlist(im21,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9)))
			}
			
			if inlist(country_name,"Serbia2019") {
			    replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6dtp`x'y,2000,6666) | inlist(im6dtp`x'd,44,66))
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(hf12dtp`x'y,2000,6666) | inlist(hf12dtp`x'd,44,66))
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6dtpr1y,2000,6666) | inlist(im6dtpr1d,44,66))
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(hf12dtpr1y,2000,6666) | inlist(hf12dtpr1d,44,66))
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & im21e == 1 & inrange(im21f,`x',7)               // dpt1-3 from memory
				replace c_dpt`x' = . if ((inrange(im5,1,3) & (inrange(im6dtp`x'y,6667,9999) & inrange(im6dtp`x'd,97,98))) | (inrange(im5,1,3) & (inrange(hf12dtp`x'y,6667,9999) & inrange(hf12dtp`x'd,97,98))) | (inrange(im5,1,3) & (inrange(im6dtpr1y,6667,9999) & inrange(im6dtpr1d,97,98))) | (inrange(im5,1,3) & (inrange(hf12dtpr1y,6667,9999) & inrange(hf12dtpr1d,97,98))) | (im11 == 1 & (inlist(im21e,8,9) | inlist(im21f,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if DPT1-3 DK/missing for card and memory
			}	

      
	   if inlist(country_name,"Kosovo2019") {
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6penta`x'y,2000,6666) | inlist(im6penta`x'd,44,66))
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6penta`x'`x'y,2000,6666) | inlist(im6penta`x'`x'd,44,66))
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6dtp`x'y,2000,6666) | inlist(im6dtp`x'd,44,66))
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(hf12penta`x'y,2000,6666) | inlist(hf12penta`x'd,44,66))
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(hf12penta`x'`x'y,2000,6666) | inlist(hf12penta`x'`x'd,44,66))
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(hf12dtp`x'y,2000,6666) | inlist(hf12dtp`x'd,44,66))
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & im20a == 1 & inrange(im20b,`x',7)               // dpt1-3 from memory
			replace c_dpt`x' = . if ((inrange(im5,1,3) & (inrange(im6penta`x'y,6667,9999) | inrange(im6penta`x'd,97,98)))| (inrange(im5,1,3) & (inrange(im6penta`x'`x'y,6667,9999) | inrange(im6penta`x'`x'd,97,98))) | (im11 == 1 & (inlist(im20a,8,9) | inlist(im20b,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if DPT1-3 DK/missing for card and memory
			}

		if inlist(country_name,"Vietnam2020") {
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6dpt`x'y,2000,6666) | inlist(im6dpt`x'd,44,66))
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(hf12dpt`x'y,2000,6666) | inlist(hf12dpt`x'd,44,66))
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & im20 == 1 & inrange(im21,`x',7)               // dpt1-3 from memory
			replace c_dpt`x' = . if ((inrange(im5,1,3) & (inrange(im6dpt`x'y,6667,9999) | inrange(im6dpt`x'd,97,98)))| (inrange(im5,1,3) & (inrange(hf12dpt`x'y,6667,9999) | inrange(hf12dpt`x'd,97,98))) | (im11 == 1 & (inlist(im20,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if DPT1-3 DK/missing for card and memory
			}
			
			if inlist(country_name,"Cuba2019") {
			    replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6pe`x'y,2000,6666) | inlist(im6pe`x'd,44,66))
				replace c_dpt`x' = 1 if c_dpt`x' == 0 & im20 == 1 & inrange(im21,`x',7)               // dpt1-3 from memory
				replace c_dpt`x' = . if ((inrange(im5,1,3) & (inrange(im6pe`x'y,6667,9999) | inrange(im6pe`x'd,97,98))) | (im11 == 1 & (inlist(im20,8,9) | inlist(im21,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if DPT1-3 DK/missing for card and memory
			}
			
	   if inlist(country_name,"DominicanRepublic2019") {
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6penta`x'y,2000,6666) | inlist(im6penta`x'd,44,66))
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & (inrange(im6d`x'y,2000,6666) | inlist(im6d`x'd,44,66))
			replace c_dpt`x' = 1 if c_dpt`x' == 0 & im20 == 1 & inrange(im21,`x',7)               // dpt1-3 from memory
			replace c_dpt`x' = . if ((inrange(im5,1,3) & (inrange(im6penta`x'y,6667,9999) | inrange(im6penta`x'd,97,98)))| (inrange(im5,1,3) & (inrange(im6d`x'y,6667,9999) | inrange(im6d`x'd,97,98))) | (im11 == 1 & (inlist(im20,8,9) | inlist(im21,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if DPT1-3 DK/missing for card and memory
			}			
	}
	 
	

	* c_polio1: Child age 15-23M received polio1/OPV1 vaccination
	* c_polio2: Child age 15-23M received polio2/OPV2 vaccination
	* c_polio3: Child age 15-23M received polio3/OPV3 vaccination
	// first two week after birth = at birth
    if inlist(country_name,"Suriname2018", "CostaRica2018","Tonga2019") {
		    rename im6i*d im6p*d
			rename im6i*m im6p*m
			rename im6i*y im6p*y
		}

		forvalues x = 1 2 to 3 {
			gen c_polio`x' = . 
			replace c_polio`x' = 0 if inrange(cage,15,23) & im2 != . 
			
			// RW 10.17 Review, remove Cuba2019 from list, due to Cuba's unique vaccination regime that incorporated 8 rounds of injection according to survey raw data. The majority of observations had 6-8 completed shots of polio. See im6p`x'y. Action: Created a loop that coped with this with x = 4 5 to 8
			if inlist(country_name,"LaoPDR2017","Suriname2018","Zimbabwe2019","NorthMacedonia2018","Cuba2019","Honduras2019","Malawi2019") {
			    replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6p`x'y,2000,6666) | inlist(im6p`x'd,44,66))
				replace c_polio`x' = 1 if c_polio`x' == 0 & im16 == 1 & inrange(im18,`x',7)          // polio1-3 from memory
				replace c_polio`x' = . if ((inrange(im5,1,3) & (inrange(im6p`x'y,6667,9999) | inrange(im6p`x'd,97,98))) | (im11 == 1 & (inlist(im16,8,9) | inlist(im18,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if Polio1-3 DK/missing for card and memory
		    }
			//RW0831 Guinea-Bissau2018 might benefit from sensitivity test with regard to the use of im19 as for CostaRica2018
		   if inlist(country_name,"Guinea-Bissau2018") {
		       replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6p`x'y,2000,6666) | inlist(im6p`x'd,44,66))
		       replace c_polio`x' = 1 if c_polio`x' == 0 & im16 == 1 & ((im17 == 2 & inrange(im18,`x',7)) | inrange(im18,`x'+1,7))   // polio1-3 from memory
			   replace c_polio`x' = . if ((inrange(im5,1,3) & (inrange(im6p`x'y,6667,9999) | inrange(im6p`x'd,97,98))) | (im11 == 1 & (inlist(im16,8,9) | inlist(im17,8,9) | inlist(im18,8,9))) | (inlist(im2,8,9) & inlist(im11,8,9))) // missing if Polio1-3 DK/missing for card and memory
		   }
		   if inlist(country_name,"SierraLeone2017","Iraq2017","Gambia2018","Lesotho2018","Madagascar2018","Ghana2017","Togo2017","Kiribati2018","Thailand2019")|inlist(country_name,"StateofPalestine2019","Nepal2019","Algeria2018","CentralAfricanRepublic2018","SaoTomeAndPrincipe2019","Samoa2019")  {
		       replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6p`x'y,2000,6666) | inlist(im6p`x'd,44,66))
		       replace c_polio`x' = 1 if c_polio`x' == 0 & im16 == 1 & ((im17 == 2 & inrange(im18,`x',7)) | inrange(im18,`x'+1,7))   // polio1-3 from memory
			   replace c_polio`x' = . if ((inrange(im5,1,3) & (inrange(im6p`x'y,6667,9999) | inrange(im6p`x'd,97,98))) | (im11 == 1 & (inlist(im16,8,9) | inlist(im17,8,9) | inlist(im18,8,9))) | (inlist(im2,8,9) & inlist(im11,8,9))) // missing if Polio1-3 DK/missing for card and memory
		   }
		   
		   if inlist(country_name,"KyrgyzRepublic2018","Mongolia2018", "Congodr2017","Tonga2019") {
		       replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6p`x'y,2000,6666) | inlist(im6p`x'd,44,66) | inrange(hf12p`x'y,2000,6666) | inlist(hf12p`x'd,44,66))
		       replace c_polio`x' = 1 if c_polio`x' == 0 & im16 == 1 & ((im17 == 2 & inrange(im18,`x',7)) | inrange(im18,`x'+1,7))   // polio1-3 from memory
			   replace c_polio`x' = . if ((inrange(im5,1,3) & (inrange(im6p`x'y,6667,9999) | inrange(im6p`x'd,97,98) | inrange(hf12p`x'y,6667,9999) | inrange(hf12p`x'd,97,98))) | (im11 == 1 & (inlist(im16,8,9) | inlist(im17,8,9) | inlist(im18,8,9))) | (inlist(im2,8,9) & inlist(im11,8,9))) // missing if Polio1-3 DK/missing for card and memory
		   }	
			if inlist(country_name,"Tunisia2018") {
			    replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6vpo`x'y,2000,6666) | inlist(im6vpo`x'd,44,66)) // count opv1-3 as polio1-3
				replace c_polio`x' = 1 if c_polio`x' == 0 & ((im16 == 1 & inrange(im18,`x',7)) | (impp16 == 1 & inrange(impp18,`x',7)))         // polio1-3 from memory
				replace c_polio`x' = . if ((inrange(im5,1,3) & (inrange(im6vpo`x'y,6667,9999) | inrange(im6vpo`x'd,97,98))) | (im11 == 1 & (inlist(im16,8,9) | inlist(im18,8,9) | inlist(impp16,8,9) | inlist(impp18,8,9)))|(inlist(im2,8,9) & inlist(im11,8,9))) // missing if Polio1-3 DK/missing for card and memory
		    }	
			if inlist(country_name,"CostaRica2018","TurksCaicosIslands2019") {
			    replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6p`x'y,2000,6666) | inlist(im6p`x'd,44,66))
				replace c_polio`x' = 1 if c_polio`x' == 0 & im19 == 1       // polio1-3 from memory
				replace c_polio`x' = . if ((inrange(im5,1,3) & (inrange(im6p`x'y,6667,9999) | inrange(im6p`x'd,97,98))) | (im11 == 1 & inlist(im19,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9))) // missing if Polio1-3 DK/missing for card and memory
		   }
		   	if inlist(country_name,"Chad2019") {
		       replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6p`x'y,2000,6666) | inlist(im6p`x'd,44,66))
		       replace c_polio`x' = 1 if c_polio`x' == 0 & im16corr == 1 & ((im17corr == 2 & inrange(im18corr,`x',7)) | inrange(im18corr,`x'+1,7))   // polio1-3 from memory
			   replace c_polio`x' = . if ((inrange(im5,1,3) & (inrange(im6p`x'y,6667,9999) | inrange(im6p`x'd,97,98))) | (im11 == 1 & (inlist(im16corr,8,9) | inlist(im17corr,8,9) | inlist(im18corr,8,9))) | (inlist(im2,8,9) & inlist(im11,8,9))) // missing if Polio1-3 DK/missing for card and memory
		   }
			if inlist(country_name,"Serbia2019") {
			  replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6opv`x'y,2000,6666) | inlist(im6opv`x'd,44,66))
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6ipv`x'y,2000,6666) | inlist(im6ipv`x'd,44,66))
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6ipvr1y,2000,6666) | inlist(im6ipvr1d,44,66))
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6opvr1y,2000,6666) | inlist(im6opvr1d,44,66))
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(hf12opv`x'y,2000,6666) | inlist(hf12opv`x'd,44,66))
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(hf12ipv`x'y,2000,6666) | inlist(hf12ipv`x'd,44,66))
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(hf12ipvr1y,2000,6666) | inlist(hf12ipvr1d,44,66))
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(hf12opvr1y,2000,6666) | inlist(hf12opvr1d,44,66))
				replace c_polio`x' = 1 if c_polio`x' == 0 & im11 == 1 & ((im21ba == 1 & inrange(im21d,`x',7)) | (im21bb == 1 & inrange(im21d,`x',7)))   // polio1-3 from memory
				replace c_polio`x' = . if ((inrange(im5,1,3) & (inrange(im6opv`x'y,6667,9999) | inrange(im6opv`x'd,97,98))) | (inrange(im5,1,3) & (inrange(im6ipv`x'y,6667,9999) | inrange(im6ipv`x'd,97,98))) | (inrange(im5,1,3) & (inrange(hf12opv`x'y,6667,9999) | inrange(hf12opv`x'd,97,98))) | (inrange(im5,1,3) & (inrange(hf12ipv`x'y,6667,9999) | inrange(hf12ipv`x'd,97,98))) | (inrange(im5,1,3) & (inrange(im6opvr1y,6667,9999) | inrange(im6opvr1d,97,98))) | (inrange(im5,1,3) & (inrange(im6ipvr1y,6667,9999) | inrange(im6ipvr1d,97,98))) | (inrange(im5,1,3) & (inrange(hf12opvr1y,6667,9999) | inrange(hf12opvr1d,97,98))) | (inrange(im5,1,3) & (inrange(hf12ipvr1y,6667,9999) | inrange(hf12ipvr1d,97,98))) | (im11 == 1 & inlist(im21ba,8,9)) | (im11 == 1 & inlist(im21bb,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9))) // missing if Polio1-3 DK/missing for card and memory
		   }		   

			if inlist(country_name,"Kosovo2019") {
			    replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6opv`x'y,2000,6666) | inlist(im6opv`x'd,44,66)) // opv immunization
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6ipv`x'y,2000,6666) | inlist(im6ipv`x'd,44,66)) // ipv immunization
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6penta`x'`x'y,2000,6666) | inlist(im6penta`x'`x'd,44,66)) // ipv immunization with other vax
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(hf12opv`x'y,2000,6666) | inlist(hf12opv`x'd,44,66)) 
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(hf12ipv`x'y,2000,6666) | inlist(hf12ipv`x'd,44,66)) 
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(hf12penta`x'`x'y,2000,6666) | inlist(hf12penta`x'`x'd,44,66)) 
				replace c_polio`x' = 1 if c_polio`x' == 0 & im16a == 1      
				replace c_polio`x' = . if ((inrange(im5,1,3) & (inrange(im6opv`x'y,6667,9999) | inrange(im6opv`x'd,97,98))) | (inrange(im5,1,3) & (inrange(im6ipv`x'y,6667,9999) | inrange(im6ipv`x'd,97,98))) | (inrange(im5,1,3) & (inrange(im6penta`x'`x'y,6667,9999) | inrange(im6penta`x'`x'd,97,98))) | (im11 == 1 & inlist(im16a,8,9)) | (inlist(im2,8,9) & inlist(im11,8,9))) // missing if Polio1-3 DK/missing for card and memory
		   }
		   
		   if inlist(country_name,"Tuvalu2019") {
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6ipv`x'y,2000,6666) | inlist(im6ipv`x'd,44,66)) // ipv immunization
				replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6penta`x'`x'y,2000,6666) | inlist(im6penta`x'`x'd,44,66)) // ipv immunization with other vax
				replace c_polio`x' = 1 if c_polio`x' == 0 & im16 == 1 & (inrange(im18,`x',7)) | inrange(im18,`x'+1,7)   // polio1-3 from memory
			   replace c_polio`x' = . if ((inrange(im5,4,9) & (inrange(im6ipv`x'y,6667,9999) | inrange(im6ipv`x'd,97,98))) | (inlist(im16,2,8)) | (inlist(im2,4,9))) // missing if Polio1-3 DK/missing for card and memory
		   }
		   if inlist(country_name,"Vietnam2020") {

		       replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6p`x'y,2000,6666) | inrange(im6i`x'y,2000,6666) | inlist(im6p`x'd,44,66) | inlist(im6i`x'd,44,66) | inrange(hf12p`x'y,2000,6666) | inrange(hf12i`x'y,2000,6666) |  inlist(hf12p`x'd,44,66) | inlist(hf12i`x'd,44,66))

		       replace c_polio`x' = 1 if c_polio`x' == 0 & im16 == 1 & (inrange(im18,`x',7) | inrange(im18,`x'+1,7) | im19 == 1)   // polio1-3 from memory
				   		  
			   replace c_polio`x' = . if ((inrange(im5,1,3) & (inrange(im6p`x'y,6667,9999) | inrange(im6i`x'y,6667,9999) | inrange(im6p`x'd,97,98) | inrange(im6i`x'd,97,98) | inrange(hf12p`x'y,6667,9999) | inrange(hf12i`x'y,6667,9999) | inrange(hf12p`x'd,97,98) | inrange(hf12i`x'd,97,98))) | (im11 == 1 & (inlist(im16,8,9) | inlist(im18,8,9))) | (inlist(im2,8,9) & inlist(im11,8,9)))  	// missing if Polio1-3 DK/missing for card and memory
		   }	
		   if inlist(country_name,"DominicanRepublic2019") {
		       replace c_polio`x' = 1 if c_polio`x' == 0 & (inrange(im6p`x'y,2000,6666) | inlist(im6p`x'd,44,66) | inrange(im6i`x'y,2000,6666) | inlist(im6i`x'd,44,66))
		       replace c_polio`x' = 1 if c_polio`x' == 0 & im16 == 1 & (inrange(im18,`x',7) | inrange(im18,`x'+1,7))   // polio1-3 from memory
			   replace c_polio`x' = . if ((inrange(im5,1,3) & (inrange(im6p`x'y,6667,9999) | inrange(im6p`x'd,97,98) | inrange(im6i`x'y,6667,9999) | inrange(im6i`x'd,97,98))) | (im11 == 1 & (inlist(im16,8,9) | inlist(im18,8,9))) | (inlist(im2,8,9) & inlist(im11,8,9))) // missing if Polio1-3 DK/missing for card and memory
		   }			   
		   
		}

    * c_fullimm: Child age 15-23M had BCG, polio 1-3, DTP/Penta1-3 & measles/MMR (1/0)
	    gen c_fullimm = .
			
		if ~inlist(country_name,"Suriname2018","Georgia2018","Bangladesh2019","Montenegro2018","Cuba2019") {
		     replace c_fullimm = 1 if c_bcg == 1 & c_polio1 == 1 & c_polio2 == 1 & c_polio3 == 1 & c_dpt1 == 1 & c_dpt2 == 1 & c_dpt3 == 1 & c_measles == 1
		     replace c_fullimm = 0 if c_bcg == 0 | c_polio1 == 0 | c_polio2 == 0 | c_polio3 == 0 | c_dpt1 == 0 | c_dpt2 == 0 | c_dpt3 == 0 | c_measles == 0
	         replace c_fullimm = . if ~inrange(cage,15,23)
		}
		
	* c_vaczero: Child did not receive any vaccination		
		gen c_vaczero = (c_measles == 0 & c_polio1 == 0 & c_polio2 == 0 & c_polio3 == 0 & c_bcg == 0 & c_dpt1 == 0 & c_dpt2 == 0 & c_dpt3 == 0)
		foreach var in c_measles c_polio1 c_polio2 c_polio3 c_bcg c_dpt1 c_dpt2 c_dpt3{
			replace c_vaczero = . if `var' == .
		}					
	label define l_vaczero 1 "Did not receive any vaccination"
	label values c_vaczero l_vaczero		
		
		
