# ubnt-traffic-names
Script to update an Edgerouter Lite with hostnames from a BIND DNS server.

So this is a horribly in efficient and badly coded (hence the name janky.sh) script I slapped together to update the hostname under the Traffic Analysis section of my Ubiquiti Edgerouter Lite, as I don't use the Edgerouter itself for DNS, I got tired of looking at IP's and wanted hostnames to show up.


In short, takes zone files from a BIND DNS server, gets the hostnames out, and outputs everything to a new script to be run on the router itself.  Since it recreates the script every time it's run, the names can be updated easily if you've got DHCP and reverse lookups and all that fun stuff working.

Could probably be made 100x better since I suck at coding.

Provided as is, use at your own risk, not my fault if you break something, etc.

Also, if you have this thing running on a cron job, it *may* make a bunch of /tmp/changes_only_#### directories which show up as mount points for some reason.

https://community.ui.com/questions/Lingering-config-session/dffc0fef-1ced-4012-bea9-9f1313b06a76

The above link has a script in the comments about how to clean these up.  I'd add it but I don't want to come off like I'm ripping dude off.
