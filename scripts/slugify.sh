TO_SLUG=$1
SLUG=`echo "$TO_SLUG" | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]' | tr '[:blank:]' '-'` 
echo $SLUG