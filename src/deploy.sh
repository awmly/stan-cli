# Define deploy method
elif [ "$METHOD" = "deploy" ]; then

  # Confirm deployment
  prompt "$DEPLOYPROMPT"

  # Create snapshot
  stan snapshot

  # Clear cache
  rm -rf staging/cache/views/*

  # Copy staging to production
  rsync -trp --omit-dir-times --delete --exclude=cache/images --exclude=cache/media staging/ httpdocs/

  # Copy staging cache to production cache (without --delete flag)
  rsync -trp --omit-dir-times staging/cache/images/ httpdocs/cache/images/
  rsync -trp --omit-dir-times staging/cache/media/ httpdocs/cache/media/

  # Export staging db
  stan db exportstaging

  # Load in to production db
  stan db importproduction

  # Load custom deploy
  scripts/deploy.sh

  # Show complete text
  echo $HR
  echo $DEPLOY
  echo $HR
