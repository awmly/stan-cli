# Define install-server method
if [ "$METHOD" = "install-remote" ]; then

  # Get user and group info
  USER="$(whoami)";
  GROUP="$(id -g -n $USER)";

  sudo mkdir uploads
  sudo chmod 0777 uploads
  sudo chmod g+w httpdocs/
  sudo rm -rf httpdocs/*
  sudo chown ${USER}:${GROUP} httpdocs/. httpdocs/..
  echo "Remote server configured"
fi
