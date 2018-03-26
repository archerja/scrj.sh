#!/bin/bash

appname="Video Screenshot Frame Saver"
version="0.5"

shortname=$(basename $0)
fullname=$0
oneliner="usage: $shortname -p [path] -t mm:ss [optional: -r [size] -a]"
 
resize=
all=
mmss=
dopath=

# display name and version
      echo ""
      echo "    $appname"
      echo "    $shortname version $version"

# check for at least 2 arguments, or help
if [ "$#" -lt 2 ]; then
   if [ $1 ] && [ $1 == '-h' ]; then
      echo ""
   else
      echo ""
      echo "    $oneliner"
      echo ""
      echo "    $shortname must have at least 2 arguments."
      echo "    Try help with $shortname -h"
      exit 1
   fi
fi

# set variables or show help
while getopts :hr:at:p: opt; do
  case $opt in
  h)
      echo "    (NOTE: mplayer must be installed for script to work"
      echo "           and optionally imagemagick for convert)"
      echo ""
      echo "    $shortname will take 1 frame from each video (*.m*) in a directory,"
      echo "           (using mplayer) and save a jpg image with the same name."
      echo ""
      echo "           You can optionally use convert to resize the image."
      echo ""
      echo "    $oneliner"
      echo ""
      echo "    required:"
      echo "          -p vids =  directory path"
      echo "          -t 5:15 =  take frame at minute:second"
      echo ""
      echo "    optional:"
      echo "          -r 200  =  resize to width of 200 (using convert)"
      echo "          -a      =  all videos in directory (overwrite existing jpg)"
      echo "                     [default is new jpg if none exists]"
      echo ""
      exit 1
      ;;
  r)
      resize=$OPTARG
      ;;
  a)
      all=1
      ;;
  t)
      mmss=$OPTARG
      ;;
  p)
      dopath=$OPTARG
      ;;
  \?)
      echo "Invalid option: -$OPTARG"  >&2
      echo "Try help with $shortname -h"  >&2
      exit 1
      ;;
  :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))

# list arguments
echo "---------------"
if [ "$dopath" ];
  then
    echo "Argument -p specified with $dopath"
  else
    echo "Argument -p must be used!"
    exit 1
fi
if [ "$mmss" ];
  then
    echo "Argument -t specified with $mmss"
  else
    echo "Argument -t must be used!"
    exit 1
fi
if [ "$all" ]; then echo "Argument -a specified";  fi
if [ "$resize" ]; then echo "Argument -r specified with $resize";  fi
echo "---------------"

# finally begin

cd "$dopath"

# where the work is done
function screenshot {
         echo "* Reading '$1'..."
         m1=$(mplayer "$1" $2 $3 $4 $5 $6 $7 $8 2>&1)
         mv 00000001.jpg "$9"
         echo "* Created '$9'."
         if [ "$resize" ]; 
           then 
           convert "$9" -resize $resize "$9"
           echo "* Resized '$9'."
         fi
                }  

# loop through directory
for f in *.m*
do
  ff="${f%.*}.jpg"
  if [ -f "$ff" ];
  then
   echo "File '$ff' exists."
   if [ $all ];
   then
     echo "* Redoing anyway..."
     screenshot "$f" -ss "$mmss" -vo jpeg -nosound -frames 1 "$ff"
   fi
  else
   echo "* File '$ff' does not exist."
   screenshot "$f" -ss "$mmss" -vo jpeg -nosound -frames 1 "$ff"
  fi
done

# bye
