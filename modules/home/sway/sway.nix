{
  wayland.windowManager.sway = {
    enable = true;
    config = {
    input = {
        "type:keyboard" = {
          xkb_layout = "it";
        };
      };
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "foot";
      startup = [
        # Launch Firefox on start
        { command = "firefox"; }
      ];
    };
  };
}
