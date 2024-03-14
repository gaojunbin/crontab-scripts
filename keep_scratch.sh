#!/bin/bash

mkdir -p $HOME/crontab_scripts

script_name=$HOME/crontab_scripts/$(date +%Y%m%d%H%M%S).sh

echo "Folder to keep (absolute path): "
read folder

# Check if the input is a directory
if [ ! -d "$folder" ]; then
    echo "Error: $folder is not a directory or does not exist."
    exit 1
fi

echo '
#!/bin/bash
function traverse() {
    for file in `ls $1`
    do
        if [ -d $1"/"$file ]
        then
            traverse $1"/"$file
        else
            touch $1"/"$file
        fi
    done
}

traverse '"$folder"'
current_time=$(date +"%Y-%m-%d %H:%M:%S")

echo "Execution time: $current_time" >> $HOME/crontab_scripts/keep_scratch.log
echo 'Folder: "$folder"' >> $HOME/crontab_scripts/keep_scratch.log

' > $script_name

# Add execute permissions to the script
chmod +x $script_name

# Define colors for the table
W="\033[1;37m" # WHITE
B="\033[1;34m" # BLUE
G="\033[1;32m" # GREEN
R="\033[1;31m" # RED
GY="\033[1;30m" # GREY
Z="\033[0m" # reset

script_name_length=${#script_name}

# Calculate the padding for alignment
padding_l=$(( (60 - script_name_length) / 2 ))
padding_r=$(( 60 - script_name_length - padding_l ))

# Start of the table
echo -e "${B}+--------------------------------------------------------------------------+${Z}"
echo -e "${B}|${W} NSCC Script Generation Information @ LiuLab                              ${B}|${Z}"
echo -e "${B}+--------------------------------------------------------------------------+${Z}"
echo -e "${B}|${W} The script has been generated successfully.                              ${B}|${Z}"
echo -e "${B}|${W} Please add it to the scheduled task, such as:                            ${B}|${Z}"
echo -e "${B}+--------------------------------------------------------------------------+${Z}"
echo -e "${B}|${GY} 1. Edit crontab file:                                                    ${B}|${Z}"
echo -e "${B}|${W} ${GY}                    \$ ${G}crontab -e                                      ${Z}   ${B}|${Z}"
echo -e "${B}|${GY} 2. Enter a scheduled task:                                               ${B}|${Z}"
echo -e "${B}|${W} ${G}$(printf '%*s' $padding_l)0 0 * * * $script_name$(printf '%*s' $padding_r)${Z}   ${B}|${Z}"
echo -e "${B}+--------------------------------------------------------------------------+${Z}"