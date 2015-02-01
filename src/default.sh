# Define default action
elif [ "$METHOD" = "" ]; then

  git pull origin master

  grunt update

  atom ./

  mysql.server start

  syncDB

  open -a 'Google Chrome' http://stan:4000/stan/
  open -a 'Google Chrome' http://stan:4000/

  grunt serve
