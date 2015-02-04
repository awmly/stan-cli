# Define default action
elif [ "$METHOD" = "" ]; then

  # Rebase from remote
  stan rebase

  # Update libs
  grunt update

  # Open atom
  atom ./

  # Start mysql server
  mysql.server start

  # Export current staging db and local it in to local server
  stan db exportstaging
  stan db importlocal

  # Open frontend and backend in Chrome
  open -a 'Google Chrome' http://stan:4000/stan/
  open -a 'Google Chrome' http://stan:4000/

  # Start grunt server
  grunt serve
