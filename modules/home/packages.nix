# ==============================================================================
# MODULE: home/packages.nix
# Description: User-level software and tooling mapped via Home Manager.
# ==============================================================================
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lunar-client
    moonlight-qt
    rar
    git
    pkgs.unstable.antigravity-cli
    firefox
  ];

  programs = {
    gh.enable = true;
    prismlauncher.enable = true;
    fastfetch.enable = true;
    mpv.enable = true;
    btop.enable = true;
    discord.enable = true;
  };
}
