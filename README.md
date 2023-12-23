# Open-Port-Detector-Closer
A tool to detect open ports, with an option to close them.

This tool uses NMAP for port detection, and ufw/iptables to close them.

If you don't have NMAP installed, it will offer to install it for you.(I reccomend installing NMAP before running the script, as the installation proccess could be buggy for some).

If you don't have ufw, it will attempt to close the ports using iptables.

Not to be used for malicious activity.
