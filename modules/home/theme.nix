{ pkgs, ... }:
{
  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 32;

    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
  };

  programs = {
    foot = {
      enable = true;
      settings = {
        main.font = "JetBrainsMono Nerd Font:size=14";
        colors-dark = {
          background = "000000";
          foreground = "ffffff";
          regular0 = "000000";
          regular1 = "aaaaaa";
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
  };
}
