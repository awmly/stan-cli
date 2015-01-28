# Define clone method
if [ "$METHOD" = "clone" ]; then
  REPO=$(echo "${ARGS[1]##*/}" | sed 's/\./-/g')
  git clone git@gitlab.com:smartarts/${REPO}.git ${ARGS[1]}
  cd ${ARGS[1]}
  installGrunt
  echo "Close this window - Open the github app > file > add local repo > select directory"
fi
