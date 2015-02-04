# Define rebase method
elif [ "$METHOD" = "rebase" ]; then

  # Get current git status
  GIT_STATUS=$( git status )

  # Check if there are any unstaged files
  if [[ $GIT_STATUS == *"nothing to commit"* ]]; then

    # Rebase master
    git pull --rebase -p origin master

  else

    # Stash any un-commited files
    git stash

    # Rebase master
    git pull --rebase -p origin master

    # Unstash files
    git stash apply

  fi

  # Show complete text
  echo $REBASE
