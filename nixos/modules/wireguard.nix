{pkgs, ...}: {
  # Enable IP forwarding for routing
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

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
        "192.168.200.1/24"
      ];

      listenPort = 51820;

      dns = ["192.168.200.1"];

      privateKeyFile = "/home/mike/.nixos/secrets/wireguard-keys/freya.key";

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      postUp = ''
        ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 192.168.200.0/24 -o eno1 -j MASQUERADE
      '';

      # Undo the above
      preDown = ''
        ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 192.168.200.0/24 -o eno1 -j MASQUERADE
      '';

      peers = [
        {
          # zion
          publicKey = "r/wrEqNoJvqfhyg9B8AjhsoiM+7KZp09V9eONIOz9l4=";
          allowedIPs = [
            "192.168.200.2/32"
          ];
        }
        {
          # thor
          publicKey = "tQR3oc+pGYhQ1XlMzlEDpD17sRgMFhmSXZBEW6jF6Rc=";
          allowedIPs = [
            "192.168.200.3/32"
          ];
        }
        {
          # loki
          publicKey = "s+spoHzTZDyaHuAqI3dpVFKQLoy9oCBCZEHhM2Dxcn0=";
          allowedIPs = [
            "192.168.200.4/32"
          ];
        }
      ];
    };
  };

  # Open ports in the firewall
  networking.firewall = {
    allowedTCPPorts = [53];
    allowedUDPPorts = [53 51820];
  };
}
