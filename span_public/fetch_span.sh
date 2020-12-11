cd -P `dirname $0`
Q32U=/Users/CaoRu/q/m64/q

echo_time(){
	date + "%Y%m%d %H:%M:%S $(printf "%s " "$@" | sed 's/%/%%/g')"
}

echo_time "begin q session"
$Q32U fetch_span.q
echo_time "Done"
