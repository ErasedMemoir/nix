{ pkgs, ... }:
{
  home.packages = with pkgs; [
    moonlight-qt
    rar
    git
    pkgs.unstable.antigravity-cli
  ];

  programs = {
    fastfetch.enable = true;
    firefox.enable = true;
    mpv.enable = true;
    btop.enable = true;
    discord.enable = true;
      };
}
