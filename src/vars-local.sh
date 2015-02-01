# Get passed arguments
METHOD="$1";
ARGS=("$@");

# Set vars
HR===============================================;

# Set text colours
GREEN=`tput setaf 2`
RESET=`tput sgr0`

# Set complete strings
INIT="${GREEN}✔ INIT COMPLETE ${RESET}\nLocal server now initialised - Edit httpdocs/config/config.php and then run 'stan install'"
INITREMOTE="${GREEN}✔ INIT REMOTE COMPLETE ${RESET}\nRemote server is now configured - close the window and initialise local server"
INSTALL="${GREEN}✔ INSTALL COMPLETE ${RESET}\nProject is now installed and set up - run the grunt command to start developing"
CLONE="${GREEN}✔ CLONE COMPLETE ${RESET}\nProject is now installed and set up - run the grunt command to start developing"

STANEXISTS="STAN is already installed - exiting"
NOSTAN="STAN is not installed - use grunt commands instead"
