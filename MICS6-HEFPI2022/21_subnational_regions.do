///// MICS6-dofiles
// Subnational Regions
// Do-file for the indicators:
/*

gl_adm1_code

to visualize indicator values at the highest subnational administrative level
If we can't match to the GAUL because we lack data, or lack labels, let's create the variables anyway to make sure we know the survey was screened. Let's use these codes:
   gen gl_adm0_code = -9
   gen gl_adm1_code = -9
   gen gl_adm1_name = "NA"
   gen gl_adm1_name_alt = "NA"

If we can't match to the GAUL because the internal boundaries have changed, let's use the following codes
   gen gl_adm0_code = -7
   gen gl_adm1_code = -7
   gen gl_adm1_name = "admin change"
   gen gl_adm1_name_alt = "admin change"
*/
		gen gl_adm0_code = .
		gen gl_adm1_code = . 
		
		if inlist(country_name,"LaoPDR2017") {
		    replace gl_adm0_code = 139
            replace gl_adm1_code = 1753 if hh_region_num == 17
			replace gl_adm1_code = 1754 if hh_region_num == 5
			replace gl_adm1_code = 1755 if hh_region_num == 11
			replace gl_adm1_code = 1756 if hh_region_num == 16			
			replace gl_adm1_code = 1757 if hh_region_num == 7
			replace gl_adm1_code = 1758 if hh_region_num == 12
			replace gl_adm1_code = 1759 if hh_region_num == 6
			replace gl_adm1_code = 1760 if hh_region_num == 3			
			replace gl_adm1_code = 1761 if hh_region_num == 4
			replace gl_adm1_code = 1762 if hh_region_num == 2
			replace gl_adm1_code = 1763 if hh_region_num == 14			
			replace gl_adm1_code = 1764 if hh_region_num == 13
			replace gl_adm1_code = 1765 if hh_region_num == 8
			replace gl_adm1_code = 1766 if hh_region_num == 15
			replace gl_adm1_code = 1768 if hh_region_num == 1
			replace gl_adm1_code = 74346 if inlist(hh_region_num,10,18)	 // https://en.wikipedia.org/wiki/Special_Zone_of_Xaisomboun	
			replace gl_adm1_code = 74347 if hh_region_num == 9 			
		}	
		if inlist(country_name,"SierraLeone2017") { 	
            replace gl_adm0_code = 221
            replace gl_adm1_code = 2654 if hh_region_num == 1
			replace gl_adm1_code = 2655 if hh_region_num == 2
			replace gl_adm1_code = 2656 if hh_region_num == 3
			replace gl_adm1_code = 2657 if hh_region_num == 4	
		}  	
		
		if inlist(country_name,"Iraq2017") {
		    replace gl_adm0_code = 118
            replace gl_adm1_code = 1564 if hh_region_num == 22
			replace gl_adm1_code = 1565 if hh_region_num == 35
			replace gl_adm1_code = 1566 if hh_region_num == 32
			replace gl_adm1_code = 1567 if hh_region_num == 31			
			replace gl_adm1_code = 1568 if hh_region_num == 28
			replace gl_adm1_code = 1569 if hh_region_num == 15
			replace gl_adm1_code = 1570 if hh_region_num == 14
			replace gl_adm1_code = 1571 if hh_region_num == 24			
			replace gl_adm1_code = 1572 if hh_region_num == 23
			replace gl_adm1_code = 1573 if hh_region_num == 33
			replace gl_adm1_code = 1574 if hh_region_num == 11			
			replace gl_adm1_code = 1575 if hh_region_num == 21
			replace gl_adm1_code = 1576 if hh_region_num == 25
			replace gl_adm1_code = 1577 if hh_region_num == 34
			replace gl_adm1_code = 1578 if hh_region_num == 12	
		    replace gl_adm1_code = 1579 if hh_region_num == 27
			replace gl_adm1_code = 1580 if hh_region_num == 13
			replace gl_adm1_code = 1581 if hh_region_num == 26	
		}			
        if inlist(country_name,"KyrgyzRepublic2018") {
		    replace gl_adm0_code = 138
            replace gl_adm1_code = 1746 if hh_region_num == 1
			replace gl_adm1_code = 147294 if hh_region_num == 7
			replace gl_adm1_code = 1748 if hh_region_num == 2
			replace gl_adm1_code = 1749 if hh_region_num == 4			
			replace gl_adm1_code = 1750 if inlist(hh_region_num,5,9)
			replace gl_adm1_code = 1751 if hh_region_num == 6
			replace gl_adm1_code = 1752 if hh_region_num == 3
			replace gl_adm1_code = 147293 if hh_region_num == 8			
        }
        if inlist(country_name,"Mongolia2018") {
		    replace gl_adm0_code = 167
            replace gl_adm1_code = -9 		
        }	
		if inlist(country_name,"Suriname2018") {
			replace gl_adm0_code = 233
			replace gl_adm1_code = 2771 if hh_region_num == 9
			replace gl_adm1_code = 2772 if hh_region_num == 6
			replace gl_adm1_code = 2773 if hh_region_num == 4
			replace gl_adm1_code = 2774 if hh_region_num == 7			
			replace gl_adm1_code = 2775 if hh_region_num == 3
			replace gl_adm1_code = 2776 if hh_region_num == 8
			replace gl_adm1_code = 2777 if hh_region_num == 1
			replace gl_adm1_code = 2778 if hh_region_num == 5			
			replace gl_adm1_code = 2779 if hh_region_num == 10
			replace gl_adm1_code = 2780 if hh_region_num == 2
		}
		if inlist(country_name,"Gambia2018") { 	
            replace gl_adm0_code = 90
			replace gl_adm1_code = 1285 if inlist(hh_region_num,6,7)
			replace gl_adm1_code = 1287 if hh_region_num == 4
			replace gl_adm1_code = 1288 if hh_region_num == 5
			replace gl_adm1_code = 1289 if hh_region_num == 8	
			replace gl_adm1_code = 1290 if inlist(hh_region_num,1,3)
            replace gl_adm1_code = 112869 if hh_region_num == 2	
		}
		// reference: http://www.visitthegambia.gm/map-and-regions
		if inlist(country_name,"Tunisia2018") { 	
            replace gl_adm0_code = 248
			replace gl_adm1_code = -9 
		}
		if inlist(country_name,"Lesotho2018") { 	
            replace gl_adm0_code = 142
			replace gl_adm1_code = -9 
		}  		
		
		if inlist(country_name,"Madagascar2018") { 			
			replace gl_adm0_code = 150
			replace gl_adm1_code = 41750 if hh_region_num == 33
			replace gl_adm1_code = 41751 if hh_region_num == 22
			replace gl_adm1_code = 41752 if hh_region_num == 11			
			replace gl_adm1_code = 41753 if hh_region_num == 32
			replace gl_adm1_code = 41754 if hh_region_num == 52
			replace gl_adm1_code = 41755 if hh_region_num == 53
			replace gl_adm1_code = 41756 if hh_region_num == 51			
			replace gl_adm1_code = 41757 if hh_region_num == 25
			replace gl_adm1_code = 41758 if hh_region_num == 31
			replace gl_adm1_code = 41759 if hh_region_num == 43			
			replace gl_adm1_code = 41760 if hh_region_num == 41
			replace gl_adm1_code = 41761 if hh_region_num == 14
			replace gl_adm1_code = 41762 if hh_region_num == 61
			replace gl_adm1_code = 41763 if hh_region_num == 21
			replace gl_adm1_code = 41764 if hh_region_num == 24
			replace gl_adm1_code = 41765 if hh_region_num == 13
			replace gl_adm1_code = 41766 if hh_region_num == 44			
			replace gl_adm1_code = 41767 if hh_region_num == 54
			replace gl_adm1_code = 41768 if hh_region_num == 62
			replace gl_adm1_code = 41769 if hh_region_num == 42
			replace gl_adm1_code = 41770 if hh_region_num == 12			
			replace gl_adm1_code = 41771 if hh_region_num == 23
		}
		
		if inlist(country_name,"Zimbabwe2019") { 			
			replace gl_adm0_code = 271
			replace gl_adm1_code = 3437 if hh_region_num == 1
			replace gl_adm1_code = 3438 if hh_region_num == 2
			replace gl_adm1_code = 3440 if hh_region_num == 4			
			replace gl_adm1_code = 3441 if hh_region_num == 8
			replace gl_adm1_code = 3443 if hh_region_num == 6
			replace gl_adm1_code = 3444 if hh_region_num == 7
			replace gl_adm1_code = 3435 if hh_region_num == 0			
			replace gl_adm1_code = 3436 if hh_region_num == 9
			replace gl_adm1_code = 69549 if hh_region_num == 5
			replace gl_adm1_code = 69550 if hh_region_num == 3	
		}
		if inlist(country_name,"Georgia2018") {
		    replace gl_adm0_code = 92
            replace gl_adm1_code = 1297 if hh_region_num == 15
			replace gl_adm1_code = 1298 if hh_region_num == 23
			replace gl_adm1_code = 1299 if hh_region_num == 26
			replace gl_adm1_code = 1300 if hh_region_num == 29			
			replace gl_adm1_code = 1301 if hh_region_num == 44
			replace gl_adm1_code = 1302 if hh_region_num == 32
			replace gl_adm1_code = 1304 if hh_region_num == 38
			replace gl_adm1_code = 1305 if hh_region_num == 41			
			replace gl_adm1_code = 1306 if hh_region_num == 47
			replace gl_adm1_code = 1307 if hh_region_num == 11
		}
		// no region Abkhazia Aut.(1296) Rep. and Tbilisi(1307) in survey
		
		if inlist(country_name,"Bangladesh2019") {   
		    replace gl_adm0_code = 23
            replace gl_adm1_code = 575 if hh_region_num == 10  
			replace gl_adm1_code = 576 if hh_region_num == 20
			replace gl_adm1_code = 577 if hh_region_num == 30
			replace gl_adm1_code = 578 if hh_region_num == 40			
			replace gl_adm1_code = 580 if hh_region_num == 60
			replace gl_adm1_code = 61362 if hh_region_num == 50          
			replace gl_adm1_code = 61363 if hh_region_num == 55
		}
		// no region Mymensingh (region 45) in gaul code
		
		if inlist(country_name,"Congodr2017") {
		    replace gl_adm0_code = 68
            replace gl_adm1_code = 1066 if inrange(hh_region_num,3,5)
			replace gl_adm1_code = 1067 if hh_region_num == 2
			replace gl_adm1_code = 1068 if inrange(hh_region_num,6,10)
			replace gl_adm1_code = 1069 if inlist(hh_region_num,25,26)		
			replace gl_adm1_code = 1070 if inrange(hh_region_num,22,24)
			replace gl_adm1_code = 1071 if inrange(hh_region_num,18,21)
			replace gl_adm1_code = 1072 if hh_region_num == 1
			replace gl_adm1_code = 1073 if hh_region_num == 17			
			replace gl_adm1_code = 1074 if hh_region_num == 15
			replace gl_adm1_code = 1075 if inrange(hh_region_num,11,14)
			replace gl_adm1_code = 1076 if hh_region_num == 16
		}
		if inlist(country_name,"Ghana2017") {
		    replace gl_adm0_code = 94
            replace gl_adm1_code = 1324 if hh_region_num == 6
			replace gl_adm1_code = 1325 if hh_region_num == 7
			replace gl_adm1_code = 1326 if hh_region_num == 2
			replace gl_adm1_code = 1327 if hh_region_num == 5			
			replace gl_adm1_code = 1328 if hh_region_num == 3
			replace gl_adm1_code = 1329 if hh_region_num == 8
			replace gl_adm1_code = 1330 if hh_region_num == 9
			replace gl_adm1_code = 1331 if hh_region_num == 10			
			replace gl_adm1_code = 1332 if hh_region_num == 4
			replace gl_adm1_code = 1333 if hh_region_num == 1
		}
		if inlist(country_name,"Togo2017") {
		    replace gl_adm0_code = 243
            replace gl_adm1_code = 2970 if hh_region_num == 3
			replace gl_adm1_code = 2971 if hh_region_num == 4
			replace gl_adm1_code = 2972 if hh_region_num == 1
			replace gl_adm1_code = 2973 if hh_region_num == 2
			replace gl_adm1_code = 2974 if hh_region_num == 5
		}

		// no region Lome Commune (6) and Golfe Urbain (7) in gaul codes
		if inlist(country_name,"Kiribati2018") {
		    replace gl_adm0_code = 135
            replace gl_adm1_code = -9 		
        }	
		if inlist(country_name,"Montenegro2018") {
		    replace gl_adm0_code = 2647
            replace gl_adm1_code = -9 		
        }	

		if inlist(country_name,"Belarus2019") {
		    replace gl_adm0_code = 26
            replace gl_adm1_code = 593 if hh_region_num == 1
			replace gl_adm1_code = 594 if hh_region_num == 3
			replace gl_adm1_code = 595 if hh_region_num == 4
			replace gl_adm1_code = 596 if hh_region_num == 6
			replace gl_adm1_code = 597 if hh_region_num == 5
			replace gl_adm1_code = 598 if hh_region_num == 7 
			replace gl_adm1_code = 599 if hh_region_num == 2		
        }

		if inlist(country_name,"CentralAfricanRepublic2019") {
		    replace gl_adm0_code = 49
            replace gl_adm1_code = -7 		
        }	// Region1-7 in CAR hh7 contain many subregions therefore it's hard to code them. E.g., Region1 (hh_region_num=1) includes Ombella-Mpoko(gl_adm1_code=863), Lobaye(gl_adm1_code=858)
		
		if inlist(country_name,"Chad2019") {
		    replace gl_adm0_code = 50
            replace gl_adm1_code = 12912 if hh_region_num == 5
			replace gl_adm1_code = 12925 if hh_region_num == 10
			replace gl_adm1_code = 12927 if hh_region_num == 14		
        } // Ndjamena(hh_region_num=18) not found in gl_adm1_code

		if inlist(country_name,"CostaRica2018") {
		    replace gl_adm0_code = 61
            replace gl_adm1_code = 981 if hh_region_num == 2
			replace gl_adm1_code = 982 if hh_region_num == 3
			replace gl_adm1_code = 983 if hh_region_num == 5
			replace gl_adm1_code = 984 if hh_region_num == 4
			replace gl_adm1_code = 985 if hh_region_num == 7
			replace gl_adm1_code = 986 if hh_region_num == 6 
			replace gl_adm1_code = 987 if hh_region_num == 1		
        }

		if inlist(country_name,"Cuba2019") {
		    replace gl_adm0_code = 63
            replace gl_adm1_code = 1017 if hh_region_num == 23
			replace gl_adm1_code = 1023 if hh_region_num == 26
			replace gl_adm1_code = 1010 if hh_region_num == 29
			replace gl_adm1_code = 1013 if hh_region_num == 33		
        }

		if inlist(country_name,"Guinea-Bissau2018") {
		    replace gl_adm0_code = 105
            replace gl_adm1_code = 1385 if hh_region_num == 6
			replace gl_adm1_code = 1386 if hh_region_num == 4
			replace gl_adm1_code = 1387 if hh_region_num == 5
			replace gl_adm1_code = 1388 if hh_region_num == 8
			replace gl_adm1_code = 1389 if hh_region_num == 7
			replace gl_adm1_code = 1390 if hh_region_num == 3
			replace gl_adm1_code = 1391 if hh_region_num == 2
			replace gl_adm1_code = 1392 if hh_region_num == 9
			replace gl_adm1_code = 1393 if hh_region_num == 1			
        }

		if inlist(country_name,"Kosovo2019") {
		    replace gl_adm0_code = -9
            replace gl_adm1_code = -9		
        } // no observations in subnational.dta

		if inlist(country_name,"Nepal2019") {
		    replace gl_adm0_code = 175
            replace gl_adm1_code = -7		
        } // internal boundaries have changed and make it hard to match
		
		if inlist(country_name,"NorthMacedonia2018") {
		    replace gl_adm0_code = 241
            replace gl_adm1_code = -7 
        } //internal boundaries have changed and make it hard to match

		if inlist(country_name,"SaoTomeAndPrincipe2019") {
		    replace gl_adm0_code = 214
            replace gl_adm1_code = -7 
        } //internal boundaries have changed and make it hard to match

		if inlist(country_name,"Serbia2019") {
		    replace gl_adm0_code = 2648
            replace gl_adm1_code = -7 
        } //internal boundaries have changed and make it hard to match

		if inlist(country_name,"Thailand2019") {
		    replace gl_adm0_code = 240
            replace gl_adm1_code = -7 
        } //internal boundaries have changed and make it hard to match
		
		if inlist(country_name,"Tonga2019") {
		    replace gl_adm0_code = 245
            replace gl_adm1_code = 2976 if inrange(hh_region_num,1,5)
        } // 2976 = "Administrative unit not available"

		if inlist(country_name,"Turkmenistan2019") {
		    replace gl_adm0_code = 250
			replace gl_adm1_code = 3097 if hh_region_num == 5
			replace gl_adm1_code = 3097 if hh_region_num == 1
            replace gl_adm1_code = 3099 if hh_region_num == 6
			replace gl_adm1_code = 3100 if hh_region_num == 4
			replace gl_adm1_code = 147322 if hh_region_num == 3
			replace gl_adm1_code = 147323 if hh_region_num == 2
        }

		if inlist(country_name,"Algeria2018") {
		    replace gl_adm0_code = 4
            replace gl_adm1_code = -7 
        } //internal boundaries have changed and make it hard to match
			
		if inlist(country_name,"Honduras2019") {
		    replace gl_adm0_code = 111
			replace gl_adm1_code = 1420 if hh_region_num == 1
			replace gl_adm1_code = 1422 if hh_region_num == 2
            replace gl_adm1_code = 1423 if hh_region_num == 3
			replace gl_adm1_code = 1424 if hh_region_num == 4
			replace gl_adm1_code = 1425 if hh_region_num == 5
			replace gl_adm1_code = 1421 if hh_region_num == 6 // choluteca
			replace gl_adm1_code = . if hh_region_num == 7 // el paraiso
			replace gl_adm1_code = 1426 if hh_region_num == 8
            replace gl_adm1_code = 1427 if hh_region_num == 9
			replace gl_adm1_code = 1428 if hh_region_num == 10
			replace gl_adm1_code = 1429 if hh_region_num == 11
			replace gl_adm1_code = 1430 if hh_region_num == 12
            replace gl_adm1_code = 1431 if hh_region_num == 13
			replace gl_adm1_code = 1433 if hh_region_num == 14
			replace gl_adm1_code = 1434 if hh_region_num == 15
			replace gl_adm1_code = 1436 if hh_region_num == 16
            replace gl_adm1_code = 1437 if hh_region_num == 17
			replace gl_adm1_code = 1438 if hh_region_num == 18
			replace gl_adm1_code = . if hh_region_num == 19 // san pedro sula
			replace gl_adm1_code = . if hh_region_num == 20 // distrito central
			
			/*FAO's Gaul2015 has a "Name unknown" category https://data.apps.fao.org/catalog/dataset/gaul-codes/resource/cfdaf156-26b9-46c2-aab2-eb437fc16622
			*/
        }		

		if inlist(country_name,"Malawi2019") {
		    replace gl_adm0_code = 152
			replace gl_adm1_code = 1889 if hh_region_num == 1
			replace gl_adm1_code = 1888 if hh_region_num == 2
            replace gl_adm1_code = 1890 if hh_region_num == 3
			
        }		
