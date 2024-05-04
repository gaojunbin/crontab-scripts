#!/bin/bash

mkdir -p $HOME/touch_in_bashrc

script_name=$HOME/touch_in_bashrc/touch_per_10_days.sh

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
            touch $1"/"$file
            traverse $1"/"$file
        else
            touch $1"/"$file
        fi
    done
}

if [ -f "$HOME/touch_in_bashrc/timestamp.txt" ]; then
    last_timestamp=$(cat $HOME/touch_in_bashrc/timestamp.txt)
    current_timestamp=$(date +%s)
    
    diff=$((current_timestamp - last_timestamp))
    # 10 days (864000s)
    if [ $diff -ge 864000 ]; then
        traverse '"$folder"'
        current_time=$(date +"%Y-%m-%d %H:%M:%S")

        echo "Execution time: $current_time" >> $HOME/touch_in_bashrc/keep_scratch.log
        echo 'Folder: "$folder"' >> $HOME/touch_in_bashrc/keep_scratch.log

        date +%s > $HOME/touch_in_bashrc/timestamp.txt
    fi
else
    traverse '"$folder"'
    current_time=$(date +"%Y-%m-%d %H:%M:%S")

    echo "Execution time: $current_time" >> $HOME/touch_in_bashrc/keep_scratch.log
    echo 'Folder: "$folder"' >> $HOME/touch_in_bashrc/keep_scratch.log

    date +%s > $HOME/touch_in_bashrc/timestamp.txt
fi

' > $script_name

# Add execute permissions to the script
chmod +x $script_name

echo '# >>>>>> update timestamp per 10 dayas >>>>>>' >> ~/.bashrc
echo sh $script_name >> ~/.bashrc
echo '# <<<<<< update timestamp per 10 dayas <<<<<<' >> ~/.bashrc

echo 'Generate successfully!'

