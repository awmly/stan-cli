# Define init-remote method
elif [ "$METHOD" = "remote" ]; then

  # Get user and group info
  USER="$(whoami)";
  GROUP="$(id -g -n $USER)";

  # Move httpdocs/staging to plesk default
  sudo mkdir plesk-default
  sudo mv httpdocs plesk-default/httpdocs
  sudo mv staging plesk-default/staging

  # Create new httpdocs directory and change permissions
  sudo mkdir httpdocs
  sudo chown ${USER}:${GROUP} httpdocs httpdocs/. httpdocs/..

  # Create new staging directory and change permissions
  sudo mkdir staging
  sudo chown ${USER}:${GROUP} staging staging/. staging/..

  # Create new database directory and change permissions
  sudo mkdir database
  sudo chown ${USER}:${GROUP} database database/. database/..

  # Create new snapshots directory and change permissions
  sudo mkdir snapshots
  sudo chown ${USER}:${GROUP} snapshots snapshots/. snapshots/..

  # Create new scripts directory and change permissions
  sudo mkdir scripts
  sudo chown ${USER}:${GROUP} scripts scripts/. scripts/..

  # Create stan-cli file and change permission
  sudo touch stan-cli
  sudo chown ${USER}:${GROUP} stan-cli
  sudo chmod 0700 stan-cli

  # Create uploads directory
  sudo mkdir uploads uploads/images uploads/downloads
  sudo chmod -R 0777 uploads

  # Show complete text
  echo $HR
  echo $REMOTE
  echo $REMOTE2
  echo $HR
