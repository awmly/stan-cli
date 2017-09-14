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
  if [[ "$(git ls-remote git@gitlab.com:applieddigital/${REPO}.git 2> /dev/null)" == *"HEAD"* ]]; then

    git clone git@gitlab.com:applieddigital/${REPO}.git .

  elif [[ "$(git ls-remote git@gitlab.com:smartarts/${REPO}.git 2> /dev/null)" == *"HEAD"* ]]; then

    git clone git@gitlab.com:smartarts/${REPO}.git .

  elif [[ "$(git ls-remote git@gitlab.com:smartarts/${REPOOLD}.git 2> /dev/null)" == *"HEAD"* ]]; then

    git clone git@gitlab.com:smartarts/${REPOOLD}.git .

  fi

  # Install node/bower/composer dependencies
  stan dependencies

  # Build JS/CSS libraries
  stan build

  # Show complete text
  echo $HR
  echo $CLONE
  echo $CLONE2
  echo $HR
