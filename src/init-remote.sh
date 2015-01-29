# Define init-remote method
if [ "$METHOD" = "init-remote" ]; then

  # Get user and group info
  USER="$(whoami)";
  GROUP="$(id -g -n $USER)";

  # Move httpdocs to plesk default
  sudo mv httpdocs/ plesk-default/

  # Create new httpdocs directory and change permissions
  sudo mkdir httpdocs
  sudo chown ${USER}:${GROUP} httpdocs httpdocs/. httpdocs/..

  # Create uploads directory
  sudo mkdir uploads
  sudo chmod 0777 uploads

  # Show complete text
  echo $HR
  echo $INITREMOTE
  echo $HR

fi
