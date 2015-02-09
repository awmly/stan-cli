# Define update method
elif [ "$METHOD" = "update" ]; then

  if [ "${ARGS[1]}" = "global" ]; then

    # Download from github
    wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan -O /usr/bin/stan

    # Set permissions
    chmod +x /usr/bin/stan

  else

    # Confirm update
    prompt "$UPDATEPROMPT"

    # Download from github
    wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan-cli -O ./stan-cli

    # Set permissions
    chmod +x stan-cli

  fi
