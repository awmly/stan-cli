# Get passed arguments
METHOD="$1"
ARGS=("$@")

# Set vars
HR===============================================

# Set text colours
GREEN=`tput setaf 2`
RED=`tput setaf 1`
RESET=`tput sgr0`

# Set complete strings
UPLOAD="${GREEN}✔ UPLOAD COMPLETE ${RESET}"
REBASE="${GREEN}✔ REBASE COMPLETE ${RESET}"
IMPORT="${GREEN}✔ DATABASE IMPORTED ${RESET}"
EXPORT="${GREEN}✔ DATABASE EXPORTED ${RESET}"
DBCONF="${GREEN}✔ DATABASE CONFIG FILES CREATED ${RESET}"
SNAPSHOT="${GREEN}✔ SNAPSHOT CREATED ${RESET}"
DEPLOY="${GREEN}✔ SITE DEPLOYED TO PRODUCTION ${RESET}"
RESTORE="${GREEN}✔ RESTORE COMPLETE ${RESET}"
OPTIMISE="${GREEN}✔ IMAGE OPTIMISATION COMPLETE ${RESET}"
HELP="For a list of available commands see - https://github.com/awomersley/stan-cli"

# Set error strings
NOTFOUND="${RED}COMMAND NOT FOUND${RESET}"
RESTOREERROR="${RED}RESTORE SNAPSHOT NOT FOUND${RESET}\nPlease ensure snapshots/restore.tar.gz exists"

# Set Propts
DEPLOYPROMPT="This will copy the staging database and httpdocs to the production server - are you sure?"
RESTOREPROMPT="This will delete the current production server and restore it from a snapshot - are you sure?"
