## Building

    docker build --rm -t "else/weechat" .`
    docker run --rm=true --name=weechat -v /path/to/store/config:/opt/weechat-data -it -p 22 -e IRC_USER=$(whoami) -e SSH_PUBKEY="$(cat ~/.ssh/id_rsa.pub)" else/weechat /sbin/my_init
    docker stop weechat && docker rm weechat
