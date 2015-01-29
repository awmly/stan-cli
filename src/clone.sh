# Define clone method
if [ "$METHOD" = "clone" ]; then

  # Set repo based on current dir
  REPO=$(echo "${PWD##*/}" | sed 's/\./-/g')

  # Clone repo in to current dir
  git clone git@gitlab.com:smartarts/${REPO}.git .

  # Install node/grunt/bower/composer
  installGrunt

  # Show complete text
  echo $HR
  echo $CLONE
  echo $HR

fi
