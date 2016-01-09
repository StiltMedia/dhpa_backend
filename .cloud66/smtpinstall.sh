#!/bin/bash
# {{Description: This deploy hook will install and configure Postfix. Set the SMTP_HOSTNAME environment variable to configure the domain name. }}
if [ -z "$SMTP_HOSTNAME" ]
then
    >&2 echo "Please set your SMTP_HOSTNAME environment variable and run again."
else
  debconf-set-selections <<< "postfix postfix/mailname string $SMTP_HOSTNAME"
  debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"

  sudo apt-get update -y
  sudo apt-get install postfix -y

# Important that there are no leading spaces in this echo
echo "myhostname = $SMTP_HOSTNAME
myorigin = \$mydomain
relayhost = \$mydomain
inet_interfaces = loopback-only
mydestination =
" > /etc/postfix/main.cf

fi
