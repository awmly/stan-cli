else

  # Check if stan-cli file exists
  if [ -f "stan-cli" ]; then

    # Load local stan-cli in project
    ./stan-cli $@

  else

    # Show error text
    echo $HR
    echo $NOSTAN
    echo $NOSTAN2
    echo $HR
    exit 1

  fi

fi
