

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR=$SCRIPT_DIR/..

TITLE=$1
PDF_FILE=$2

if [ -z "$TITLE" ]
then
    echo "Not post title provided"
    exit 1
fi

if [ -z "$PDF_FILE" ]
then
    echo "Not pdf slidedeck file provided"
    exit 1
fi

if [ $(head -c 4 "$PDF_FILE") != "%PDF" ]; then
    echo "It's not a PDF file!"
    exit 1
fi

URL_TITLE=`$SCRIPT_DIR/slugify.sh "$TITLE"`

SLIDE_DECK_DIR=$ROOT_DIR/slidedecks/$URL_TITLE
SLIDE_DECK_FILE=$SLIDE_DECK_DIR/$URL_TITLE.pdf
SLIDE_DECK_IMAGES_DIR=$SLIDE_DECK_DIR/slides
SLIDE_DECK_IMAGES_FILES=$SLIDE_DECK_IMAGES_DIR/slide-%03d.png
SLIDE_DECK_HTML=$SLIDE_DECK_DIR/index.html

# Creating slidedeck directory and subdirectory
echo "Creating $SLIDE_DECK_DIR and $SLIDE_DECK_IMAGES_DIR directories"
mkdir $SLIDE_DECK_DIR
mkdir $SLIDE_DECK_IMAGES_DIR

# Adding index.html file
echo "Adding index.html file"
cp $ROOT_DIR/_templates/index.html $SLIDE_DECK_HTML
sed -e "s/DECK/$URL_TITLE/" -i "" $SLIDE_DECK_HTML

# Copying PDF deck to folder
echo "Copying $PDF_FILE to $SLIDE_DECK_FILE"
cp "$PDF_FILE" "$SLIDE_DECK_FILE"

# Converting PDF to image with ImageMagick
echo "Generating images $SLIDE_DECK_IMAGES_FILES"
convert $SLIDE_DECK_FILE $SLIDE_DECK_IMAGES_FILES

