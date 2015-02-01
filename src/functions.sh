# Define install Grunt function
installGrunt(){

  npm install
  bower install
  composer install
  grunt update

}

# Check if stan is installed
checkIfDirIsEmpty(){

  if  [ "$(ls -A)" ]; then
    echo $HR
    echo $NOTEMPTY
    echo $HR
    exit 1
  fi

}

# Check if stan is installed
checkIfStanIsInstalled(){

  if [ ! -f "./stan-cli" ]; then
    echo $HR
    echo $NOSTAN
    echo $HR
    exit 1
  fi

}
# Define get config var function
getConfigVar(){

  VAL="$(cat httpdocs/config/config.php | grep -m 1 $1 | cut -d \' -f 4)"
  echo $VAL;

}
