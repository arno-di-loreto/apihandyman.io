SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR=$SCRIPT_DIR/..
IMAGES=$ROOT_DIR/images
POSTS=$ROOT_DIR/_posts

get_fm_value () {
    FILE=$1
    FM_NAME=$2
    FM_LINE=`grep -m 1 $FM_NAME $FILE`
    FM_VALUE=${FM_LINE/$FM_NAME: /}
}


FILE=$1
UPDATED_TITLE=$2

if [ -z "$FILE" ]
then
  echo "Not post file provided"
  exit 1
fi

if [ -z "$UPDATED_TITLE" ]
then
    get_fm_value $FILE "title"
    UPDATED_TITLE=$FM_VALUE
fi

get_fm_value $FILE "title"
TITLE=$FM_VALUE
echo TITLE:$TITLE

get_fm_value $FILE "date"
DATE=$FM_VALUE
echo DATE:$DATE

----getfmvalue-file-title
PERMALINK=`echo "$FM_VALUE" | tr -d '/'`
echo PERMALINK:[$PERMALINK]

UPDATED_PERMALINK=`$SCRIPT_DIR/slugify.sh "$UPDATED_TITLE"`
echo UPDATED_PERMALINK:[$UPDATED_PERMALINK]

POST_IMAGES=$IMAGES/$PERMALINK
UPDATED_POST_IMAGES=$IMAGES/$UPDATED_PERMALINK

UPDATED_FILE=$POSTS/$DATE-$UPDATED_PERMALINK.md

echo "updating permalink"
sed -e "s/$PERMALINK/$UPDATED_PERMALINK/" -i "" $FILE
echo "updating images folder"
mv $POST_IMAGES $UPDATED_POST_IMAGES
echo "renaming-file"
mv $FILE $UPDATED_FILE

$SCRIPT_DIR/refresh-index.sh