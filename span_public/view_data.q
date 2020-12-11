/ change the affiche option 1000 space in each row with 1000 rows
\c 1000 5000

/ change this DATADIR to the path where you saved SPAN_FUTOOF
DATADIR : "/Users/CaoRu/Documents/GitHub/KDB-Q/span/span_data"

/ load data from splayed table
load `$(":",DATADIR, "/SPAN_FUTOOF")

/ get crude oil futures from asof 2020.12.09 that is not yet expired; select crude oil option to the latest maturites.
cl_fut: select from span_dt where date = 2020.12.09, underly_code = `CL, type_code = `FUT, time_to_expr > 0, 
cl_opt: select from span_dt where date = 2020.12.09, underly_code = `CL, type_code = `OOF, time_to_expr > 0, opt_date = min opt_date


cl_opt_margin_rate :select date, exch, cc_code, underly_code, type_code, prod_name, fut_date, opt_date, opt_strike, valuation_meth, 
        max_array_value, contr_value_fact, sett_p, sett_meth, time_to_expr, margin_rate: max_array_value%contr_value_fact*sett_p,
        base_volat, volat_scan_range, price_model
        from cl_opt

(`$"/Users/CaoRu/Documents/GitHub/KDB-Q/span/crude_oil_options.csv") 0: "," 0: cl_opt_margin_rate

cl_fut_margin_rate :select date, exch, cc_code, underly_code, type_code, prod_name, fut_date, opt_date, opt_strike, valuation_meth, 
        max_array_value, contr_value_fact, sett_p, sett_meth, time_to_expr, margin_rate: max_array_value%contr_value_fact*sett_p,
        base_volat, volat_scan_range, price_model
        from cl_fut

(`$"/Users/CaoRu/Documents/GitHub/KDB-Q/span/crude_oil_futures.csv") 0: "," 0: cl_fut_margin_rate