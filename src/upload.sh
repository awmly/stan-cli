# Define upload method
if [ "$METHOD" = "upload" ]; then

  # Get remote from config
  REMOTE=$( getConfigVar "REMOTE" )

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

  # If upload is scripts
  if [ "${ARGS[1]}" = "scripts" ]; then

    # Set permissions
    chmod 0755 stan-cli scripts/*

    # Upload scripts
    rsync -trp --omit-dir-times --delete scripts/ ${REMOTE}scripts/

    # Upload stan-cli
    rsync -trp --omit-dir-times --delete stan-cli ${REMOTE}stan-cli

  elif [ "${ARGS[1]}" = "cacheimages" ]; then

    rsync -trp --omit-dir-times httpdocs/cache/images/ ${REMOTE}${REMOTE_PATH}cache/images/

  elif [ "${ARGS[1]}" = "cache" ]; then

    rsync -trp --omit-dir-times httpdocs/cache/ ${REMOTE}${REMOTE_PATH}cache/
    grunt cloudfiles:cache

  else

    # Set folder permissions
    find httpdocs/* -type d -print0 | xargs -0 chmod 0755
    find httpdocs/* -type f -print0 | xargs -0 chmod 0644
    chmod -R 0777 uploads httpdocs/cache

    # Remove source maps from minified files
    stan remove-sourcemaps

    # Show prompt
    prompt "${UPLOADPROMPT} ${REMOTE}${REMOTE_PATH}"

    # Delete local params
    rm httpdocs/cache/params/* 2> /dev/null
    rm httpdocs/cache/tmp/* 2> /dev/null

    # Upload httpdocs
    rsync -trp --omit-dir-times --delete --exclude=cache/images --exclude=cache/libs --exclude=cache/media --exclude=cache/tmp httpdocs/ ${REMOTE}${REMOTE_PATH}

    # Upload cache images (without --delete flag)
    rsync -trp --omit-dir-times httpdocs/cache/tmp/ ${REMOTE}${REMOTE_PATH}cache/tmp/
    rsync -trp --omit-dir-times httpdocs/cache/images/ ${REMOTE}${REMOTE_PATH}cache/images/
    rsync -trp --omit-dir-times httpdocs/cache/media/ ${REMOTE}${REMOTE_PATH}cache/media/

    # Upload uploads
    rsync -trp --omit-dir-times uploads/ ${REMOTE}uploads/

    # Upload to CDN
    if [ "${ARGS[1]}" != "code" ]; then
      grunt cloudfiles:prod
    fi

    # Clear cache/uploads directories
    rm -f uploads/images/*
    rm -f httpdocs/cache/images/*

  fi

  # Show complete text
  echo $HR
  echo $UPLOAD
  echo $HR
