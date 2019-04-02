FILE=locust_test.py

HOST=http://credit-stg.alphacario.com

if [ -n "$1" ]; then
    FILE=$1
fi

if [ -n "$2" ]; then
    HOST=$2
fi

locust --host=$HOST -f $FILE
