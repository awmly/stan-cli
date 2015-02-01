# Define update method
elif [ "$METHOD" = "update" ]; then

  wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan
  chmod +x stan
  mv stan /usr/bin
