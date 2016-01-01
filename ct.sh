#!bin/bash

x=$(date +%H)
t=", the time is $(date +%H:%M)!"

if [ $x -gt 19 ] || [ $x -lt 3 ]
then
    cowsay -f duck "Good night $t"
elif [ $x -gt 15 ]
then
    cowsay -f duck "Good evening $t"
elif [ $x -gt 11 ]
then
    cowsay -f duck "Good afternoon $t" 
elif [ $x -gt 3 ]
then
    cowsay -f duck "Good morning $t" 
fi
 echo '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'