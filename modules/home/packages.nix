# home/packages.nix - User-space applications and command-line utilities
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pkgs.unstable.antigravity-cli
    brightnessctl
    wl-clipboard
    pulsemixer
    lunar-client
    moonlight-qt
    thunar
    slurp
    grim
    rar
  ];

  programs = {
    prismlauncher.enable = true;
    fastfetch.enable = true;
    firefox.enable = true;
    discord.enable = true;
    swappy.enable = true;
    vscode.enable = true;
    btop.enable = true;
    git.enable = true;
    mpv.enable = true;
    gh.enable = true;
  };

  services.cliphist = {
    enable = true;
    systemdTargets = [ "sway-session.target" ];
  };
}
