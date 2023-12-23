#!/bin/bash

#!/bin/bash

echo ""
echo ""
echo ""
echo ""
echo -e "\033[94m====================== Created By Mompas =====================\033[0m"
echo ""
echo ""
echo -e "\033[38;5;205m                           (~~~~~~~~)    "
echo "                          (~~~~~~~~~~)   "
echo "                         (~~~~~~~~~~~~)  "
echo -e "\033[95m                        (*############*) "
echo "                        (*############*) "
echo -e "\033[38;5;205m                         (~~~~~~~~~~~~)  "
echo "                          (~~~~~~~~~~)   "
echo -e "                           (~~~~~~~~)    "
echo -e "\033[0m                               ||      "
echo "                               ||      "
echo "                               ||      "
echo "                               ||      "
echo ""
echo -e "\033[94m================== https://github.com/Mompas ==================\033[0m"
echo -e "\033[91m"
echo "          !!! NOT INTENDED FOR MALICIOUS ACTIVITY !!!"
echo ""
echo -e "\033[0m"
echo ""
echo ""
echo ""
echo ""

if ! command -v nmap &> /dev/null; then
    echo "Error: nmap is not installed."

    # Prompt the user if they want to install nmap
    read -p "Do you want to install nmap? (yes/no): " install_nmap
    if [ "$install_nmap" == "yes" ]; then
        # Install nmap (replace with your actual package manager command)
        sudo apt-get update
        sudo apt-get install nmap
        echo "nmap installed successfully."
    else
        echo "Exiting the script. Please install nmap and run the script again."
        exit 1
    fi
fi

if command -v ufw &> /dev/null; then
    firewall_cmd="ufw"
elif command -v iptables &> /dev/null; then
    firewall_cmd="iptables"
else
    echo "Error: Neither ufw nor iptables found. Please install a firewall tool and run the script again."
    exit 1
fi

while true; do
    
    read -p "Enter IP or hostname (or 'exit' to quit): " target

    if [ "$target" == "exit" ]; then
        echo "Exiting the script."
        exit 0
    fi

    if [ -z "$target" ]; then
        echo "Error: Please enter a valid IP or hostname."
        continue
    fi

    echo "Scanning ports on $target..."
    open_ports=$(nmap -p- --open --min-rate=1000 -T4 "$target" | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//')

    if [ -z "$open_ports" ]; then
        echo "No open ports found on $target."
    else
        echo "Open ports on $target: $open_ports"
        
        
        for port in $(echo "$open_ports" | tr ',' ' '); do
            read -p "Do you want to close port $port? (yes/no): " close_port
            if [ "$close_port" == "yes" ]; then
                sudo "$firewall_cmd" -A INPUT -p tcp --dport "$port" -j DROP
                echo "Closed port $port on $target using $firewall_cmd."
            else
                echo "Leaving port $port open on $target."
            fi
        done
    fi
done
