#!/usr/bin/bash


l=1

while [ $l -le 2 ]
do

    for file in /home/rhohman/*.tex
    do
	lualatex "$file" 
	(( l++ ))
    done
done

# for file in /home/rhohman/*.dvi
# do
#     dvipdf "$file" 
    
# done

