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
UPLOAD="${HR}\n${GREEN}✔ UPLOAD COMPLETE ${RESET}\n${HR}"
REBASE="${HR}\n${GREEN}✔ REBASE COMPLETE ${RESET}\n${HR}"
IMPORT="${HR}\n${GREEN}✔ DATABASE IMPORTED ${RESET}\n${HR}"
EXPORT="${HR}\n${GREEN}✔ DATABASE EXPORTED ${RESET}\n${HR}"
DBCONF="${HR}\n${GREEN}✔ DATABASE CONFIG FILES CREATED ${RESET}\n${HR}"
SNAPSHOT="${HR}\n${GREEN}✔ SNAPSHOT CREATED ${RESET}\n${HR}"
DEPLOY="${HR}\n${GREEN}✔ SITE DEPLOYED TO PRODUCTION ${RESET}\n${HR}"
RESTORE="${HR}\n${GREEN}✔ RESTORE COMPLETE ${RESET}\n${HR}"
OPTIMISE="${HR}\n${GREEN}✔ IMAGE OPTIMISATION COMPLETE ${RESET}\n${HR}"

# Set error strings
NOTFOUND="${HR}\n${RED}COMMAND NOT FOUND${RESET}\n${HR}"
RESTOREERROR="${HR}\n${RED}RESTORE SNAPSHOT NOT FOUND${RESET}\nPlease ensure snapshots/restore.tar.gz exists\n${HR}"

# Set Propts
DEPLOYPROMPT="This will copy the staging database and httpdocs to the production server - are you sure?"
RESTOREPROMPT="This will delete the current production server and restore it from a snapshot - are you sure?"
