FROM phusion/baseimage:0.9.11
MAINTAINER Simon Elsbrock <simon@iodev.org>

ENV LANG en_US.UTF-8

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

ADD bashrc /opt/weechat-bashrc
ADD init-user.sh /etc/my_init.d/10-init-user.sh

EXPOSE 22

RUN \
    echo "APT::Install-Recommends \"true\";\nAPT::Install-Suggests \"false\";" > /etc/apt/apt.conf ;\
    echo "Europe/Berlin" > /etc/timezone && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure tzdata ;\
    locale-gen en_US.UTF-8 en_DK.UTF-8 de_DE.UTF-8 ;\
    apt-get -q -y update ;\
    apt-get install -y language-pack-de weechat weechat-doc weechat-plugins tmux mosh python ;\
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ;\
    LC_ALL="en_US.UTF-8" dpkg-reconfigure locales ;\
    chmod +x /etc/my_init.d/10-init-user.sh
