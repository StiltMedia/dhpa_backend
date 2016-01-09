#!/bin/bash
# {{Description: This deploy hook will install and configure Postfix. Set the SMTP_HOSTNAME environment variable to configure the domain name. }}
sudo apt-get update -y
sudo apt-get install postfix -y

if [ -z "$SMTP_HOSTNAME" ]
then
    >&2 echo "Please set your SMTP_HOSTNAME environment variable; left it as the default."
    export SMTP_HOSTNAME="smtp.example.com"
fi

# Important that there are no leading spaces in this echo
echo "myhostname = $SMTP_HOSTNAME
myorigin = \$mydomain
relayhost = \$mydomain
inet_interfaces = loopback-only
mydestination =
" > /etc/postfix/main.cf
