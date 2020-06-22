# Mangadex at Home at Jail

Mangadex at Home at Jail is a FreeNAS plugin meant to help make setting up the Mangadex at Home client easier. Keep in mind that it does not automate everything. You will want to add your secret to the settings.json file and adjust the limits to your needs.

## Installation

Because this is not an official community plugin, it needs to be installed via command line.

To do this, first download the "mangadexathome.json" file from this repository into your FreeNAS system (the main shell, not the shell of a Jail).

Once that's done, you can install the plugin

    iocage fetch --name mangadexathome -P mangadexathome.json -dhcp=on

## Post-Installation

Because the Mangadex at Home jar is not public you need to find and add the jar yourself. The jar should be renamed to "" and added in the "/usr/home/mangadexathome/mangadexathome" directory.

Make sure you also add your secret key to the "/usr/home/mangadexathome/mangadexathome/settings.json" file and update the limits to reflect your own system (or set them via iocage set).

Finally start the service

## Extra Steps

### Running on Port 443

The plugin by default does not run on port 443. There are two ways to enable this

1. Update the mangadexathome_user line of "/etc/rc.d/mangadexathome" run as root

    : ${mangadexathome_user=root}

2. On your FreeNAS system (not the jail, it is a system wide variable), update the "net.inet.ip.portrange.reservedhigh" sysctl value to a value less than 443

### Using a Different Dataset for Cache

The cache directory can become large and have many thousands of files which makes moving it difficult. For upgrade sanity, it is strongly recomended to make "/usr/home/mangadexathome/mangadexathome/cache" and "/usr/home/mangadexathome/mangadexathome/log" a symlink to a mounted dataset.
