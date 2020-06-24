#!/bin/sh

# Create user 'mangadexathome' with shell '/bin/nologin' with no home directory. For home directory, add '-m'
pw add user -n mangadexathome -c mangadexathome -s /bin/nologin

# Make are rc.d script executable
chmod +x /etc/rc.d/mangadexathome

# This is due to the Overlay. Anything created through will be owned by root...
chown -R mangadexathome:mangadexathome /usr/home/mangadexathome

# Change into the main mangadexathome directory
cd /usr/home/mangadexathome/mangadexathome

# Deal with the settings.json file
if [ -e settings.json ]
then
    echo "The settings.json file already exists. Please compare it with settings.json.default for any new parameters/etc."
else
  # If "settings.json" doesn't exist, make it based on "settings.json.default"
  cp settings.json.default settings.json
  chown mangadexathome:mangadexathome settings.json
fi

# Enable mangadexathome service
sysrc mangadexathome_enable=YES

# We can't start the service because the settings.json has to be configured

echo "Make sure to add your client_secret to '/usr/home/mangadexathome/mangadexathome/settings.json' and configure the other settings for your system (or set them via iocage (ex: iocage set -P client_secret=aaaaaaaaa mangadexathome)"
echo "The ui_hostname is 0.0.0.0 by default so that it's accessible. Make sure you have a firewall or change that if you don't want it public"
echo "It is recomended to make the cache and log folder aliases to something on another data setp. This will help immensly with upgrades"
