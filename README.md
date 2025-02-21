# Submission Reminder App

This is a shell-based application that helps manage student submissions for assignments. 
The application provides reminders for students who have not submitted their assignments, 
and it is structured to simulate a real-world application environment.


To set up the submission reminder application, follow these steps:

# 1. Clone the Repository

First, clone the repository to your local machine.
git clone https://github.com/armeleger/submission_reminder_app_armeleger.git

# 2. Run the create_environment.sh Script

cd submission_reminder_app_armeleger
chmod +x create_environment.sh

Then after run the script: ./create_environment.sh

Then, 
You will be prompted to enter your name, Followed by a this message
-----------------------------------------------
Successfully Created {yourname} Directory
-----------------------------------------------
The script will create a directory structure named submission_reminder_{yourName}. 
This directory will contain the following files and subdirectories and files inside:

"config" directory with a "config.env" file.
"assets" directory with a "submissions.txt" file.
"modules" directory with a "functions.sh" file.
And a "startup.sh" file.


# 3. Make startup.sh Executable

chmod +x startup.sh

# 4. Run the Application

./startup.sh

# For Clarification 

File Structure
The directory structure created by create_environment.sh looks like this:

submission_reminder_{yourName}
├── app/
├── modules/
│   └── functions.sh
├── assets/
│   └── submissions.txt
└── config/
    └── config.env

