# Define build method
elif [ "$METHOD" = "build" ]; then

  # Check bower dependencies are up to date
  bower install

  # Copy jQuery from bower components to project
  mkdir -p httpdocs/assets/frontend/libs/jquery/ && cp bower_components/jquery/dist/jquery.min.js httpdocs/assets/frontend/libs/jquery/

  # Copy font awesome from bower components to project
  mkdir -p httpdocs/assets/frontend/libs/fontawesome/css/ && cp bower_components/fontawesome/css/font-awesome.min.css httpdocs/assets/frontend/libs/fontawesome/css/
  mkdir -p httpdocs/assets/frontend/libs/fontawesome/fonts/ && cp bower_components/fontawesome/fonts/* httpdocs/assets/frontend/libs/fontawesome/fonts/
  mkdir -p httpdocs/cache/fonts && cp bower_components/fontawesome/fonts/* httpdocs/cache/fonts

  # Load grunt build task - this will build our css/js files
  grunt build
