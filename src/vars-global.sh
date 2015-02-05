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
INIT="${HR}\n${GREEN}✔ INIT COMPLETE ${RESET}\nLocal server now initialised - Edit httpdocs/config/config.php and then run 'stan install'\n${HR}"
INITREMOTE="${HR}\n${GREEN}✔ INIT REMOTE COMPLETE ${RESET}\nRemote server is now configured - close the window and initialise local server\n${HR}"
INSTALL="${HR}\n${GREEN}✔ INSTALL COMPLETE ${RESET}\nProject is now installed and set up - run stan to start developing\n${HR}"
CLONE="${HR}\n${GREEN}✔ CLONE COMPLETE ${RESET}\nProject is now installed and set up - run stan to start developing\n${HR}"

# Set error strings
NOTEMPTY="${HR}\n${RED}ERROR ${RESET}\nDirectory is not empty\n${HR}"
NOSTAN="${HR}\n${RED}ERROR ${RESET}\nSTAN CLI is not installed - use grunt commands instead\n${HR}"
