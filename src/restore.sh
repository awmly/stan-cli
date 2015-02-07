# Define restore method
elif [ "$METHOD" = "restore" ]; then

  # Confirm restore
  prompt $RESTOREPROMPT

  # Check restore file is present
  if [ -f "snapshots/restore.tar.gz" ]; then

    # Extract restore file
    tar -zxvf snapshots/restore.tar.gz -C snapshots/ > /dev/null

    # Move database to database folder
    mv snapshots/httpdocs/database.sql database/database.sql

    # Restore database
    stan db importproduction

    # Restore httpdocs
    rsync -trp --omit-dir-times --delete snapshots/httpdocs/ httpdocs/ > /dev/null

    # Ensure cache directory is writeable
    chmod -R 0777 httpdocs/cache 2> /dev/null

    # Delete extracted folder
    rm -rf snapshots/httpdocs

    # Show complete text
    echo $HR
    echo $RESTORE
    echo $HR

  else

    # Show error text
    echo $HR
    echo $RESTOREERROR
    echo $HR

  fi
