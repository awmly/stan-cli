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
UPLOAD="${HR}\n${GREEN}✔ UPLOAD COMPLETE ${RESET}\n${HR}"
REBASE="${HR}\n${GREEN}✔ REBASE COMPLETE ${RESET}\n${HR}"
IMPORT="${HR}\n${GREEN}✔ DATABASE IMPORTED ${RESET}\n${HR}"
EXPORT="${HR}\n${GREEN}✔ DATABASE EXPORTED ${RESET}\n${HR}"
DBCONF="${HR}\n${GREEN}✔ DATABASE CONFIG FILES CREATED ${RESET}\n${HR}"
NOTFOUND="${HR}\n${RED}COMMAND NOT FOUND${RESET}\n${HR}"
