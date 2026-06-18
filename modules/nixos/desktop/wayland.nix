# desktop/wayland.nix - Wayland init, auth, audio, TUI display manager
{ pkgs, ... }:
{
  # Enforce native Wayland and fix Java/Cursor rendering bugs
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1"; # Critical for PrismLauncher/Minecraft
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  # GUI authentication agent and keyring 
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  
  # Ensure PAM unlocks gnome-keyring upon login
  security.pam.services.greetd.enableGnomeKeyring = true;

  # Required for Thunar (File Manager) to mount USBs and use trash
  services.gvfs.enable = true; 
  # Required for GTK settings management via Home Manager
  programs.dconf.enable = true; 

  # Required for Wayland Screen Sharing (e.g. Discord via XWayland / WebRTC)
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # Advanced Multimedia Framework
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Secure Minimalist Terminal UI Login Manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter"; # FIXED: Runs securely, prompting for 'erased' password
      };
    };
  };
}
