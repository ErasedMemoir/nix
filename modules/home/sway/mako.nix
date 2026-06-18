# ==============================================================================
# MODULE: sway/mako.nix
# Description: Minimalist, stateless notification daemon for Wayland.
# ==============================================================================
{
  services.mako = {
    enable = true;
    font = "JetBrainsMono Nerd Font 11";
    padding = "15";
    margin = "10";
    defaultTimeout = 5000;
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#89b4fa";
    borderSize = 2;
    borderRadius = 5;
  };
}
