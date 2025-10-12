{
  programs.git = {
    enable = true;

    userName = "Michał Czyż";
    userEmail = "mike@c2yz.com";

    signing = {
      key = "9745B9E27E2B1ABB";
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      commit.gpgsign = true;
      push.enabled = true;
      column.ui = "auto";
      branch.sort = "-committerdate";
      pull.rebase = "false";
      rerere.enabled = true;
      tag.gpgSign = true;
      push.gpgsign = "if-asked";
    };
  };
}
