scrj.sh
=======

Latest version = 0.5

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
$ scrj.sh

    Video Screenshot Frame Saver
    scrj.sh version 0.5

    usage: scrj.sh -p [path] -t mm:ss [optional: -r [size] -a]

    scrj.sh must have at least 2 arguments.
    Try help with scrj.sh -h


$ scrj.sh -h

    Video Screenshot Frame Saver
    scrj.sh version 0.5

    (NOTE: mplayer must be installed for script to work
           and optionally imagemagick for convert)

    scrj.sh will take 1 frame from each video (*.m*) in a directory,
           (using mplayer) and save a jpg image with the same name.

           You can optionally use convert to resize the image.

    usage: scrj.sh -p [path] -t mm:ss [optional: -r [size] -a]

    required:
          -p vids =  directory path
          -t 5:15 =  take frame at minute:second

    optional:
          -r 200  =  resize to width of 200 (using convert)
          -a      =  all videos in directory (overwrite existing jpg)
                     [default is new jpg if none exists]

```

Author
======

Joseph Archer (C) 2018


License
=======

The code is covered by the MIT.
