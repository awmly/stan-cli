# Define speed test method
elif [ "$METHOD" = "speedtest" ]; then

  # Get SIET_URL from config file
  SITE_URL=$( getConfigVar "SITE_URL" )

  # Run sitespeed.io test
  sitespeed.io -u $SITE_URL -r tests/sitespeed.io/ -j 20 -s /contact-us

  # Run GT Metrix (Page speed and Y Slow)
  php tests/gtmetrix/run-test.php
