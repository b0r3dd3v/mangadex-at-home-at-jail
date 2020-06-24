# Mangadex at Home at Jail

Mangadex at Home at Jail is a FreeNAS plugin meant to help make setting up the Mangadex at Home client easier. Keep in mind that it does not automate everything. You will want to add your secret to the settings.json file and adjust the limits to your needs.

If you are curious about the mangadexathome client (overlay/usr/home/mangadexathome/mangadexathome/mangadex_at_home.jar), you can see the source on gitlab: https://gitlab.com/mangadex-pub/mangadex_at_home/

## Installation

Because this is not an official community plugin, it needs to be installed via command line.

To do this, first download the "mangadexathome.json" file from this repository into your FreeNAS system (the main shell, not the shell of a Jail).

Once that's done, you can install the plugin

    iocage fetch --name mangadexathome -P mangadexathome.json -dhcp=on

## Post-Installation

Make sure you also add your secret key to the "/usr/home/mangadexathome/mangadexathome/settings.json" file and update the limits to reflect your own system (or set them via iocage set).

Finally start the service or restart your plugin

## Extra Steps


### Viewing the UI

The mangadexathome client runs a Web UI where you can see the stats. This page can be reached by going to the server's ip in your browser or by clicking the "managae" button for the plugin.

By default, the plugin will use port 44445 for this. You can change it in the settings.config (or via iocage set) but it may break the plugin's "Manage" button.

For those who don't want a whole web page, you cal view the /stats endpoint for basic totals for disk usage/requests serveed/bandwidth. You can also view the /pastStats endpoint for past information.

Alternatively, you can visit https://mangadex.network for stats collected by the Mangadex server.

### Running on Port 443

The plugin by default does not run on port 443. There are two ways to enable this

1. Update the user line of "/etc/rc.d/mangadexathome" to run as root

    user=root

2. On your FreeNAS system (not the jail, it is a system wide variable), update the "net.inet.ip.portrange.reservedhigh" sysctl value to a value less than 443

### Using a Different Dataset for Cache

The cache directory can become large and have many thousands of files which makes moving it difficult. For upgrade sanity, it is strongly recomended to make "/usr/home/mangadexathome/mangadexathome/cache" and "/usr/home/mangadexathome/mangadexathome/log" a symlink to a mounted dataset.

### What are iocage get and set commands?

iocage is a commandline tool to install/uninstall/start/stop/configure jails. The get and set commands can be used to update plugin specific configuration. Eventually there may be a FreeNAS UI to handle this, but for now we have to use the commands.

The valid get/set values are described in the settings.json file at the root of the repository. That being said, the settings names match 1-1 with the mangadexathome settings.json keys. The exception is that the "ui_port_ and "ui_hostname" values are used instead of the full path for them ("web_settings.ui_port", "web_settings.ui_hostname")

Examples of iocage get

    iocage get -P client_port mangadexathome
    iocage get -P max_cache_size_in_mebibytes

Examples of iocage set (The mangadexathome service will restart after running iocage set)

    iocage set -P client_secret=aaaaaaa mangadexathome
    iocage set -P max_cache_size_in_mebibytes=1000 mangadexathome
