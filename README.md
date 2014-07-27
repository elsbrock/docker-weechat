## Building

    docker build --rm -t "else/weechat" .`
    export MOSH_PORTS=$(perl -e '$p=60001;print " -p " .$p.":".$p++."/udp " for (1..5)')
    docker run --rm=true --name=weechat -v /path/to/store/config:/opt/weechat-data -it -p 22 $MOSH_PORTS -e IRC_USER=$(whoami) -e SSH_PUBKEY="$(cat ~/.ssh/id_rsa.pub)" else/weechat /sbin/my_init
    docker stop weechat && docker rm weechat
