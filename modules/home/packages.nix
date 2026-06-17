{ pkgs, ... }:
{
  home.packages = with pkgs; [
    moonlight-qt
    rar
  ];

  programs = {
    git.enable = true;
    mpv.enable = true;
    btop.enable = true;
    discord.enable = true;
  };
}
