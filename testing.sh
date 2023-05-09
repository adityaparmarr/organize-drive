#!/bin/zsh

# generate a folder for file-sort to be run on

if [[ -d "testing" ]]; then
    rm -rf testing
fi
mkdir testing 
cd testing
touch "sub 1 - file 0"
touch "sub 1 - file 1"
touch "sub 1 - file 2"
touch "sub 1 - file 4"
touch "sub 3 - file 9"
touch "subc 1 - doc 1"
ls testing


if [[ $? -eq 0 ]]; then
    echo "testing file run successfully"
fi