#!/bin/zsh

# Check if any files exist in the current directory (excluding hidden files)
# using find and limiting to depth 1 and excluding hidden and only files

# Workaround for document name containing ' ' (spaces) : 
#   remove all spaces, and replace "/Users" with temporary delimiter ':' using sed
#   then, replace the delimiter with new line using tr
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi
p=$1
echo $p

f=`find $p -maxdepth 1 -type f ! -name '.*' | tr -d ' '`
FILES=`echo $f | sed 's,/Users,:,g' | tr ':' '\n'`

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
        # use the depth to substring the path to get the course name/number
        course=`echo $fullpath | cut -d'/' -f $((pos + 1))`
        # echo course = $course
        
        # Get Department Name and Course Number from course
        deptname=`echo $course | tr -d '0-9'`
        coursenum=`echo $course | tr -dc '0-9'`
        tmp=`echo $deptname | tr 'a-z' 'A-Z'`
        foldername="$tmp-$coursenum"
        # echo deptname = $deptname
        # echo foldername = $foldername

        # Reconstruct the file name
        filename=`find $p -type f -iname "$deptname $coursenum -*" | head -n 1`
        if [[ -f $filename ]] 
        then
            mv "$filename" "$file"
        fi
        echo file = $file
        # if the folder already exists then simply move the file
        if [ -d $p/$foldername ]; then
            echo folder exists
            echo current location = "$file"
            echo goal location = "$p/$foldername"
            mv "$file" "$p/$foldername"
        # if the folder doesn't exist, create the folder and then move the file
        else 
            echo creating folder
            mkdir $p/$foldername
            echo current location = "$filename"
            echo goal location = "$p/$foldername"
            mv "$file" "$p/$foldername"
        fi
    done
else 
    echo "no files to sort"
fi