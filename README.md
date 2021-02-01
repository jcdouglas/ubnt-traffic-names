# ubnt-traffic-names
Script to update an Edgerouter Lite with hostnames from a BIND DNS server.

So this is a horribly in efficient and badly coded (hence the name janky.sh) script I slapped together to update the hostname under the Traffic Analysis section of my Ubiquiti Edgerouter Lite, as I don't use the Edgerouter itself for DNS, I got tired of looking at IP's and wanted hostnames to show up.


In short, takes zone files from a BIND DNS server, gets the hostnames out, and outputs everything to a new script to be run on the router itself.  Since it recreates the script every time it's run, the names can be updated easily if you've got DHCP and reverse lookups and all that fun stuff working.

Could probably be made 100x better since I suck at coding.

Provided as is, use at your own risk, not my fault if you break something, etc.
