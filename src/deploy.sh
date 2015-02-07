# Define deploy method
elif [ "$METHOD" = "deploy" ]; then

  # Confirm deployment
  prompt $DEPLOYPROMPT

  # Create snapshot
  stan snapshot

  # Copy cache from production to staging
  rsync -trp --omit-dir-times httpdocs/cache/ staging/cache/

  # Copy staging to production
  rsync -trp --omit-dir-times --delete staging/ httpdocs/

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
