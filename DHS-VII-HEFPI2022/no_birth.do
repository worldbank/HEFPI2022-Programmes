//this file is to encode all relevant variable as missing in cases where there's no birth data (Peru)
#delimit ;
global birth_var "bidx 
c_anc
c_anc_any
c_anc_bp
c_anc_bp_q
c_anc_bs
c_anc_bs_q
c_anc_ear
c_anc_ear_q
c_anc_eff
c_anc_eff_q
c_anc_eff2
c_anc_eff2_q
c_anc_eff3
c_anc_eff3_q
c_anc_ir
c_anc_ir_q
c_anc_ski
c_anc_ski_q
c_anc_tet
c_anc_tet_q
c_anc_ur
c_anc_ur_q
c_anc_hosp
c_anc_public
c_caesarean
c_earlybreast
c_facdel
c_hospdel
c_sba
c_sba_eff1
c_sba_eff1_q
c_sba_eff2
c_sba_eff2_q
c_sba_q
c_skin2skin
c_pnc_any
c_pnc_eff
c_pnc_eff_q
c_pnc_eff2
c_pnc_eff2_q
c_bcg
c_dpt1
c_dpt2
c_dpt3
c_fullimm
c_measles
c_polio1
c_polio2
c_polio3
c_vaczero
c_ari
c_ari2
c_diarrhea
c_diarrhea_hmf
c_diarrhea_med
c_diarrhea_medfor
c_diarrhea_mof
c_diarrhea_pro
c_diarrheaact
c_diarrheaact_q
c_fever
c_fevertreat
c_illness
c_illtreat
c_sevdiarrhea
c_sevdiarrheatreat
c_sevdiarrheatreat_q
c_treatARI
c_treatARI2
c_treatdiarrhea
c_illness2
c_illtreat2
c_sampleweight
mor_ade
mor_afl
mor_ali
mor_dob
mor_wln
c_magebrt
hm_birthorder
c_ITN
c_mateduc
c_mateduclvl_raw
c_maleduclvl_raw
" ;
#delimit cr

foreach var in $birth_var{
gen `var' =.
}