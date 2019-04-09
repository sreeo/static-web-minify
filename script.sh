#!/bin/sh
npm install html-minifier -g &&
# Configuration
YUICOMPRESSOR_PATH="yui.jar"

# if you want to enable it for specific directory set it here, by default its current dir
CURRENT_DIR=$PWD

# First argument must be either css / js
#TYPE=$1

DIRE=$1
# Status messages
ERROR_DISPLAY="\t\033[31;40m\033[1m[error]\033[0m"
OK_DISPLAY="\t\033[1;32;40m\033[1m[ok]\033[0m"

create_directory_if_not_exist() {
  # check if directory exists
  if [ ! -d $1 ];
  then
   mkdir -p $1 >/dev/null 2>&1 ||  echo "Error: Failed to create $1 directory. $ERROR_DISPLAY"
  fi
}

# [ -d $DIRE ] && \
#  echo "First argument missing, it should be a folder. $ERROR_DISPLAY" && \
#  exit 0

# [ $TYPE != 'js' ] && [ $TYPE != 'css' ] && \
 # echo "First argument must be either css or js. $ERROR_DISPLAY" && \
 # exit 0

[ -z $YUICOMPRESSOR_PATH ] || [ ! -f $YUICOMPRESSOR_PATH ] && \
  echo "YUICOMPRESSOR_PATH must be correctly set. $ERROR_DISPLAY" && \
  exit 0
create_directory_if_not_exist dist

cp -R "$1"/* dist

CURRENT_DIR=$PWD/dist
echo "Minifying all $TYPE files recursively in $CURRENT_DIR $OK_DISPLAY"
for TYPE in js css
  do
    for file in `find $CURRENT_DIR -name "*.$TYPE"`
      do   
        # Get the current file directory
        FILE_DIRECTORY=$(dirname $file)
        # Get the basename of the current directory
        BASE_DIR_NAME=`basename $FILE_DIRECTORY`

        
          # Get the current file name
          BASE_FILE_NAME=`basename $file`
          MINIFIED_FILE_NAME=${BASE_FILE_NAME%$TYPE}$TYPE
          # Minified directory path for the current file
          MINIFIED_FILE_DIRECTORY="$FILE_DIRECTORY"
          create_directory_if_not_exist $MINIFIED_FILE_DIRECTORY

          MINIFIED_OUTPUT_FILE="$MINIFIED_FILE_DIRECTORY/$MINIFIED_FILE_NAME"
          echo "Compressing $file $OK_DISPLAY"
          java -jar $YUICOMPRESSOR_PATH --type $TYPE -o $MINIFIED_OUTPUT_FILE $file
        
      done
  done
  html-minifier --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --use-short-doctype --minify-css true --minify-js true --input-dir dist --output-dir dist --file-ext html 