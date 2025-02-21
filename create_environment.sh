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
cat << "EOF" > "$home_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

#submissions file file
cat << "EOF" > "$home_dir/assets/submissions.txt" 
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Armel, Shell Navigation, not submitted
Arnold, Git, Submitted
Tito, Shell Navigation, not submitted
Seth, Shell Navigation, submitted
Elvis, Git, not submitted
EOF


#function.sh file
cat << "EOF" > "$home_dir/modules/functions.sh"
#!/bin/bash
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
EOF


#reminder.sh file
cat << "EOF" > "$home_dir/app/reminder.sh" 
#!/bin/bash
#!/bin/bash
# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh
# Path to the submissions file
submissions_file="./assets/submissions.txt"
# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"
check_submissions $submissions_file
EOF


#startup file
cat << "EOF" > "$home_dir/startup.sh"
#!/bin/bash
./app/reminder.sh
EOF


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
