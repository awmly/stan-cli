"php tests/sitespeed.io/set-url.php",
"source tests/sitespeed.io/url && sitespeed.io -u $URL -r tests/sitespeed.io/ -j 20 -s /contact-us",
"php tests/gtmetrix/run-test.php",
