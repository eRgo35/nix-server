{ config, pkgs, ... }: {
  users.users.git = {
    isSystemUser = true;
    group = "git";
    home = "/var/lib/git-server";
    createHome = true;
    shell = "${pkgs.git}/bin/git-shell";
    openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINBehbdWBTyhs8Tqnc7w172XhWcPAcAM6BC9Gny3i8An mike@zion"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO3xXO97oTwDMQhwlDcgeRgo+05urrSaKv/bvqvH2Wus mike@thor"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCj2eJcNnzYW3O64LFunkDeQDPShD2oK/nivcwzSgwe u0_a670@localhost"
    ];
  };

  users.groups.git = {};

  services.openssh = {
    enable = true;
    extraConfig = ''
      Match user git
        AllowTcpForwarding no
        AllowAgentForwarding no
        PasswordAuthentication no
        PermitTTY no
        X11Forwarding no
    '';
  };
}
