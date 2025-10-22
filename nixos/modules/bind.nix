{pkgs, ...}: {
  services.bind = {
    enable = true;

    forwarders = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    # Limit recursive queries (cache access) to local/internal networks
    cacheNetworks = [
      "127.0.0.0/8"
      "::1/128"
      "192.168.200.0/24" # Wireguard network
      "192.168.0.0/24" # Home network
    ];

    zones = {
      # # Root domain zone
      # "c2yz.com" = {
      #   master = true;
      #   allowQuery = [
      #     "127.0.0.0/8"
      #     "::1/128"
      #     "192.168.0.0/24" # Home LAN
      #     "192.168.200.0/24" # Wireguard network
      #   ];
      #   file = pkgs.writeText "zone-c2yz.com" ''
      #     $TTL 300
      #     @   IN SOA ns1.c2yz.com. admin.c2yz.com. (
      #               2025102101 ; serial
      #               3600       ; refresh
      #               600        ; retry
      #               604800     ; expire
      #               86400      ; minimum
      #     )
      #     @   IN NS ns1.c2yz.com.
      #     ns1 IN A 192.168.200.1
      #     @   IN A 89.168.90.251

      #     ; Delegate photos subdomain
      #     photos IN NS ns1.c2yz.com.
      #   '';
      # };

      # Photos subdomain
      "photos.c2yz.com" = {
        master = true;
        allowQuery = [
          "127.0.0.0/8"
          "::1/128"
          "192.168.0.0/24" # Home LAN
          "192.168.200.0/24" # Wireguard network
        ];
        file = pkgs.writeText "zone-photos.c2yz.com" ''
          $TTL 300
          @   IN SOA ns1.c2yz.com. admin.c2yz.com. (
                    2025102102 ; serial (updated)
                    3600       ; refresh
                    600        ; retry
                    604800     ; expire
                    86400      ; minimum
          )
          @   IN NS ns1.c2yz.com.
          ns1 IN A 192.168.200.1
          @   IN A 192.168.200.1
          @   IN A 192.168.0.100
        '';
      };
    };
  };

  # Open ports in the firewall
  networking.firewall = {
    allowedTCPPorts = [53];
    allowedUDPPorts = [53];
  };
}
