# EmbeddedLinux_Team14

Github repository for RasberryPi /bin/ folder. 
SSH keys created by the RasberryPi, which are included in this repository. 
- Git commands
  - git status
  - git add [file/directory]
  - git commit -m "$message" file/directory
  - git push -u origin main
- Ssh_key
  - eval "$(ssh-agent)"
  - ssh-agent -s 
  - ssh-add ~/.ssh/key
- Config files:
  - The dhcpcd.conf is used to set the RPi up as a wifi access point. The file should be moved to \etc\dhcpcd.conf on the RPI. 
  - An assumption is that the wifi client is disabled in wpa_supplicant.conf. 
  - Next is the hostapd.conf which sets configuration for the accesspoint. This should be moved to /etc/hostapd/hotapd.conf. It should be noted that the accesspoint is preset to support 2.4 GhZ.
  - To configure a DHCP service, the dnsmasq.conf file is used. The file should be moved to /etc/dnsmasq.conf
  - Next is fail2ban setting the threshold for bantime, findtime, and maxretry. The file should be moved to /ect/fail2ban/jail.local
  - Next config file is for configuring for password and not allow anonymous entry. This should be moved to /ect/mosquito/conf.d
  - Next is the config file for telegraf, to specify input and source. This file should be moved to /etc/telegraf/telegraf.conf. 

