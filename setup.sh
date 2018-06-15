#!/bin/sh
. /opt/farm/scripts/init


if [ -d /usr/local/cpanel ]; then
	echo "skipping mta configuration, system is controlled by cPanel, with Exim as MTA"
elif [ -d /usr/local/directadmin ]; then
	echo "skipping mta configuration, system is controlled by DirectAdmin, with Exim as MTA"
elif [ -f /etc/elastix.conf ]; then
	echo "skipping mta configuration, system is controlled by Elastix"
elif [ "$HWTYPE" = "oem" ]; then
	echo "skipping mta configuration, unsupported OEM platform"
elif [ ! -d /opt/farm/ext/repos/lists/$OSVER ]; then
	echo "skipping mta configuration, unsupported system version"
elif [ "$SMTP" != "true" ]; then
	/opt/farm/scripts/setup/extension.sh sf-mta-forwarder
else
	/opt/farm/scripts/setup/extension.sh sf-mta-relay
fi
