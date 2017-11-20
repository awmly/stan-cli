# Define default action
elif [ "$METHOD" = "" ]; then

  # Rebase from remote
  stan rebase

  # Install node/bower/composer dependencies
  stan dependencies

  # Open atom
  atom ./

  # Start mysql server
  mysql.server start

  # Make sure local db is clean
  mysql --defaults-extra-file=database/local.cnf --execute='drop database stan;create database stan;'

  # Export current remote db and load it in to local server
  stan db synclocal

  # Build JS/CSS libraries
  stan build

  # Open frontend and backend in Chrome as background tasks
  sleep 1 && open -a 'Google Chrome' http://stan:4000/base/ &
  sleep 2 && open -a 'Google Chrome' http://stan:4000/ &

  # Start grunt server
  grunt serve
