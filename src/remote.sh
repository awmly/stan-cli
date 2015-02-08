# Define init-remote method
elif [ "$METHOD" = "remote" ]; then

  # Get user and group info
  USER="$(whoami)";
  GROUP="$(id -g -n $USER)";

  # Change permissions of httpdocs
  sudo chown -R ${USER}:${GROUP} httpdocs

  # Change permissionss of staging
  sudo chown -R ${USER}:${GROUP} staging

  # Create new database directory and change permissions
  sudo mkdir database
  sudo chown -R ${USER}:${GROUP} database

  # Create new snapshots directory and change permissions
  sudo mkdir snapshots
  sudo chown -R ${USER}:${GROUP} snapshots

  # Create new scripts directory and change permissions
  sudo mkdir scripts
  sudo chown -R ${USER}:${GROUP} scripts

  # Create uploads directory
  sudo mkdir uploads uploads/images uploads/downloads
  sudo chown -R ${USER}:${GROUP} uploads
  sudo chmod -R 0777 uploads

  # Create stan-cli file and change permission
  sudo touch stan-cli
  sudo chown ${USER}:${GROUP} stan-cli
  sudo chmod 0700 stan-cli

  # Show complete text
  echo $HR
  echo $REMOTE
  echo $REMOTE2
  echo $HR
