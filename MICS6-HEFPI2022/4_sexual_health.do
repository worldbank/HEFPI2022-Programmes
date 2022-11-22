///// Batch MICS6-dofiles
//Do-file for the indicator:
/// w_condom_conc
/// w_CPR
/// w_unmet_fp
/// w_need_fp
/// w_metany_fp
/// w_metmod_fp
/// w_metany_fp_q
/// w_married


* w_condom_conc: Condom use of at-risk women age 18-49
		cap gen sb7 = .		// creates empty sexual intercourse variables in surveys which do not have the module (to make code run smoothly) 
		cap gen sb3 = .		 
		gen w_condom_conc = .
		replace w_condom_conc = 0 if sb7 == 1 & sb3 < 8	& inrange(wb4,18,49)	// women with > 1 sexual partner over last year
		replace w_condom_conc = 1 if sb3 == 1 & w_condom_conc == 0			// used condom in last intercourse

* w_CPR: Use of modern contraceptive methods of women age 15(!)-49 married or living in union
		gen w_CPR = .
		
		if ~inlist(country_name,"Zimbabwe2019") {
			replace w_CPR = 0 if inrange(wb4,15,49) & mstatus == 1            	     // women age 15-49 married or in union
		

			if inlist(country_name,"LaoPDR2017","Suriname2018","Lesotho2018","Georgia2018","Montenegro2018","CostaRica2018","Belarus2019","Chad2019","StateofPalestine2019")|inlist(country_name,"Nepal2019","Cuba2019","Serbia2019","Algeria2018","Turkmenistan2019","NorthMacedonia2018","TurksCaicosIslands2019") {
				global cp4 "cp4a cp4b cp4c cp4d cp4e cp4f cp4g cp4h cp4i cp4j"
			}
			
			#delimit ;
		if 	country_name == "SierraLeone2017" | 
			country_name == "Iraq2017" |
			country_name == "Mongolia2018" |
			country_name == "Gambia2018" |
		    country_name == "Tunisia2018" |
			country_name == "Madagascar2018" |
			country_name == "Bangladesh2019" |
			country_name == "Congodr2017" |
			country_name == "Ghana2017" |
			country_name == "Togo2017"|
			country_name == "CentralAfricanRepublic2018"|
			country_name == "SaoTomeAndPrincipe2019" |
			country_name == "Malawi2019" {;
	    #delimit cr 
				global cp4 "cp4a cp4b cp4c cp4d cp4e cp4f cp4g cp4h cp4i cp4j cp4k"
			}
			if inlist(country_name,"KyrgyzRepublic2018") {
				global cp4 "cp4a cp4b cp4c cp4d cp4f cp4g cp4h cp4i cp4j cp4n"
			}
			if inlist(country_name,"Kiribati2018") {
				global cp4 "cp4a cp4b cp4c cp4d cp4e cp4f cp4g cp4h cp4i cp4n cp4p"
			}
			if inlist(country_name,"Thailand2019") {
				global cp4 "cp4a cp4b cp4c cp4d cp4e cp4f cp4g cp4h cp4i cp4n cp4j cp4o"
			}
			if inlist(country_name,"Tonga2019","Honduras2019","DominicanRepublic2019") {
				global cp4 "cp4a cp4b cp4c cp4d cp4e cp4f cp4g cp4h cp4i cp4j"
			}			
			if inlist(country_name,"Guinea-Bissau2018") {
				global cp4 "cp4a cp4b cp4c cp4d cp4e cp4f cp4g cp4h cp4i cp4j cp4k cp4l"
			}
			if inlist(country_name,"Kosovo2019"){
				global cp4 "cp4a cp4b cp4c cp4d cp4e cp4f cp4g cp4h cp4i cp4j cp4n"
			}
			if inlist(country_name,"Samoa2019"){
				global cp4 "cp4a cp4b cp4c cp4d cp4e cp4f cp4g cp4h cp4k cp4l cp4m cp4n cp4x"
			}
			if inlist(country_name,"Tuvalu2019"){
				global cp4 "cp4a cp4b cp4d cp4e cp4f cp4g cp4h cp4i cp4k"
			}
			if inlist(country_name,"Vietnam2020"){
				global cp4 "cp4a cp4b cp4c cp4d cp4e cp4f cp4g cp4h cp4i cp4k"
			}
			if inlist(country_name,"Argentina2019"){
				global cp4 "cp4a cp4b cp4c cp4d cp4e cp4f cp4g cp4h cp4i cp4j cp4k cp4n cp4o cp4p"
			}
			
		
			foreach var in $cp4 {
			    cap clonevar `var'_old = `var'
				if _rc {
					cap drop `var'_old
					gen `var'_old = `var'
					/*Accommodate Madagascar's long and irregular labels*/
				}
				
				replace `var' = "" if `var' == " "
				replace `var' = "0" if `var'== ""
				replace `var' = "" if  `var' == "?" // missing for DK/missing if no other modern method used
				replace `var' = "1" if `var' != "" & `var' != "0" // 1 for modern method
				destring `var', replace
			}	
            
			egen temp_cp4_tot = rowtotal($cp4) if w_CPR == 0,mi
	
			replace w_CPR = 1 if temp_cp4_tot >= 1 & w_CPR == 0
			replace w_CPR = . if temp_cp4_tot == . 
					
			drop temp_cp4_tot
			

// postpartum amenorrheic: if she had a birth in last two years and is not currently pregnant, and her menstrual period has not returned since the birth of the last child
		gen pregPPA = .
		cap gen mn35 = .
		replace pregPPA = 0 if inrange(wb4,15,49) & mstatus == 1  
		replace pregPPA = 1 if  pregPPA == 0 & bl2 == 1 & cp1 != 1 & (mn35 == 2 | un12f == "F")

		replace pregPPA = . if cp1 == 9 | mn35 == 9 | un12f == "?"

// infecund 
// if she is neither pregnant (CP1<>1) nor postpartum amenorrheic, and:
		***(1) (a) has not had menstruation for at least six months, (b) never menstruated, (c) her last menstruation occurred before her last birth, or (d) is in menopause or has had hysterectomy (UN14>6 months or UN14=993 or UN14=994 or UN14=995)
		***(2) She declares that she has had hysterectomy, or that she has never menstruated or that she is menopausal, or that she has been trying to get pregnant for 2 or more years without result in response to questions on why she thinks she is not physically able to get pregnant at the time of survey (UN12="B" OR UN12="C" or UN12="D" or UN12="E")
		***(3) She declares she cannot get pregnant when asked about desire for future birth (UN7 = 3 or UN8 = 994)
		***(4) She has not had a birth in the preceding 5 years (WM6-BH4 (most recent birth)>5 years), never used contraception (CP3<>1) and is currently married/in union and was continuously married/in union during the last 5 years (MA1=1 or 2 and MA7=1 and WM6-MA8>5 years or WB2-MA11>5). This condition can only be checked for women married/in union only once, as the Marriage Module only allows computation of period since first marriage/union.

		
		gen infec = .
		replace infec = 0 if inrange(wb4,15,49) & mstatus == 1 
		replace infec = 1 if infec == 0 & cp1 != 1 & pregPPA != 1 & ((un14u == 3 & un14n > 6) | un14u == 4 | inrange(un14n,93,95) | un12b == "B" | un12c == "C" | un12d == "D" | un12e == "E" | un7 == 3 | un8n == 94)

		if ~inlist(country_name,"Georgia2018","Tunisia2018","Montenegro2018","Belarus2019","CostaRica2018","Thailand2019","Serbia2019","Cuba2019","Argentina2019") {		
			replace infec = 1 if infec == 0 & cp1 != 1 & pregPPA != 1 & cp3 != 1 & wm6y-bh4y_last > 5 & inlist(ma1,1,2) & (ma7 == 1 & (wm6y - ma8y > 5 | wb4 - ma11 > 5))
		}  

		else {		
			replace infec = 1 if infec == 0 & cp1 != 1 & pregPPA != 1 & cp3 != 1 & wdoi - wdoblc > 60 & inlist(ma1,1,2) & (ma7 == 1 & (wm6y - ma8y > 5 | wb4 - ma11 > 5))
		}   
		replace infec = .  if cp1 == 9 | cp3 == 9 | un14n == 99 | un12b == "?" | un12c == "?" | un12d == "?" | un12e == "?" | un7 == 9 | un8n == 99

		
		
// Unmet need for spacing is defined as the percentage of women who are not using a method of contraception (CP2<>1), and:
		***(a) are pregnant (CP1=1) and say that the pregnancy was mistimed and would have wanted to wait (CP1=1 and UN4=1)
		***(b) are postpartum amenorrheic (had a birth in last two years (WM6-BH4 (most recent birth)>2 years) and is not currently pregnant (CP1<>1), and whose menstrual period has not returned since the birth of the last child (MN35=2))) and say that the birth was mistimed: would have wanted to wait (DB4=1)
		***(c) are not pregnant and not postpartum amenorrheic and are fecund and say they want to wait two or more years for their next birth (UN8>=2 years) OR
		***(d) are not pregnant and not postpartum amenorrheic and are fecund and unsure whether they want another child (UN7=8) 

		gen unmet_spc = . 

		replace unmet_spc = 0 if inrange(wb4,15,49) & mstatus == 1
		replace unmet_spc = 1 if unmet_spc == 0 & (cp2 != 1 & cp1 == 2 & pregPPA != 1 & infec != 1 & ((un8u == 2 & un8n > 1) | un7 == 8))
		replace unmet_spc = 1 if unmet_spc == 0 & (cp2 != 1 & cp1 == 1 & un4 == 1)
		replace unmet_spc = 1 if unmet_spc == 0 & (cp2 != 1 & pregPPA == 1 & db4 == 1)
		replace unmet_spc = . if cp1 == 9 | cp2 == 9 | un8n == 99 | un7 == 9 | un4 == 9 | db2 == 9 | db4 == 9


		
// Unmet need for limiting is defined as the percentage of women who are not using a method of contraception (CP2<>1) and:
		***(a) are not pregnant and not postpartum amenorrheic and are fecund and say they do not want any more children (UN7=2), 
		***(b) are pregnant (CP1=1) and say they didn't want to have a child (UN4=2), or
		***(c) are postpartum amenorrheic and say that they didn't want the birth: (DB2=2).

		gen unmet_lim = . 

		replace unmet_lim = 0 if inrange(wb4,15,49) & mstatus == 1 
		replace unmet_lim = 1 if unmet_lim == 0 & cp2 != 1 & cp1 != 1 & pregPPA != 1 & infec != 1 & un7 == 2
		replace unmet_lim = 1 if unmet_lim == 0 & cp2 != 1 & cp1 == 1 & un4 == 2
		replace unmet_lim = 1 if unmet_lim == 0 & cp2 != 1 & pregPPA == 1 & db2 == 2
		replace unmet_lim = . if cp1 == 9 | cp2 == 9 | un7 == 9 | un4 == 9 | db2 == 9

		
* w_unmet_fp: Unmet need for contraception, percentage of fecund women who are married or in union and are not using any method of contraception, but who wish to postpone the next birth (spacing) or who wish to stop childbearing altogether (limiting).

		gen w_unmet_fp = .
		
		replace w_unmet_fp = 0 if inrange(wb4,15,49) & mstatus == 1
		replace w_unmet_fp = 1 if w_unmet_fp == 0 & (unmet_spc == 1 | unmet_lim == 1)
		replace w_unmet_fp = . if unmet_spc == . | unmet_lim == .
	
		

// Contraceptive users (women with met need) are further divided into the following two categories:
		***(1) Met need for limiting includes women who are using a contraceptive method (CP2=1) and (a) who want no more children (UN7=2), (b) are using male or female sterilization (CP4="A" or "B"), or (c) declare themselves as infecund (UN7=3 or UN8=994). 
		***(2) Met need for spacing includes women who are using a contraceptive method (CP2=1) and (a) who want to have another child (UN7=1) or (b) undecided whether to have another child (UN7=8). 
		
		gen met_lim = .
		
		replace met_lim = 0 if inrange(wb4,15,49) & mstatus == 1		
		replace met_lim = 1 if met_lim == 0 & cp2 == 1 & (un7 == 2 | (cp4a_old == "A" | cp4b_old == "B") | (un7 == 3 | un8n == 94))
		replace met_lim = . if cp2 == 9 | un7 == 9 | cp4a_old == "?" | cp4b_old == "?" | un8n == 99

		gen met_spc = .
		
		replace met_spc = 0 if inrange(wb4,15,49) & mstatus == 1
		replace met_spc = 1 if met_spc == 0 & cp2 == 1 & (un7 == 1 | un7 == 8)
		replace met_spc = . if cp2 == 9 | un7 == 9
		
		gen met = .
		
		replace met = 0 if inrange(wb4,15,49) & mstatus == 1
		replace met = 1 if met == 0 & (met_spc == 1 | met_lim == 1)
		replace met = . if met_spc == . | met_lim == .
		


* w_need_fp: 15-49y married or in union with need for family planning (1/0)
		
		gen w_need_fp = .
		
		replace w_need_fp = 0 if inrange(wb4,15,49) & mstatus == 1
		replace w_need_fp = 1 if w_need_fp == 0 & (w_unmet_fp == 1 | met == 1)
		replace w_need_fp = . if w_unmet_fp == . | met == .


* w_metany_fp: 15-49y married or in union with need for family planning using any contraceptives (1/0)
		
		gen w_metany_fp = .
		
		replace w_metany_fp = 0 if w_need_fp == 1
		replace w_metany_fp = 1 if w_metany_fp == 0 & cp2 == 1
		replace w_metany_fp = . if w_need_fp == . | cp2 == 9

		
* w_metmod_fp: 15-49y married or in union with need for family planning using modern contraceptives (1/0)

		gen w_metmod_fp = .
		
		replace w_metmod_fp = 0 if w_need_fp == 1
		replace w_metmod_fp = 1 if w_metmod_fp == 0 & w_CPR == 1
		replace w_metmod_fp = . if w_need_fp == . | w_CPR == .

	
* w_metany_fp_q: 15-49y married or in union using modern contraceptives among those with need for family planning who use any contraceptives (1/0)

		gen w_metany_fp_q = .
		
		replace w_metany_fp_q = 0 if w_metany_fp == 1
		replace w_metany_fp_q = 1 if w_metany_fp_q == 0 & w_CPR == 1
		replace w_metany_fp_q = . if w_metany_fp == . | w_CPR == .
        }
		
		
		if inlist(country_name,"Zimbabwe2019") {
			foreach var in w_unmet_fp w_need_fp w_metany_fp w_metmod_fp w_metany_fp_q {
				cap gen `var'=.
			}
		}


* w_married: 1 if woman and mother currently married or living in union, 0 otherwise (v501 in DHS and ma1 in MICS woman dataset) – i.e. have it for both woman and child level observations ; coded no response as .
		gen w_married = .
		replace w_married = 1 if inlist(ma1,1,2)
		replace w_married = 0 if ma1 == 3
		
	label define l_ms 0 "Otherwise" 1 "Currently married or living in union"
	label values w_married l_ms		
