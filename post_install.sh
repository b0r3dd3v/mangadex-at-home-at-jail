#!/bin/sh

# Create user 'mangadexathome' with shell '/bin/nologin' with no home directory. For home directory, add '-m'
pw add user -n mangadexathome -c mangadexathome -s /bin/nologin

# Configure mangadexathome

sysrc mangadexathome_enable=YES

# Start the service
#service mangadexathome start
