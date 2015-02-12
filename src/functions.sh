# Define get config var function
getConfigVar(){

  if [ -f "staging/config/config.php" ]; then

    DIR="staging/"

  else

    DIR="httpdocs/"

  fi

  # Include config file and echo out variable - discard any php warnings/notices
  php -r "include('${DIR}/config/config.php'); echo ${1};" 2> /dev/null

}

# Define prompt function
prompt(){

  # Confirm
  echo "${1}"

  # Show Y/N choices
  select YN in "Yes No"
  do
      case $YN in
          Yes ) break;;
          No ) exit;;
      esac
  done

}

# Define check if dir is empty function
checkIfDirIsEmpty(){

  # Check if dir is empty - except for git folder auto created by github app
  if  [ "$(ls -A | grep -v .git)" ]; then
    echo $HR
    echo "$NOTEMPTY"
    echo "$NOTEMPTY2"
    echo $HR
    exit 1
  fi

}
