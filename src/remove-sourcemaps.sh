# Define remove-sourcemaps method
elif [ "$METHOD" = "remove-sourcemaps" ]; then

  # Get site ID
  VHOST=$( getConfigVar "VHOST" )

  # Remove css maps
  sed -i '' 's/sourceMappingURL=.*\.map//g' httpdocs/cache/assets/${VHOST}-*.css

  # Remove js maps
  sed -i '' 's/\/\/# sourceMappingURL=[^;]*//g' httpdocs/cache/assets/${VHOST}-*.js
