#!/bin/bash
# Check if any files exist in the current directory (excluding hidden files)
# using find and limiting to depth 1 and excluding hidden and only files

# Workaround for document name containing ' ' (spaces) : 
#   remove all spaces, and replace "/Users" with temporary delimiter ':' using sed
#   then, replace the delimiter with new line using tr
p=./folder
f=`find ~+/$p -maxdepth 1 -type f ! -name '.*' | tr -d ' '`
FILES=`echo $f | sed 's,/Users,:,g' | tr ':' '\n'`
# TODO: find a way to separate the paths (potentially)
if [[ -n $FILES ]]
then
    echo "YES unsorted files"
    # Loop through all the FILES 
    for file in $FILES; do
        # get the last dash in the path (avoiding the ones in the parent dir)
        dashindex=`echo $file | tr -cd '-' | wc -c`
        fullpath=`echo $file | cut -d'-' -f $dashindex`
        # get how many levels deep this file is
        pos=`echo $fullpath | tr -cd '/' | wc -c`
        # use the depth to substring the path to get the subject name
        sub=`echo $fullpath | cut -d'/' -f $((pos + 1))`
        echo sub = $sub
        
        # Get Department Name and Course Number from sub
        deptname=`echo $sub | tr -d '0-9'`
        coursenum=`echo $sub | tr -dc '0-9'`
        tmp=`echo $deptname | tr 'a-z' 'A-Z'`
        foldername="$tmp-$coursenum"
        echo deptname = $deptname
        echo foldername = $foldername

        # Reconstruct the file name
        filename=`find $p -type f -iname "$deptname*" `
        echo filename = $filename
        echo p/foldername = $p/$foldername
        # Check if the corresponding subject folder already exists
        if [ -d $p/$foldername ]; then
            echo yes it is a folder
            echo current location = "$filename"
            echo goal location = "$p/$foldername"
            mv "$filename" "$p/$foldername"
        else 
            echo folder does not exist
            mkdir $p/$foldername
            echo current location = "$filename"
            echo goal location = "$p/$foldername"
            mv "$filename" "$p/$foldername"
        fi
        echo
    done
else 
    echo "no files"
fi
