# Define sync-db method
if [ "$METHOD" = "sync-db" ]; then

  mysql -u stan -pstan stan --execute='DROP TABLE IF EXISTS json, saconfig, saconfiggrp, saconfigparam, saextra, saextradata, saextramap, saextramodule, satmp, uploads'
  wget 'http://backup.sadev4.co.uk/dump.php?n=&key=6gb-S4m-dRaY-v7sT' -O database.sql
  mysql -u stan -pstan stan < database.sql

fi
