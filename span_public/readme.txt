Files in this folder note some key elements to construct a splayed table from raw data file in KDB/q.
- Raw data is collacted by running fetch_span.sh where fetch_span.q is called.
- Raw data can be found at ftp://ftp.cmegroup.com/span/data/cme
- Parsing format follows the expanded Fromat at https://www.cmegroup.com/confluence/display/pubspan/Risk+Parameter+File+Layouts+for+the+Positional+Formats
- The parsing function(not whole) is in parsing_span_simplified.q to give an idea what's the original data is like.
- Then view_data.q load the splayed table and extract relevant data.
