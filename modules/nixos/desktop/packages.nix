# desktop/packages.nix - System-wide packages and compat layers
{ pkgs, ... }:
{
  services = {
    # Network Overlays
    # WARP: Used primarily for hosting local services (e.g., Minecraft)
    cloudflare-warp.enable = true;

    # Netbird: Used for connecting to external peers.
    # Enabled system-wide but managed manually to prevent DNS routing overlaps
    netbird = {
      enable = true;
      package = pkgs.unstable.netbird;
    };

    # Kernel Scheduling & Auto-tuning
    bpftune.enable = true;
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
  };

  programs = {
    nix-index-database.comma.enable = true;
    gamemode.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
    };

    steam = {
      enable = true;
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
    # Strictly curated font stack to minimize closure size
    nerd-fonts.jetbrains-mono # Primary system-wide monospace font
  ];
}
