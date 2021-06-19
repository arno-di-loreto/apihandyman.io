#! /bin/bash

# scripts/post.sh "<title>" <category> <date>
# category (option: post by default): posts, talks, elsewhere
# date: YYYY-MM-DD (option, today by default)

if [ -z "$1" ]
then
  echo "Not post title provided"
  exit 1
else
  TITLE=$1
fi

URL_TITLE=`echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-'`

if [ -z "$2" ]
then
  CATEGORY="posts"
else
  CATEGORY=$2
fi

if [ -z "$3" ]
then
  DATE=`date +%Y-%m-%d`
else
  DATE=$3
fi

BRANCH="post/$URL_TITLE"
FILE="_posts/$DATE-$URL_TITLE.md"
IMAGES_DIR="images/$URL_TITLE"

echo "Creating post [$TITLE] under url [$URL_TITLE] with category [$CATEGORY] and date [$DATE] on branch [$BRANCH] with file [$FILE]"

# git checkout -b $BRANCH
cp _templates/post.md $FILE

sed -e "s/TITLE/$TITLE/" -i "" $FILE
sed -e "s/DATE/$DATE/" -i "" $FILE
sed -e "s/URL_TITLE/$URL/" -i "" $FILE
sed -e "s/CATEGORY/$CATEGORY/" -i "" $FILE

mkdir $IMAGES_DIR