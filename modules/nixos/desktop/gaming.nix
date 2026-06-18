# ==============================================================================
# MODULE: gaming.nix
# Description: X11/Qt compatibility layer and gaming-specific daemons.
# Separated to keep the core Wayland ecosystem pristine and bloat-free.
# ==============================================================================
{ pkgs, ... }:
{
  programs = {
    # System optimizations for gaming workloads
    gamemode.enable = true;

    # Steam requires a massive 32-bit X11 compatibility layer
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };
}
