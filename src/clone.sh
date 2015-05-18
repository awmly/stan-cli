# Define clone method
elif [ "$METHOD" = "clone" ]; then

  # Check dir is empty
  checkIfDirIsEmpty

  # Remove git directory created by github app
  rm -rf .git

  # Set repo based on current dir
  REPO=${PWD##*/}

  # Clone repo in to current dir
  git clone git@gitlab.com:smartarts/${REPO}.git .

  # Install node/bower/composer dependencies
  stan dependencies

  # Build JS/CSS libraries
  stan build

  # Show complete text
  echo $HR
  echo $CLONE
  echo $CLONE2
  echo $HR
