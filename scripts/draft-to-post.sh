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
DATE=$2

if [ -z "$FILE" ]
then
    echo "No draft file provided"
    exit 1
fi

if [[ "$FILE" == *"_drafts/"* ]]
then
    echo "Draft file provided $FILE"
else
    echo "$FILE is not a draft file"
    exit 1
fi

if [ -z "$DATE" ]
then
    DATE=`date +%Y-%m-%d`
fi

sed -e "3i\\
date: $DATE
" -i "" $FILE

get_fm_value $FILE "permalink"
PERMALINK=`echo "$FM_VALUE" | tr -d '/'`

POST_FILE=$POSTS/$DATE-$PERMALINK.md
echo Moving $FILE draft to $POST_FILE

mv $FILE $POST_FILE

$SCRIPT_DIR/refresh-index.sh

code $POST_FILE