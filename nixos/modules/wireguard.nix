{pkgs, ...}: {
  # Enable NAT
  networking.nat = {
    enable = true;
    enableIPv6 = true;
    externalInterface = "eno1";
    internalInterfaces = ["wg0"];
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [
        "192.168.200.1/32"
        "fd31:bf08:57cb::1/128"
      ];

      dns = ["127.0.0.1"];

      privateKeyFile = "/home/mike/.nixos/secrets/wireguard-keys/freya.key";

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      postUp = ''
        ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.1/24 -o eth0 -j MASQUERADE
        ${pkgs.iptables}/bin/ip6tables -A FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/ip6tables -t nat -A POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o eth0 -j MASQUERADE
      '';

      # Undo the above
      preDown = ''
        ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.1/24 -o eth0 -j MASQUERADE
        ${pkgs.iptables}/bin/ip6tables -D FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/ip6tables -t nat -D POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o eth0 -j MASQUERADE
      '';

      peers = [
        {
          # Thor
          publicKey = "tQR3oc+pGYhQ1XlMzlEDpD17sRgMFhmSXZBEW6jF6Rc=";
          allowedIPs = [
            "192.168.200.3/32"
            "fd31:bf08:57cb::3/128"
          ];
        }
        # More peers can be added here.
      ];
    };
  };

  # Open ports in the firewall
  networking.firewall = {
    allowedTCPPorts = [53];
    allowedUDPPorts = [53];
  };

  services = {
    dnsmasq = {
      enable = true;
      settings.interface = "wg0";
    };
  };
}
