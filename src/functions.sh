# Define install Grunt function
installGrunt(){

  npm install
  bower install
  composer install
  grunt update

}


# Define check if dir is empty function
checkIfDirIsEmpty(){

  # Check if dir is empty - except for git folder auto created by github app
  if  [ "$(ls -A | grep -v .git)" ]; then
    echo -e $NOTEMPTY
    exit 1
  fi

}


# Define check if stan is installed function
checkIfStanIsInstalled(){

  # Check if stan-cli file exists
  if [ ! -f "./stan-cli" ]; then
    echo -e $NOSTAN
    exit 1
  fi

}


# Define get config var function
getConfigVar(){

  # Include config file and echo out variable - discard any php warnings/notices
  php -r "include('httpdocs/config/config.php'); echo ${1};" 2> /dev/null

}


# Define prompt function
prompt(){

  # Confirm deployment
  echo -e ${1}

  # Show Y/N choices
  select YN in "Yes" "No"; do
      case $YN in
          Yes ) break;;
          No ) exit;;
      esac
  done

}
