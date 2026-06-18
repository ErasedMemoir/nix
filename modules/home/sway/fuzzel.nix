# ==============================================================================
# MODULE: sway/fuzzel.nix
# Description: Ultra-fast, C-based native Wayland application launcher.
# Operates natively on wlroots without XWayland overhead.
# ==============================================================================
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "foot";
        font = "JetBrainsMono Nerd Font:size=13";
        prompt = ">>  ";
      };
      colors = {
        background = "1e1e2eff";
        text = "cdd6f4ff";
        match = "f38ba8ff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        border = "b4befeaa";
      };
    };
  };
}
