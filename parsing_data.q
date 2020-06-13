/ Read in data file. Assume data file at path.format
dt: flip (enlist `read_in) ! (enlist ("S"); "\\") 0:`$":", "path.format";
dt: update read_in: string read_in from dt;
/ remarks:
/ 0: for read in, file path need to ba a symbol
/ ()!() create a dictionary, use flip to change a dictionary to a table
/ (enlist ("S"); "\\") means lines in data file are seperated by "\\". "S" read line as entre symbol. Then string read_in cast symbol to string.


/ Verify that it's a legal path:
if[()~key `$":", "path.file"; :(::)];

/ parsing by location, cf: https://www.cmegroup.com/confluence/display/pubspan/Type+8+-+Expanded
/ in the above example, parsing need starting and end position, and casting to proper format.
dt: update record_type: `${2#x} each read_in from dt;
r81: select from dt where record_type = `81;
cast_arr:{[s]
  tmp:"F"$5#s;
  if["-" = last s; tmp: -1*"F"$5#s];
  tmp
  };
f_record_81:{[mydata]
  record81: select from mydata where record_type = `81;
  record81[raze `$ ("r_id"; "exch"; "cc_code"; "underly_code"; "type_code"; "opt"; fut_data"; "opt_date"; "opt_strike")]:
              flip {(`$2#x; `$3#2_x; `$10#5_x; `$3#25_x; `$1#28_x; 8#29_x; 8#38_x; "F"$7#47_x)} each record81`read_in;
  update fut_date: {ssr[x;"  "; "01"]} each fut_date from record81;
  update opt_date: {ssr[x;"  "; "01"]} each opt_date from record81;
  record81[`fut_date] : "D"$record81[`fut_date];
  record81[`opt_date] : "D"$record81[`opt_date];
  arrs:{`$"array_value", string x} each 1+til 9;
  record81[arrs]: flip {cast_arr each(6#54_x; 6#60_x; 6#66_x; 6#72_x; 6#78_x; 6#84_x; 6#90_x; 6#96_x; 6#102_x)} each record81`read_in;
  record81[`sett_p`sett_p_flag]: flip {("F"$14#_108_x; 1#122_x)} each record81`read_in;
  record81: `raw`record_type _ record81;
  :record81;
  };
