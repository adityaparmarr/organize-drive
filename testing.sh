#!/bin/zsh

# generate a folder for file-sort to be run on

if [[ -d "TestFolder" ]]; then
    rm -rf TestFolder
fi
mkdir TestFolder 
cd TestFolder
touch "sub 1 - file 0"
touch "sub 1 - file 1"
touch "sub 1 - file 2"
touch "sub 1 - file 4"
touch "sub 3 - file 9"
touch "subc 1 - doc 1"
ls .


if [[ $? -eq 0 ]]; then
    echo "testing file run successfully"
fi