#!/bin/bash

version='0.4'

resize=
all=
mmss=
dopath=

# check for at least 2 arguments, or help
if [ "$#" -lt 2 ]; then
   if [ $1 ] && [ $1 == '-h' ]; then
      echo "$0 version $version"
   else
      echo "$0 must have at least 2 arguments."
      echo "Try help with $0 -h"
      exit 1
   fi
fi

# set variables or show help
while getopts :hr:at:p: opt; do
  case $opt in
  h)
      echo "(mplayer must be installed and optionally imagemagick for convert)"
      echo "$0 will take 1 frame from each video (*.m*) in a directory,"
      echo "       and save a jpg image with the same name."
      echo "$0 -p [path] -t mm:ss [options]"
      echo "required:"
      echo "      -p vids =  directory path"
      echo "      -t 5:15 =  take frame at minute:second"
      echo "optional:"
      echo "      -r 200  =  resize to width of ? (using convert)"
      echo "      -a      =  all videos in directory"
      echo "                 [default is new videos only]"
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
      echo "Try help with $0 -h"  >&2
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
