# Define install method
if [ "$METHOD" = "install" ]; then

  # Get config values from PHP
  DBHOST="$(cat httpdocs/config/config.php | grep -m 1 DBHOST | cut -d \' -f 4)"
  DBNAME="$(cat httpdocs/config/config.php | grep -m 1 DBNAME | cut -d \' -f 4)"
  DBUSER="$(cat httpdocs/config/config.php | grep -m 1 DBUSER | cut -d \' -f 4)"
  DBPASS="$(cat httpdocs/config/config.php | grep -m 1 DBPASS | cut -d \' -f 4)"

  installGrunt
  mysql -h $DBHOST -u $DBUSER -p${DBPASS} $DBNAME < database.sql
  git add .
  git commit -m 'Install project'
  git push origin master
  echo "Open the github app > file > add local repo > select directory"
fi
