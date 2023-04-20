# !/bin/bash

# Add SSH keys
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIpFS9mh1qIHa9trTjB9vQ/Oobh+drqx/k9a9ydW7fGy0ERE/YlC3SQvlRSurGuPULC+wc/x5dIVxBgkUQNDpNwdS2rXxPc55lCV5kpvUhaIyCsRlqLf+jby1JEPFzUsQbjPRl4ggR1eXyKwRG46wx0dRiwCdMgPVMdfNy7ckeYFQDkIAhZL5dWHQBTfr/ZWC8oTgGZ4hDEJHCDOTXY5HdM1M1DwX3EggrFM+zD8b/IO6Z+be4mbqDcA0rQl4GgBcggLz9fAf12kQiNw6ewVLSFlZsazphV8qonHUGpkxMpaKD1J+PhJNUxXoAsjCbvKlngIt28MaHppwQoXclG6AszpKQJJahrbZkupW0kOEKbJPUAmZt0KiJq0XZD6rhZqcFDo1V4e/3nlfDaXv/mee0+LIAprbiQEowB6YC1RZYvFlMZz1rgmZsIJieygGWB4J0xrvS2uBw++8peuninL2ZP+ORsm9yiFaKBgwZlqJ/NOWMZns+K9VlPIaSQS4ci+0= whetu@DESKTOP-NVTCV4R" >> /home/debian/.ssh/authorized_keys

# Update and upgrade packages
sudo apt update
sudo apt upgrade -y

# Configure SSH settings
sudo sed -i 's/#AddressFamily\ any/AddressFamily\ inet/g' /etc/ssh/sshd_config
sudo sed -i 's/#Port\ 22/Port\ 8572/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin\ prohibit-password/PermitRootLogin\ no/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Install and configure UFW
sudo apt -y install ufw
sudo ufw allow 8572
sudo ufw --force enable

# Install and configure fail2ban
sudo apt install fail2ban -y
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo sed -i 's/=\ ssh/=\ 8572/g' /etc/fail2ban/jail.local
sudo service fail2ban restart