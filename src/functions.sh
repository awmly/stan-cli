# Define install Grunt function
installGrunt(){
  npm install
  bower install
  composer install
  grunt update
}
