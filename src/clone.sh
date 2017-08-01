# Define clone method
elif [ "$METHOD" = "clone" ]; then

  # Check dir is empty
  checkIfDirIsEmpty

  # Remove git directory created by github app
  rm -rf .git

  # Set repo based on current dir
  REPO=${PWD##*/}
  REPOOLD=$(echo "${PWD##*/}" | sed 's/\./-/g')

  # Clone repo in to current dir
  git clone git@gitlab.com:applieddigital/${REPO}.git . || git@gitlab.com:smartarts/${REPO}.git . || git clone git@gitlab.com:smartarts/${REPOOLD}.git . 

  # Install node/bower/composer dependencies
  stan dependencies

  # Build JS/CSS libraries
  stan build

  # Show complete text
  echo $HR
  echo $CLONE
  echo $CLONE2
  echo $HR
