scrj.sh
=======

Latest version = 0.4

Simple bash script to save a screenshot of a video.

###Mplayer (required)

By default, it will take a directory and use mplayer to save one frame from each video as video-name.jpg.
It uses the video extension filter of ```*.m*```. (examples: .mp4, .mkv, .m4v)

###Imagemagick (optional)

If -r option is used, imagemagick must be installed, because it uses _convert_ to resize.

By default, it will not take new screenshots of videos each time, only new ones.

Example
=======

```
$ ./scrj.sh -h
./scrj.sh version 0.4
(mplayer must be installed and optionally imagemagick for convert)
./scrj.sh will take 1 frame from each video (*.m*) in a directory,
       and save a jpg image with the same name.
./scrj.sh -p [path] -t mm:ss [options]
required:
      -p vids =  directory path
      -t 5:15 =  take frame at minute:second
optional:
      -r 200  =  resize to width of ? (using convert)
      -a      =  all videos in directory
                 [default is new videos only]

```

Author
======

Joseph Archer (C) 2014


License
=======

The code is covered by the MIT.
