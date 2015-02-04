# Define clone method
elif [ "$METHOD" = "clone" ]; then

  # Check dir is empty
  checkIfDirIsEmpty

  # Set repo based on current dir
  REPO=${PWD##*/}

  # Clone repo in to current dir
  git clone git@gitlab.com:smartarts/${REPO}.git .

  # Install node/grunt/bower/composer
  installGrunt

  # Show complete text
  echo $CLONE
