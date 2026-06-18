# ==============================================================================
# MODULE: sway/lock-idle.nix
# Description: Screen locking and automated idle detection logic.
# Enforces system security state when the host is unattended.
# ==============================================================================
{ pkgs, ... }:
{
  # Cryptographic-style screen locker utilizing Wayland's ext-session-lock
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      ignore-empty-password = true;
      font = "JetBrainsMono Nerd Font";
      indicator-radius = 100;
      indicator-thickness = 10;
      # Generates a real-time blur array of the current viewport
      screenshots = true;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
    };
  };

  # Idle management daemon
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
      { timeout = 360; command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'"; resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'"; }
    ];
  };
}
