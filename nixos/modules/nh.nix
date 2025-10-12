{
  programs.nh = {
    enable = true;
    flake = "/home/mike/.nixos";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 3d --keep 3";
    };
  };
}
