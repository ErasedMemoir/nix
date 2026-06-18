# ==============================================================================
# MODULE: gaming.nix
# Description: User-level gaming applications and game launchers.
# Isolated to keep core user packages organized and strictly GTK/Wayland.
# ==============================================================================
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Minecraft Launchers (requires X11/Qt & custom Java variables)
    lunar-client
    prismlauncher
    
    # Game streaming client (Qt-based)
    moonlight-qt
  ];
}
