# Define speed test method
elif [ "$METHOD" = "speedtest" ]; then

  # Get SIET_URL from config file
  SITE_URL=$( getConfigVar "SITE_URL" )
  API_KEY=$( getConfigVar "GOOGLE_API_KEY" )

  # Run sitespeed.io test
  sitespeed.io -u $SITE_URL -r tests/sitespeed.io/ -j 20 -s /contact-us --gpsiKey API_KEY

  # Run GT Metrix (Page speed and Y Slow)
  php tests/gtmetrix/run-test.php
