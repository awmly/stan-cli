# Define install Grunt function
installGrunt(){

  npm install
  bower install
  composer install
  grunt update

}

# Define get config var function
getConfigVar(){

  VAL="$(cat httpdocs/config/config.php | grep -m 1 $1 | cut -d \' -f 4)"
  echo $VAL;

}
