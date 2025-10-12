{pkgs, ...}: {
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = with pkgs; pinentry-all;
    enableSSHSupport = true;
  };
}
