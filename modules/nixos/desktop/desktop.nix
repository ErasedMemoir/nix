# ==============================================================================
# MODULE: desktop.nix
# Description: Display server, compositor, and audio subsystem configuration.
# ==============================================================================
{ pkgs, ... }:
{
  # Force apps to use Wayland by default
  environment.variables.NIXOS_OZONE_WL = 1;

  services = {
    desktopManager.plasma6.enable = true;

    displayManager ={
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
    # Enable PipeWire with ALSA and PulseAudio support
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  # Exclude unnecessary KDE packages
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    khelpcenter
    kwin-x11
    discover
    aurorae
    okular
    elisa
    krdp
    qrca
  ];
}
