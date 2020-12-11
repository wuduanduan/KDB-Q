id8:("haha"; "exch"; "cc_code"; "underly_code"; "type_code"; "opt"; "fut_date"; "opt_date"; "opt_strike");
/-----------------------------------------------------------------------------------------------------------------

f_record_2:{[mydata]    
    record2: select from mydata where record_type = `2;
    col1: `id`exch`cc_code; /`performance_currency_ISO_code`performance_currency_ISO`opt_margin_stype`limit_opt_value`comb_margin_method;
    record2[col1]: flip {`$(2#x; 3#2_x; 6#6_x)} each record2`raw; / flip {`$(2#x; 3#2_x; 6#6_x; 3#13_x;1#16_x; 1#17_x; 1#18_x; 1#19_x)} each record2`raw;
    col2:raze (`risk_exponent;`$({"risk_array_value_dec_", string x} each 1+til 6));
    record2[col2]: flip {"F"$(1#12_x; 2#35_x; 2#51_x; 2#67_x; 2#83_x; 2#99_x; 2#115_x )} each record2`raw;
    col3: `${"contract_type",string x} each 1+til 6;
    record2[col3]:flip {`$(3#32_x; 3#48_x; 3#64_x; 3#80_x; 3#96_x; 3#112_x)} each record2`raw;
    record2: `raw`record_type _ record2;    
    record2    
    };

f_record_P:{[mydata]
    recordP:select from mydata where record_type=`P;
    col_1:`r_id`exch`cc_code`type_code`prod_name`sett_p_loc`strike_p_loc`sett_p_align_code`strike_p_align_code;
    recordP[col_1]:flip{(`$2#x;`$3#2_x;`$10#5_x;`$3#15_x;15#18_x;"J"$3#33_x;"J"$3#36_x;1#39_x;1#40_x)}each recordP`raw;
    col_2:`contr_value_fact`stand_cab_opt_value; / `quotd_posit_per_contr`sett_curr_ISO`sett_curr_onebyte;
    recordP[col_2]: flip{(("F"$14#41_x)%1e7;("F"$8#55_x)%100)}each recordP`raw; / flip{(("F"$14#41_x)%1e7;("F"$8#55_x)%100;"J"$2#63_x;3#65_x;1#68_x)}each recordP`raw;
    recordP:`raw`record_type _ recordP;
    recordP
    };
    
cast_arr:{[s]
    tmp:"F"$5#s;
    if[last s="-";tmp:-1*"F"$5#s];
    tmp
    };
   
f_record_V:{[mydata]
    recordV:select from mydata where record_type=`V;
    col:`r_id`exch`cc_code`fut_date`buss_date;
    recordV[col]:flip{(`$2#x;`$3#2_x;`$10#5_x;8#15_x;"D"$8#23_x)}each recordV`raw;
    recordV:update fut_date:{ssr[x;"  ";"01"]}each fut_date from recordV;
    col_2:`long_maint`short_maint;
    recordV[col_2]:flip{("F"$3#62_x;"F"$3#65_x)} each recordV`raw;
    recordV
    };
    
f_record_81:{[mydata] 
    record81:select from mydata where record_type = `81;
    record81[raze `$id8]:flip{(`$2#x;`$3#2_x;`$10#5_x;`$10#15_x;`$3#25_x;`$1#28_x;8#29_x;8#38_x;"F"$7#47_x)} each record81`raw;
    record81: update fut_date:{ssr[x;"  ";"01"]} each fut_date from record81;
    record81: update opt_date:{ssr[x;"  ";"01"]} each opt_date from record81;
    record81[`fut_date] : "D"$record81[`fut_date];
    record81[`opt_date] : "D"$record81[`opt_date];
    arrs:{`$"array_value",string x} each 1+til 9;
    record81[arrs]: flip {cast_arr each(6#54_x; 6#60_x; 6#66_x; 6#72_x; 6#78_x; 6#84_x; 6#90_x; 6#96_x; 6#102_x) } each record81`raw;    
    record81[`sett_p`sett_p_flag]: flip {("F"$14#108_x; 1#122_x)} each record81`raw;    
    / record[`sett_p]: record[`sett_p]/100    
    record_81: `raw`record_type _ record81;        
    record_81    
    };
    
f_record_82:{[mydata]    
    record82: select from mydata where record_type = `82;            
    / id82:("id"; "exch"; "cc_code"; "underly_code"; "type_code"; "opt"; "fut_date"; "opt_date"; "opt_strike");        
    record82[raze `$ id8]: flip {(`$2#x; `$3#2_x; `$10#5_x; `$10#15_x; `$3#25_x; `$1#28_x; 8#29_x; 8#38_x; "F"$7#47_x )} each record82`raw;
    record82: update fut_date:{ssr[x;"  ";"01"]} each fut_date from record82;        
    record82: update opt_date:{ssr[x;"  ";"01"]} each opt_date from record82;        
    record82[`fut_date] : "D"$record82[`fut_date];        
    record82[`opt_date] : "D"$record82[`opt_date];        
    arrs:{`$"array_value",string x} each 10+til 7;        
    record82[arrs]: flip {cast_arr each(6#54_x; 6#60_x; 6#66_x; 6#72_x; 6#78_x; 6#84_x; 6#90_x) } each record82`raw;        
    col_82: `compos_delta`compos_delta_sign`volat_imp`sett_p_r82`sett_sign`strike_sign`current_delta`curr_delta_sign`curr_delta_flag`p_start_day`sign_start_day`exp_volat_imp`sign_exp_volat_imp ;        
    record82[col_82]: flip {("F"$5#96_x; `$1#101_x; "F"$8#102_x; "F"$7#110_x; `$1#117_x; `$1#118_x; "F"$5#119_x; `$1#124_x; `$1#125_x; "F"$7#126_x; `$1#133_x; "J"$2#134_x; `$1#136_x )} each record82`raw;        
    record82[`compos_delta]: record82[`compos_delta]%10000;        
    record82[`current_delta]: record82[`current_delta]%10000;        
    record82[`volat_imp]: record82[`volat_imp]%1000000;        
    col_82_c:`contr_value_fact`contr_value_fact_exp`strike_value_fact`strike_value_fact_exp;        
    record82[col_82_c]: flip {("F"$14#137_x; 3#151_x; "F"$14#154_x; 3#170_x)} each record82`raw;        
    record82[`contr_value_fact] : record82[`contr_value_fact]%10000000;        
    record82[`strike_value_fact]: record82[`strike_value_fact]%10000000;        
    record_82: `raw`record_type _ record82;       
    record_82       
    };

f_record_8:{[mydata]        
    record_81: f_record_81[mydata];        
    record_82: f_record_82[mydata];                
    record_8: record_81 lj ( select by exch, cc_code, underly_code, type_code, opt, fut_date, opt_date, opt_strike from record_82 );        
    record_8                    
    };


f_record_B_new:{[mydata]    
    recordB: select from mydata where record_type = `B;    
    col: `id`exch`cc_code`type_code`fut_date`opt_date`base_volat`volat_scan_range`fut_scan_range`extreme_move_multip`extr_move_covered_fraction`interest_rate`time_to_expr`look_ahead_time`delta_scal_factor`expiration_date`underly_code`price_model;    
    recordB[col]: flip {(`$2#x; `$3#2_x; `$10#5_x; `$3#15_x; 8#18_x; 8#27_x;("F"$8#36_x)%1e6; ("F"$8#44_x)%1e6; "F"$5#52_x; ("F"$5#57_x)%1e3; ("F"$5#62_x)%1e4; ("F"$5#67_x)%1e4; ("F"$7#72_x)%1e6; ("F"$6#79_x)%1e6; ("F"$6#85_x)%1e4; "D"$8#91_x; `$10#99_x; `$2#109_x)} each recordB`raw;    
    recordB: update fut_date:{"D"$ ssr[x;"  ";"01"]} each fut_date from recordB;    
    recordB: update opt_date:{"D"$ ssr[x;"  ";"01"]} each opt_date from recordB;         
    recordB: `raw`record_type _ recordB;    
    recordB    
    };
f_retrieve_FUTOOF: {[FILE]         
    show FILE;      
    thedate: 8#(-14#FILE);        
    dt: flip (enlist `raw)!(enlist ("S");"\\")0:`$":",FILE ;     
    show dt[0];        
    dt: update raw:string raw from dt;        
    dt: update record_type:`${2#x} each raw from dt;        
    count_r83: count select from dt where record_type = `83;        
    if[count_r83 > 0; (`$(":",DATADIR, "r83_", thedate)) set (raze string count_r83, " 8384 record")];        
    record_P: f_record_P[dt];        
    record_B: f_record_B_new[dt];        
    record_8: f_record_8[dt];        
    record_2: f_record_2[dt];        
    arrs:{`$"array_value",string x} each 1+til 16;        
    merged: record_8 lj (select by exch, cc_code, type_code from record_P);        
    merged[enlist`sett_p] : merged[enlist `sett_p] %\: 10 xexp merged[`sett_p_loc];  
    /this just works accidently, should have use (%/) (merged`sett_p; 10 xexp merged`sett_p_loc)        
    merged: merged lj (select by exch, cc_code, type_code, fut_date from record_B);        
    merged: merged lj (select by exch, cc_code from record_2 );        
    merged: update risk_exponent: {if[x = 0n; x:0]; x} each risk_exponent from merged;  / here instead of if, can use ?[x=0n; 0; x]        
    / merged[arrs]: merged[arrs] *\\: 10 xexp merged[`risk_exponent];    
       
    merged[`$"max_array_value"]: {(max x)} each flip merged[arrs];        
    merged: update sett_p_ini: {x} each sett_p from merged;        
    merged: update sett_sign_n: {x < `$"-"} each sett_sign from merged;        
    merged: update sett_p: (-1 + sett_sign_n * 2)*sett_p_ini from merged;        
    merged: update opt_strike: (-1+2*({x =`$"+"} strike_sign))*opt_strike%(10 xexp strike_p_loc) from merged;        
    record: select from merged where (type_code = `OOF) or (type_code = `FUT); / , (cc_code = `CL) or (cc_code = `CLL) or (cc_code = `MBZ) or (cc_code = `GSP) or (cc_code = `SGU) ;        
    record[`r_date]: (count record)#("D"$8#thedate);        
    / (`$":/lxhome/caoru/span_data/parsed_by_day/", (raze enlist ((4#4_FILE), ".", (2#8_FILE), ".", (2#10_FILE),"/t"))) set record;        
    / (`$":/lxhome/caoru/span_data/db/", ((4#28_FILE), ".", (2#32_FILE), ".", (2#34_FILE),"/t/")) set .Q.en[`:lxhome/caoru/span_data/db;] record;        
    (`$(":", DATADIR,"SPAN_FUTOOF/"), (raze enlist ((4#thedate), ".", (2#4_thedate), ".", (2#6_thedate),"/span_dt/"))) set .Q.en[(`$(":", DATADIR, "SPAN_FUTOOF/"));] record;        
    / record     
    };
