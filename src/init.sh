# Define init method
if [ $METHOD = 'init' ]; then
  mkdir ${ARGS[1]}
  cd ${ARGS[1]}
  git archive --format=tar --remote=git@gitlab.com:awomersley/stan.git master | tar -xf -
  git init
  REPO=$(echo "${PWD##*/}" | sed 's/\./-/g')
  git remote add origin git@gitlab.com:smartarts/${REPO}.git
  atom ./
  echo "Edit httpdocs/config/config.php and then run 'stan install'"
fi
