#!/bin/bash
# This is a script made to keep your Ubuntu server up to
# date placing this script to /etc/cron.weekly/autoupdate.sh.
# This script updates your server automatically and informs
# you via email if the update was succesful or not.

# Set the variable $admin_email as your email address.
admin_mail="name@email.com"

# Create a temporary path in /tmp to write a temporary log
# file. No need to edit.
tmpfile=$(mktemp)

# Run the commands to update the system and write the log
# file at the same time.
echo "aptitude update" >> ${tmpfile}
aptitude update >> ${tmpfile} 2>&1
echo "" >> ${tmpfile}
echo "aptitude full-upgrade" >> ${tmpfile}
aptitude -y full-upgrade >> ${tmpfile} 2>&1
echo "" >> ${tmpfile}
echo "aptitude clean" >> ${tmpfile}
aptitude clean >> ${tmpfile} 2>&1

# Send the temporary log via mail. The fact if the upgrade
# was succesful or not is written in the subject field.
if grep -q 'E: \|W: ' ${tmpfile} ; then
        mail -s "Upgrade of your computer $(hostname) failed $(date)" ${admin_mail} < ${tmpfile}
else
        mail -s "Upgraded your computer $(hostname) succesfully $(date)" ${admin_mail} < ${tmpfile}
fi

# Remove the temporary log file in temporary path.
rm -f ${tmpfile}
