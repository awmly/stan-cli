# Define remove-sourcemaps method
elif [ "$METHOD" = "remove-sourcemaps" ]; then

  # Get site ID
  SITE_ID=$( getConfigVar "SITE_ID" )

  # Remove css maps
  sed -i.tmp 's/sourceMappingURL=.*\.map//g' httpdocs/cache/assets/${SITE_ID}-*.css

  # Remove js maps
  sed -i.tmp 's/\\/\\/# sourceMappingURL=.*\.map//g' httpdocs/cache/assets/${SITE_ID}-*.js

  # Clean tmp files
  rm -f httpdocs/cache/assets/*.tmp
