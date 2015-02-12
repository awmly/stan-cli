# Define default action
elif [ "$METHOD" = "" ]; then

  # Rebase from remote
  stan rebase

  # Build JS/CSS libraries
  stan build

  # Open atom
  atom ./

  # Start mysql server
  mysql.server start

  # Export current remote db and load it in to local server
  stan db synclocal

  # Open frontend and backend in Chrome as background tasks
  sleep 1 && open -a 'Google Chrome' http://stan:4000/stan/ &
  sleep 2 && open -a 'Google Chrome' http://stan:4000/ &

  # Start grunt server
  grunt serve
