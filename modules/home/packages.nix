# home/packages.nix - User-space applications and command-line utilities
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    webcord
    rar
    pkgs.unstable.antigravity-cli
    grim slurp wl-clipboard
    brightnessctl pulsemixer
    polkit_gnome thunar
  ];

  programs = {
    gh.enable = true;
    fastfetch.enable = true;
    mpv.enable = true;
    btop.enable = true;
    git.enable = true;
    swappy.enable = true;
    vscode.enable = true;
    foot = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=14";
        };
        colors-dark = {
          background = "000000";
          foreground = "ffffff";
          regular0 = "000000";
          regular1 = "aaaaaa"; # Brightened grey for visibility
          regular2 = "aaaaaa";
          regular3 = "aaaaaa";
          regular4 = "aaaaaa";
          regular5 = "aaaaaa";
          regular6 = "aaaaaa";
          regular7 = "ffffff";
          bright0 = "777777";
          bright1 = "cccccc";
          bright2 = "cccccc";
          bright3 = "cccccc";
          bright4 = "cccccc";
          bright5 = "cccccc";
          bright6 = "cccccc";
          bright7 = "ffffff";
        };
      };
    };

    # Secure Firefox profile for Wayland clipboard
    firefox = {
      enable = true;
      profiles.erased = {
        settings = {
          "widget.wayland.use-system-clipboard" = true;
          "clipboard.plainTextOnly" = false;
          "dom.events.asyncClipboard.readText" = true;
        };
      };
    };
  };

  services.cliphist = {
    enable = true;
    systemdTargets = [ "sway-session.target" ];
  };

  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
  };
}
