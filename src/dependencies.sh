# Define dependencies method
elif [ "$METHOD" = "dependencies" ]; then

  # Install node modules
  npm install

  # Install bower components
  bower install

  # Install PHP classes
  composer install
