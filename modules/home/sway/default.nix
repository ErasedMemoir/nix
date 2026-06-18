# ==============================================================================
# MODULE: sway/default.nix
# Description: The brain of the user environment. Manages layout rules, hardware
# input mappings, keybindings, and the native C-based swaybar.
# ==============================================================================
{ config, lib, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;

    # Ensures environment variables are exported to the systemd user session
    wrapperFeatures.gtk = true;

    config = {
      modifier = "Mod4"; # Primary modifier: Super/Windows key
      terminal = "foot";
      menu = "fuzzel";

      # Hardware input configuration
      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };

      # Status bar implementation (Swaybar + i3status)
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = [ "JetBrainsMono Nerd Font" ];
            size = 11.0;
          };
          colors = {
            background = "#1e1e2e";
            statusline = "#cdd6f4";
            separator = "#6c7086";
          };
        }
      ];

      # Background daemons and initial application payload
      startup = [
        { command = "firefox"; }
        # Store clipboard history with a strict 10-item limit for privacy and memory hygiene
        { command = "wl-paste --watch cliphist store -max-items 10"; }
      ];

      # Keybindings definition
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
        term = config.wayland.windowManager.sway.config.terminal;
        menu = config.wayland.windowManager.sway.config.menu;
      in lib.mkOptionDefault {
        "${mod}+Return" = "exec ${term}";
        "${mod}+d" = "exec ${menu}";
        "${mod}+q" = "kill";
        "${mod}+Shift+c" = "reload";

        # Hardware Control: Audio & Brightness mapping
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";

        # ----------------------------------------------------------------------
        # Screenshot Architecture
        # ----------------------------------------------------------------------
        # 1. Quick Capture: Select region -> Send to Wayland clipboard.
        # The '-t image/png' flag explicitly defines the MIME type for Discord integration.
        "${mod}+Shift+s" = ''exec grim -g "$(slurp)" - | wl-copy -t image/png'';

        # 2. Advanced Capture: Select region -> Pipe to Swappy for annotation.
        "Print" = ''exec grim -g "$(slurp)" - | swappy -f -'';
      };
    };
  };
}
