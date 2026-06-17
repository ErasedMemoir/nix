{ pkgs, ... }:
{
  home.packages = with pkgs; [
    moonlight-qt
    rar
    pkgs.unstable.antigravity-cli
  ];

  programs = {
    fastfetch.enable = true;
    firefox.enable = true;
    git.enable = true;
    mpv.enable = true;
    btop.enable = true;
    discord.enable = true;
      };
}
