{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    mike = {
      isNormalUser = true;
      extraGroups = ["wheel" "docker"]; # Enable ‘sudo’ for the user.
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINBehbdWBTyhs8Tqnc7w172XhWcPAcAM6BC9Gny3i8An mike@zion"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO3xXO97oTwDMQhwlDcgeRgo+05urrSaKv/bvqvH2Wus mike@thor"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCj2eJcNnzYW3O64LFunkDeQDPShD2oK/nivcwzSgwe u0_a670@localhost"
      ];
    };
  };
}
