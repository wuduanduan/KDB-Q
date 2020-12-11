/ last excuted with today as of 2020.12.09

/ WORKDIR: first system "pwd";
WORKDIR: "/Users/CaoRu/Documents/GitHub/KDB-Q/span";
show ("WORDIR=",WORKDIR);

DATADIR: (WORKDIR, "/span_data/");
show ("DATADIR=", DATADIR);
system "l ", WORKDIR, "/parsing_span.q";

today: raze {string ` vs `$string x} .z.D - 2; show raze("today = ", (string today));

filepath:`$(DATADIR,"cme.", today, ".c.pa2.zip");

/download data file
system "cd ", DATADIR; 

if[()~key `$(":", string filepath);
	show "begin downloading";
 	system ("wget -r -np -nd ftp://ftp.cmegroup.com/span/data/cme/cme.",today, ".c.pa2.zip;");
 	show "finish download";
 	system ("unzip ", "cme.", today, ".c.pa2.zip;");
 	
 	];

show "Begin parsing...";
f_retrieve_FUTOOF raze -4 _ string filepath;
show "End parsing, done";

/ system "echo 'SPAN fetch and parse finished'|mutt -s 'span_fetch' -- fishcaoru@gmail.com";

