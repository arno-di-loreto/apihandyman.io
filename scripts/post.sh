# scripts/post.sh "<title>" <category> <date>
# category (option: post by default): post, talk
# date: YYYY-MM-DD (option, today by default)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR=$SCRIPT_DIR/..

TITLE=$1
CATEGORY=$2
DATE=$3

if [ -z "$TITLE" ]
then
  echo "Not post title provided"
  exit 1
fi

URL_TITLE=`$SCRIPT_DIR/slugify.sh "$TITLE"`

if [ -z "$CATEGORY" ]
then
  echo "No post category provided"
  exit 1
fi

if [ -z "$DATE" ]
then
  DATE=`date +%Y-%m-%d`
fi

BRANCH="post/$URL_TITLE"
FILE="_posts/$DATE-$URL_TITLE.md"
IMAGES_DIR="images/$URL_TITLE"

echo "Creating post [$TITLE]"
echo "With url [$URL_TITLE]"
echo "And images directory [$IMAGES_DIR]"
echo "And category [$CATEGORY]"
echo "And date [$DATE]"
echo "On branch [$BRANCH]"
echo "And file [$FILE]"

git checkout master
git pull
git checkout -b $BRANCH
cp $ROOT_DIR/_templates/post.md $ROOT_DIR/$FILE

sed -e "s/TITLE/$TITLE/" -i "" $ROOT_DIR/$FILE
sed -e "s/DATE/$DATE/" -i "" $ROOT_DIR/$FILE
sed -e "s/URL/$URL_TITLE/" -i "" $ROOT_DIR/$FILE
sed -e "s/CATEGORY/$CATEGORY/" -i "" $ROOT_DIR/$FILE

mkdir $ROOT_DIR/$IMAGES_DIR

touch index.html

code $ROOT_DIR/$FILE