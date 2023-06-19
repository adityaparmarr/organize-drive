#!/bin/zsh

# generate a folder for file-sort to be run on

if [[ -d "bruh/TestFolder" ]]; then
    rm -rf bruh/TestFolder
fi
mkdir bruh
mkdir bruh/TestFolder 
cd bruh/TestFolder
touch "sub 1 - file 0"
touch "sub 1 - file 1"
touch "sub 1 - file 2"
touch "sub 1 - file 4"
touch "sub 3 - file 9"
touch "sub 3 - file 10"
touch "sub 3 - file 11"
touch "subc 1 - doc 1"
touch "subc 1 - doc 100"
# ls .

if [[ $? -eq 0 ]]; then
    echo "testing file run successfully"
fi