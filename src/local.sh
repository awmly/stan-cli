else

  # Check stan is installed
  checkIfStanIsInstalled

  # Load local stan-cli in project
  ./stan-cli $@

fi
