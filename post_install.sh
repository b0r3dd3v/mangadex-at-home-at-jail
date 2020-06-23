#!/bin/sh

# Create user 'mangadexathome' with shell '/bin/nologin' with no home directory. For home directory, add '-m'
pw add user -n mangadexathome -c mangadexathome -s /bin/nologin

# Make are rc.d script executable
chmod +x /etc/rc.d/mangadexathome

# Change into the main mangadexathome directory
cd /usr/home/mangadexathome/mangadexathome

# Add mangadexathome as the owner of the setting.json.default
chown mangadexathome:mangadexathome settings.json.default

# Deal with the settings.json file
if [ -e settings.json ]
then
    echo "The settings.json file already exists. Please compare it with settings.json.default for any new parameters/etc."
else
  # If "settings.json" doesn't exist, make it based on "settings.json.default"
  cp settings.json.default settings.json
  chown mangadexathome:mangadexathome settings.json.default
fi

# Enable mangadexathome service
sysrc mangadexathome_enable=YES

# We can't start the service because the settings.json has to be configured

echo "Make sure to add your client_secret to '/usr/home/mangadexathome/mangadexathome/settings.json' and configure the other settings for your system (or set them via iocage (ex: iocage set -P client_secret=aaaaaaaaa mangadexathome)"
