# Define build method
elif [ "$METHOD" = "build" ]; then

  # Check bower dependencies are up to date
  bower install

  # Load grunt build task - this will build our css/js files
  grunt build || grunt update
