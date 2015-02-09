# Define upload method
if [ "$METHOD" = "upload" ]; then

  # Get remote from config
  REMOTE=$( getConfigVar "REMOTE" )

  # If upload is scripts
  if [ "${ARGS[1]}" = "scripts" ]; then

    # Set permissions
    chmod 0700 stan-cli scripts/*

    # Upload scripts
    rsync -trp --omit-dir-times --delete scripts/ ${REMOTE}scripts/

    # Upload stan-cli
    rsync -trp --omit-dir-times --delete stan-cli ${REMOTE}stan-cli

  else

    # Set folder permissions
    find httpdocs/* -type d -print0 | xargs -0 chmod 0755
    find httpdocs/* -type f -print0 | xargs -0 chmod 0644
    chmod -R 0777 uploads httpdocs/cache

    # Get staging server config
    STAGING_SERVER=$( getConfigVar "STAGING_SERVER" )

    # Check which env to upload to
    if [ "$STAGING_SERVER" = "1" ]; then

      # Staging
      REMOTE_PATH="staging/"

    else

      # Production
      REMOTE_PATH="httpdocs/"

    fi

    # Upload httpdocs
    rsync -trp --omit-dir-times --delete --exclude=cache/images --exclude=cache/tmp httpdocs/ ${REMOTE}${REMOTE_PATH}

    # Upload cache images (without --delete flag)
    rsync -trp --omit-dir-times httpdocs/cache/images/ ${REMOTE}${REMOTE_PATH}cache/images/

    # Upload uploads
    rsync -trp --omit-dir-times uploads/ ${REMOTE}uploads/

    # Upload to CDN
    grunt cloudfiles

  fi

  # Show complete text
  echo $HR
  echo $UPLOAD
  echo $HR
