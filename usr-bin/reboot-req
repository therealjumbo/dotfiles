#! /bin/bash
if [ -f /var/run/reboot-required ]; then
    echo "A reboot is required. The packages that require the reboot are:"
    if [ -f /var/run/reboot-required.pkgs ]; then
	cat /var/run/reboot-required.pkgs
    else
	echo "Unknown. /var/run/reboot-required.pkgs does not exist or is not a regular file."
    fi

else
    echo "A reboot is not required."
fi
