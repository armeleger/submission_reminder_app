#!/bin/bash
#creating users directory 

read -p "Enter your Name: " username
if [[ -z "$username" ]]; then 
	echo "ERROR: Username cannot be empty."
fi
home_dir="submission_reminder_${username}"

#creating user's subdirectories

mkdir -p "$home_dir/app"
mkdir -p "$home_dir/modules"
mkdir -p "$home_dir/assets"
mkdir -p "$home_dir/config"


#config.env file
echo "# This is the config file
export ASSIGNMENT="Shell Navigation"
export DAYS_REMAINING=2" >"$home_dir/config/config.env"


#submissions.txt file
echo "student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Armel, Shell Navigation, not submitted
Arnold, Git, Submitted
Tito, Shell Navigation, not submitted
Seth, Shell Navigation, submitted
Elvis, Git, not submitted
" >"$home_dir/assets/submissions.txt"


#function.sh file
echo "#!/bin/bash
# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
">"$home_dir/modules/functions.sh"


#reminder.sh file
echo "#!/bin/bash
# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh
# Path to the submissions file
submissions_file="./assets/submissions.txt"
ASSIGNMENT="${ASSIGNMENT:-"Shell Navigation"}"
REM_DAYS="${REM_DAYS:-7}"
# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $REM_DAYS days"
echo "-------------------------------------------"
check_submissions "$submissions_file"
" >"$home_dir/app/reminder.sh"


#startup file
echo "#!/bin/bash
echo "Starting up the app"
./app/reminder.sh" > "$home_dir/startup.sh"


#User's Message
echo "
-----------------------------------------------
Successfully Created ${username}'s Directory
-----------------------------------------------
"
#changing permissions

chmod +x "$home_dir/modules/functions.sh"
chmod +x "$home_dir/startup.sh"
chmod +x "$home_dir/app/reminder.sh"
