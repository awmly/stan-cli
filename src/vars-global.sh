# Get passed arguments
METHOD="$1"
#ARGS=("$@")

# Set vars
HR===============================================

# Set text colours
GREEN=`tput setaf 2`
RED=`tput setaf 1`
RESET=`tput sgr0`

# Set complete strings
INIT="${GREEN}✔ INIT COMPLETE ${RESET}"
INIT2="Local server now initialised - Edit httpdocs/config/config.php and then run 'stan install'"
REMOTE="${GREEN}✔ INIT REMOTE COMPLETE ${RESET}"
REMOTE2="Remote server is now configured - close the window and initialise local server"
INSTALL="${GREEN}✔ INSTALL COMPLETE ${RESET}"
INTSALL2="Project is now installed and set up - run stan to start developing"
CLONE="${GREEN}✔ CLONE COMPLETE ${RESET}"
CLONE2="Project is now installed and set up - run stan to start developing"

# Set error strings
NOTEMPTY="${RED}ERROR ${RESET}"
NOTEMPTY2="Directory is not empty"
NOSTAN="${RED}ERROR ${RESET}"
NOSTAN2="STAN CLI is not installed - use grunt commands instead"

# Set Propts
UPDATEPROMPT="This will update the local copy of stan-cli overwriting any custom methdos for current project - are you sure?"
