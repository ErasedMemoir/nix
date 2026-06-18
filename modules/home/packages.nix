# ==============================================================================
# MODULE: home/packages.nix
# Description: Defines the user's primary toolchain and application payload.
# Note: Core Wayland tools (foot, fuzzel, mako) are managed in their own modules.
# ==============================================================================
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # General Applications
    lunar-client
    prismlauncher
    moonlight-qt
    discord
    firefox
    rar
    git
    pkgs.unstable.antigravity-cli

    # Window Manager Utilities (Sway Ecosystem)
    grim           # Wayland compositor image grabber
    slurp          # Wayland region selector
    swappy         # Immediate screenshot annotation editor
    wl-clipboard   # Native command-line clipboard utility
    cliphist       # Wayland clipboard manager daemon
    brightnessctl  # CLI backlight controller
    pulsemixer     # CLI audio mixer for PipeWire
    i3status       # Low-overhead status line generator for swaybar
  ];

  programs = {
    gh.enable = true;
    fastfetch.enable = true;
    mpv.enable = true;
    btop.enable = true;

    # Highly optimized, C-based native Wayland terminal
    foot.enable = true;
  };
}
