#!/bin/sh

# Create user 'mangadexathome' with shell '/bin/nologin' with no home directory. For home directory, add '-m'
pw add user -n mangadexathome -c mangadexathome -s /bin/nologin

# Make are rc.d script executable
chmod +x /etc/rc.d/mangadexathome

# Add mangadexathome as the owner of the setting.json.default
chown mangadexathome:mangadexathome /usr/home/mangadexathome/mangadexathome/settings.json.default

# Change into the main mangadexathome directory
cd /usr/home/mangadexathome/mangadexathome

# Deal with the settings.json file
if [ -e settings.json ]
then
  # If "settings.json" exists, check if it is an outdated configuration
  defaultVersion = jq '.unofficial_config_version' settings.json.default
  operationalVersion = jq '.unofficial_config_version' settings.json
  
  if [ $defaultVersion -ne $operationalVersion ]
  then
    echo "The settings.json 'unofficial_config_version' differs from the value in settings.json.default. Please compare them for changes and update the version as needed."
  fi
else
  # If "settings.json" doesn't exist, make it based on "settings.json.default"
  cp settings.json.default settings.json
fi

# Enable mangadexathome service
sysrc mangadexathome_enable=YES

# We can't start the service because the settings.json has to be configured

echo "Make sure to add your client_secret to '/usr/home/mangadexathome/mangadexathome/settings.json' and configure the other settings for your system (or set them via iocage set)"
