# Keep Scatch

Use crontab to execute a timed task to update the timestamps of files in a specified folder.

## Usage

1. Step 1

   Just run:

   ```
   curl -s https://raw.githubusercontent.com/gaojunbin/crontab-scripts/master/keep_scratch.sh -o ~/keep_scratch.sh && bash keep_scratch.sh && rm ~/keep_scratch.sh
   ```

2. Step 2

   ```
   # edit crontab config file
   crontab -e
   
   #Add the script into the crontab config file
   0 0 * * * $script_name
   ```

   

