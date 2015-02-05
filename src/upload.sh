# Define upload method
if [ "$METHOD" = "upload" ]; then

  # Set folder permissions
  find httpdocs/* -type d -print0 | xargs -0 chmod 0755
  find httpdocs/* -type f -print0 | xargs -0 chmod 0644
  chmod -R 0777 httpdocs/cache

  # Get remote from config
  REMOTE=$( getConfigVar "REMOTE" )

  # If upload is scripts
  if [ "${ARGS[1]}" = "scripts" ]; then

    # Upload scripts
    rsync -trp --omit-dir-times --delete scripts/ ${REMOTE}scripts/

    # Upload stan-cli
    rsync -trp --omit-dir-times --delete stan-cli ${REMOTE}stan-cli

  else

    # Get staging server config
    STAGING_SERVER=$( getConfigVar "STAGING_SERVER" )

    # Check which env to upload to
    if [ "${ARGS[1]}" = "production" ] || [ "$STAGING_SERVER" = "" ]; then

      # Production
      REMOTE_PATH="httpdocs/"

    else

      # Staging
      REMOTE_PATH="staging/"

    fi

    # Upload httpdocs
    rsync -trp --omit-dir-times --delete --exclude=cache/images --exclude=cache/tmp --exclude=cache/null httpdocs/ ${REMOTE}${REMOTE_PATH}

    # Upload to CDN
    grunt cloudfiles

  fi

  # Show complete text
  echo -e $UPLOAD
