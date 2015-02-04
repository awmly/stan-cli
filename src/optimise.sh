# Define optimise method
elif [ "$METHOD" = "optimise" ]; then

  jpegoptim httpdocs/assets/frontend/images/*.jpg
  optipng -o5 httpdocs/assets/frontend/images/*.png
