# static-web-minify

1) This is a shell script that'll minify your css/js/html files in your web project.
2) Make sure Java (preferrably JDK 8) is installed as this script uses <a href="https://github.com/yui/yuicompressor">YUICompressor</a> for minifying/uglifying files.
3) Give executable permissions to the shell script (chmod u+x script.sh).
4) Execute the script with a parameter which is your static web project you want to minify. Eg : ./script.sh example-project/
5) The minified HTML/CSS/JS files will be outputted to a new folder dist/. Folder structure and hierarchies are not modified. Files are minified recursively.
