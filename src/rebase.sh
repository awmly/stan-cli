# Define rebase method
elif [ "$METHOD" = "rebase" ]; then

  # Get current git status
  GIT_STATUS=$( git status )

  # Check if there are any unstaged files
  if [[ $GIT_STATUS == *"nothing to commit"* ]]; then

    # Rebase master
    git pull --rebase

  else

    # Clear any pervious stashes
    git stash clear

    # Stash any un-commited files
    git stash

    # Rebase master
    git pull --rebase

    # Unstash files
    git stash apply

  fi

  # Show complete text
  echo $HR
  echo $REBASE
  echo $HR
