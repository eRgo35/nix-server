{pkgs, ...}: {
  services.bind = {
    enable = true;
    cacheNetworks = ["127.0.0.0/24" "::1/128" "192.168.0.0/24"];
    zones = {
      "c2yz.com" = {
        master = true;
        allowQuery = ["127.0.0.0/24" "::1/128" "192.168.0.0/24"];
        file = pkgs.writeText "zone-example.com" ''
          ...
        '';
      };
    };

    # internal view for WireGuard clients only
    views = {
      internal = {
        # match your WireGuard subnet (and localhost so server can query)
        matchClients = ["192.168.200.0/24" "127.0.0.1" "::1/128"];
        recursion = true;
        allowQuery = ["192.168.200.0/24" "127.0.0.1" "::1/128"];

        zones = {
          "photos.c2yz.com" = {
            type = "master";
            file = pkgs.writeText "zone-photos.c2yz.com" ''
              $TTL 300
              @   IN SOA ns1.c2yz.com. admin.c2yz.com. (
                        2025102101 ; serial (update)
                        3600       ; refresh
                        600        ; retry
                        604800     ; expire
                        86400      ; minimum
              )
              @ IN NS ns1.c2yz.com.
              ns1 IN A 192.168.200.1
              photos IN A 192.168.200.10
            '';
          };
        };
      };
    };
  };
}
