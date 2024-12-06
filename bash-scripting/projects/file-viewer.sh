#!/bin/bash

# for seeing files
# for sorting files based on words, extension, time
# seeing particular type of extension files

echo "choose the option"
echo -e "see files\nsort files"
read choice

if [[ $choice == "see files" ]]; then
    echo -e "1. all\n2. extension"
    read option
    if [[ $option == "all" ]]; then
        files=$(ls -nh)
        echo "$files"
        echo "human readable format"
    else
        echo "extension (ex - .pdf) "
        read extension
        files=$(ls -X *$extension)
        echo "$files"
        echo "result for $extension"
    fi

elif [[ $choice == "sort files" ]]; then
    echo -e "1. sort files\n2. time\n3. extension\n4. size"
    read option
    
    if [[ $option == "time" ]]; then
        files=$(ls -nht)
        echo "$files"
        echo "shown in descending order. use ls -nhtr. -r for reverse"

    elif [[ $option == "exension" ]]; then
        files=$(ls -nhX)
        echo "$files"
        echo "shown in descending order. use ls -nhX. -r for reverse"

    else
        files=$(ls -nhS)
        echo "$files"
        echo "shown files from size largest to smallest. use ls -nhS. -r for reverse"
    fi
fi