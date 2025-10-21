{
  services.fail2ban = {
    enable = true;
    # jails = {
    #   # Protect SSH
    #   sshd = ''
    #     enabled = true
    #     maxretry = 5
    #     findtime = 600
    #     bantime = 3600
    #   '';

    #   # Protect BIND DNS
    #   bind = ''
    #     enabled = true
    #     filter = bind
    #     action = iptables-multiport[name=bind, port="53", protocol="tcp,udp"]
    #     logpath = /var/log/messages
    #     maxretry = 10
    #     findtime = 600
    #     bantime = 3600
    #   '';
    # };
  };
}
