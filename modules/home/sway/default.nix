# sway/default.nix - Core WM logic, hardware inputs, keybindings
{ config, lib, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    
    # Ensures environment variables are exported to the systemd user session
    wrapperFeatures.gtk = true; 
    
    config = {
      modifier = "Mod4"; # Super/Windows key
      terminal = "foot";
      menu = "rofi -show drun";

      # Hardware input definitions
      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
        # Enforce Italian layout globally
        "type:keyboard" = {
          xkb_layout = "it"; 
        };
      };

      # Set wallpaper
      output = {
        "*" = { bg = "${./wallpaper.png} fill"; };
      };

      bars = [];

      # Window Decoration Colors
      colors = {
        focused = {
          border = "#888888";
          background = "#888888";
          text = "#ffffff";
          indicator = "#888888";
          childBorder = "#888888";
        };
        focusedInactive = {
          border = "#333333";
          background = "#333333";
          text = "#888888";
          indicator = "#333333";
          childBorder = "#333333";
        };
        unfocused = {
          border = "#000000";
          background = "#000000";
          text = "#888888";
          indicator = "#000000";
          childBorder = "#000000";
        };
        urgent = {
          border = "#ffffff";
          background = "#ffffff";
          text = "#000000";
          indicator = "#ffffff";
          childBorder = "#ffffff";
        };
      };

      # Background daemons and initial application payload
      startup = [
        { command = "firefox"; }
        { command = "waybar"; }
        # Store clipboard history with a strict 10-item limit
        { command = "wl-paste --watch cliphist store -max-items 10"; } 
      ];

      # Keybindings mapping
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
        term = config.wayland.windowManager.sway.config.terminal;
        menu = config.wayland.windowManager.sway.config.menu;
      in lib.mkOptionDefault {
        # --- System Commands ---
        "${mod}+Return" = "exec ${term}";
        "${mod}+d" = "exec ${menu}";
        "${mod}+Shift+q" = "kill";
        "${mod}+Shift+c" = "reload";
        
        # --- Application Shortcuts ---
        "${mod}+b" = "exec firefox";
        "${mod}+c" = "exec webcord";
        "${mod}+f" = "exec thunar";

        # --- Hardware Control ---
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";

        # --- Screenshot Workflow ---
        # 1. Quick Capture: Select region -> Wayland clipboard (image/png)
        "${mod}+Shift+s" = ''exec grim -g "$(slurp)" - | wl-copy -t image/png'';

        # 2. Edit Capture: Select region -> Pipe to Swappy graphical editor
        "Print" = ''exec grim -g "$(slurp)" - | swappy -f -'';
      };
    };
  };

  # Declarative background daemon for Polkit GUI authentication
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
