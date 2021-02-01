#!/bin/bash
#
#
# You'll need to make this file executable and what not.  Throw on to crontab to your liking.
#
#
# Your zone file location
zonefile=/var/whereeveryour/zonefile/is.com.db
#
# Your EdgeRouter SSH session - YOU'LL WANT TO SETUP SSH KEYLESS LOGIN, I'd recommend root but that's just me.
ubntssh="username@edgerouter"
#
# vbash header info
vbashhead1='#!/bin/vbash'
vbashhead2='source /opt/vyatta/etc/functions/script-template'
vbashhead3='configure'
#
# vbash footer info
vbashfoot1='commit'
vbashfoot2='save'
vbashfoot3='exit'
#
#
# create the script to run, you could really name this to whatever you want.
#
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e '#!/bin/vbash' > ./newjank.sh"
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e "$vbashhead2" >> ./newjank.sh"
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e "$vbashhead3" >> ./newjank.sh"
#
# An explanation of what is being jammed into the while loops
#
#
#cat $zonefile
#  Outputing whatever your zone file from bind is
#
# | piping it into the next statement
#
#grep -E "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"
#  Look for only the lines that have a pattern of numbers like an IP addy
#  This should return all your A or AAAA records like "HOSTNAME  A   8.8.8.8"
#
# | piping it into the next statement
#
#sed -e "s/[[:space:]]A\+/ /g"
#  Use sed to strip away spaces by A, if you have AAAA replace accordingly
#  You might even need to add another sed statement
#
# | piping it into the next statement
#
#sed -e "s/[[:space:]]\+/ /g"
#  Get rid of any extra spaces.  At this point it should be "HOSTNAME IPADDRESS"
#  with a single space.
#
# | piping it into the next statement
#
#grep -v localhost
#  My favorite grep option, -v, for don't show me this result, just everything else
#
# | piping it into the next statement
#
#sed -e 's/\\//g' | 
#  Because sometimes, at least in my DNS hostnames have shown up with / or \ in them.
#  <cough, cough> Nintendo devices <cough, cough>, \032, this will leave the numeric
#  part of the ascii character that BIND doesn't handle...
#
cat $zonefile | grep -E "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sed -e "s/[[:space:]]A\+/ /g" | sed -e "s/[[:space:]]\+/ /g" | grep -v localhost | sed -e 's/\\//g' | grep -v \\$ | while IFS='' read -r line || [[ -n "$line" ]]; do
	###
	### Separate the hostname and the IP Adress out into their own variables
	###
	host=$(echo $line | awk '{print $1}')
	ipad=$(echo $line | awk '{print $2}')
	#
	ssh -o LogLevel=QUIET -n -tt "$ubntssh" "echo -e 'delete system static-host-mapping host-name $host;' >> ./newjank.sh"
done
# add footer info
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e "$vbashfoot1" >> ./newjank.sh"
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e "$vbashfoot2" >> ./newjank.sh"
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e "$vbashfoot3" >> ./newjank.sh"

# execute
ssh -o LogLevel=QUIET -n "$ubntssh" "chmod 755 newjank.sh"
echo "Set to execute..."
ssh -o LogLevel=QUIET -n "$ubntssh" "./newjank.sh"
echo "Deletion update complete..."	
# create the script to run
#
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e '#!/bin/vbash' > ./newjank.sh"
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e "$vbashhead2" >> ./newjank.sh"
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e "$vbashhead3" >> ./newjank.sh"
#
cat $zonefile | grep -E "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sed -e "s/[[:space:]]A\+/ /g" | sed -e "s/[[:space:]]\+/ /g" | grep -v localhost | sed -e 's/\\//g' | while IFS='' read -r line || [[ -n "$line" ]]; do
	###
	### Separate the hostname and the IP Adress out into their own variables
	###
	host=$(echo $line | awk '{print $1}')
	ipad=$(echo $line | awk '{print $2}')
	#
	ssh -o LogLevel=QUIET -n -tt "$ubntssh" "echo -e 'set system static-host-mapping host-name $host inet $ipad;' >> ./newjank.sh"
done
# add footer info
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e "$vbashfoot1" >> ./newjank.sh"
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e "$vbashfoot2" >> ./newjank.sh"
ssh -o LogLevel=QUIET -n "$ubntssh" "echo -e "$vbashfoot3" >> ./newjank.sh"

# execute
ssh -o LogLevel=QUIET -n "$ubntssh" "chmod 755 newjank.sh"
echo "Set to execute..."
ssh -o LogLevel=QUIET -n "$ubntssh" "./newjank.sh"
echo "Names addition update complete...."
