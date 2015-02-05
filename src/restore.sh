# Define restore method
elif [ "$METHOD" = "restore" ]; then

  # Confirm restore
  prompt $RESTOREPROMPT

  # Check restore file is present
  if [ -f "snapshots/restore.tar.gz" ]; then

    # Extract restore file
    tar -zxvf snapshots/restore.tar.gz

    # Move database to database folder
    mv snapshots/restore/database.sql databases/database.sql

    # Restore database
    stan db importproduction

    # Remove database
    rm snapshots/restore/database.sql

    # Restore httpdocs
    rsync -trp --omit-dir-times --delete snapshots/restore/ httpdocs/

    # Ensure cache directory is writeable
    chmod -R 0777 httpdocs/cache

    # Delete extracted folder
    rm -rf snapshots/restore

    # Show complete text
    echo $RESTORE

  else

    # Show error text
    echo $RESTOREERROR

  fi
