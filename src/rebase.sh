# Define rebase method
elif [ "$METHOD" = "rebase" ]; then

  GIT_STATUS=$( git status )
  
  # Stash any un-commited files
  git stash

  # Rebase master
  git pull --rebase -p origin master

  # Unstash files
  git stash apply
