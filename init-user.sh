#!/bin/bash -x

set -e

if [ -z "$IRC_USER" ]; then
    echo "Missing environment variable IRC_USER"
    exit 0
fi

if [ -z "$SSH_PUBKEY" ]; then
    echo "Missing environment variable SSH_PUBKEY"
    exit 0
fi

[[ -n "$DEBUG" ]] && echo "root:$DEBUG" | chpasswd

adduser --gecos "" --disabled-password $IRC_USER --shell /bin/bash

mkdir -p /home/$IRC_USER/.ssh
echo $SSH_PUBKEY > /home/$IRC_USER/.ssh/authorized_keys
chown -R $IRC_USER /home/$IRC_USER/.ssh
rm -f /home/$IRC_USER/.bashrc
ln -s /opt/weechat-bashrc /home/$IRC_USER/.bashrc

chown $IRC_USER /opt/weechat-data
ln -s /opt/weechat-data /home/$IRC_USER/.weechat

eval cd ~$IRC_USER
setuser else /usr/bin/tmux new-session -s irc -d /usr/bin/weechat-curses
