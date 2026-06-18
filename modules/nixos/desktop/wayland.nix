# ==============================================================================
# MODULE: wayland.nix
# Description: OS-level graphical subsystem initialization. Establishes native
# Wayland enforcement, TUI login management, and audio/authentication daemons.
# ==============================================================================
{ pkgs, ... }:
{
  # ----------------------------------------------------------------------------
  # Environment & Protocols
  # ----------------------------------------------------------------------------
  # Force electron/chromium and toolkit applications to default to Wayland
  environment.variables.NIXOS_OZONE_WL = "1";

  # ----------------------------------------------------------------------------
  # Security & Authentication Agents
  # ----------------------------------------------------------------------------
  # Required for graphical applications escalating to root (e.g., GParted, disks)
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # ----------------------------------------------------------------------------
  # Audio Subsystem (PipeWire)
  # ----------------------------------------------------------------------------
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # ----------------------------------------------------------------------------
  # Display Manager (Minimal TUI)
  # ----------------------------------------------------------------------------
  # Replaces bloated managers like SDDM. Boots into a clean terminal UI,
  # authenticates, and executes the Sway binary directly.
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "erased";
      };
    };
  };
}
