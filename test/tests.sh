#! /bin/sh

OK_RESP=200
RESP=$(curl -s -o /dev/null -I -w "%{http_code}" localhost:7000)
if [ "$RESP" -eq "$OK_RESP" ] ; then
	echo "Returned 200 OK"
	exit 0
fi

#If response of cURL is not 200, something is wrong. Deployment won't proceed
echo "Bad Response..."
exit 1


