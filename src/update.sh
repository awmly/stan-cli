# Define update method
elif [ "$METHOD" = "update" ]; then

  if [ "${ARGS[1]}" = "global" ]; then

    wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan
    chmod +x stan
    mv stan /usr/bin

  else

    wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan-cli -O ./stan-cli
    chmod +x stan-cli

  fi
