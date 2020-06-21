#!/bin/sh

# Create user 'mangadexathome' with shell '/bin/nologin' with no home directory. For home directory, add '-m'
pw add user -n mangadexathome -c mangadexathome -s /bin/nologin

# Make are rc.d script executable
chmod +x /usr/local/etc/rc.d/mangadexathome

# Configure mangadexathome

sysrc mangadexathome_enable=YES

# Start the service
#service mangadexathome start
