{ pkgs, ... }:
{
  services = {
    bpftune.enable = true;
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };

    netbird = {
      enable = true;
      package = pkgs.unstable.netbird;
    };
  };

  programs = {
    nix-index-database.comma.enable = true;
    gamemode.enable = true;
    nix-ld.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
    };

    steam = {
      enable = true;
      # extraPackages = with pkgs; [ kdePackages.breeze ]; # Fix for default cursor in steam ui
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    nh = {
      enable = true;
      flake = "/etc/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 3";
      };
    };
  };

  environment.systemPackages = with pkgs; [ sbctl ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    nerd-fonts.hack
    liberation_ttf
    vista-fonts
    noto-fonts
    corefonts
  ];
}
