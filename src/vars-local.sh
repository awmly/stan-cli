# Get passed arguments
METHOD="$1";
ARGS=("$@");

# Set vars
HR===============================================;

# Set text colours
GREEN=`tput setaf 2`
RED=`tput setaf 1`
RESET=`tput sgr0`

# Set complete strings
UPLOAD="${GREEN}✔ UPLOAD COMPLETE ${RESET}"
SYNCREMOTE="${GREEN}✔ LOCAL DATABASE SYNCED TO REMOTE ${RESET}"
SYNCLOCAL="${GREEN}✔ REMOTE DATABASE SYNCED TO LOCAL ${RESET}"
REBASE="${GREEN}✔ REBASE COMPLETE ${RESET}"
