# Define getsnapshot method
elif [ "$METHOD" = "getsnapshot" ]; then

  # Get remote from config
  REMOTE=$( getConfigVar "REMOTE" )

  rsync -trp --rsh="ssh -p 2278" ${REMOTE}snapshots/${ARGS[1]} snapshots/
