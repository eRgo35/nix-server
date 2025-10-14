{
  imports = [
    ./programs/git.nix
  ];

  home = {
    username = "mike";
    homeDirectory = "/home/mike";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Michał Czyż";
    userEmail = "mike@c2yz.com";
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      la = "ls -la";
      ga = "git add";
      gaa = "git add .";
      gap = "git add -p";
      gs = "git status";
      gc = "git commit -m";
      gu = "git push";
      gp = "git pull";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
