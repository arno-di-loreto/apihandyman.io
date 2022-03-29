SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR=$SCRIPT_DIR/..
IMAGES=$ROOT_DIR/images
POSTS=$ROOT_DIR/_posts
DRAFTS=$ROOT_DIR/_drafts

get_fm_value () {
    FILE=$1
    FM_NAME=$2
    FM_LINE=`grep -m 1 $FM_NAME $FILE`
    FM_VALUE=${FM_LINE/$FM_NAME: /}
}


FILE=$1

if [ -z "$FILE" ]
then
  echo "Not post file provided"
  exit 1
fi

if [[ "$FILE" == *"_posts/"* ]]
then
  echo "Post file provided $FILE"
  FOLDER=$POSTS
elif [[ "$FILE" == *"_drafts/"* ]]
then
  echo "Draft file provided $FILE"
  FOLDER=$DRAFTS
else
  echo "No post or draft file provided"
  exit 1
fi


get_fm_value $FILE "title"
UPDATED_TITLE=$FM_VALUE
echo UPDATED_TITLE:[$UPDATED_TITLE]

get_fm_value $FILE "date"
UPDATED_DATE=$FM_VALUE
echo UPDATED_DATE:$UPDATED_DATE

get_fm_value $FILE "permalink"
PERMALINK=`echo "$FM_VALUE" | tr -d '/'`
echo PERMALINK:[$PERMALINK]

UPDATED_PERMALINK=`$SCRIPT_DIR/slugify.sh "$UPDATED_TITLE"`
echo UPDATED_PERMALINK:[$UPDATED_PERMALINK]

IMAGES=$IMAGES/$PERMALINK
UPDATED_IMAGES=$IMAGES/$UPDATED_PERMALINK
echo UPDATED_IMAGES:[$UPDATED_IMAGES]

# No date for draft but date for post in filename
FILENAME=$UPDATED_PERMALINK.md
if [[ "$FILE" == *"_posts/"* ]]
then
  FILENAME=$UPDATED_DATE-$FILENAME
fi

UPDATED_FILE=$FOLDER/$FILENAME
echo UPDATED_FILE:[$UPDATED_FILE]

echo "updating permalink"
sed -e "s/$PERMALINK/$UPDATED_PERMALINK/" -i "" $FILE
if [[ -d $IMAGES ]]
then
  echo "renaming images folder"
  mv $IMAGES $UPDATED_IMAGES
fi
echo "renaming file"
mv $FILE $UPDATED_FILE

$SCRIPT_DIR/refresh-index.sh