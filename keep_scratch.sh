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

echo "The script is generated successfully, please add it to the scheduled task, such as:"
echo "crontab -e"
echo "0 0 * * * $script_name"
