# scripts/draft.sh "<title>" <category>
# category (option: post by default): post, talk

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR=$SCRIPT_DIR/..

TITLE=$1
CATEGORY=$2

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

BRANCH="post/$URL_TITLE"
FILE="_drafts/$URL_TITLE.md"
IMAGES_DIR="images/$URL_TITLE"

echo "Creating post draft [$TITLE]"
echo "With url [$URL_TITLE]"
echo "And images directory [$IMAGES_DIR]"
echo "And category [$CATEGORY]"
echo "On branch [$BRANCH]"
echo "And file [$FILE]"

git checkout main
git pull
git checkout -b $BRANCH
git push --set-upstream origin $BRANCH
cp $ROOT_DIR/_templates/draft.md $ROOT_DIR/$FILE

sed -e "s/TITLE/$TITLE/" -i "" $ROOT_DIR/$FILE
sed -e "s/URL/$URL_TITLE/" -i "" $ROOT_DIR/$FILE
sed -e "s/CATEGORY/$CATEGORY/" -i "" $ROOT_DIR/$FILE

mkdir $ROOT_DIR/$IMAGES_DIR

$SCRIPT_DIR/refresh-index.sh

code $ROOT_DIR/$FILE