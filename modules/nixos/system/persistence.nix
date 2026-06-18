# system/persistence.nix - Impermanence state definitions
{
  preservation = {
    enable = true;
    preserveAt."/data" = {
      commonMountOptions = [ "x-gvfs-hide" "x-gdu.hide" ];
      
      files = [
        { file = "/etc/machine-id"; inInitrd = true; }
      ];

      directories = [
        { directory = "/etc/nixos"; user = "erased"; }
        "/var/lib/bluetooth" # Saves paired devices
        "/etc/NetworkManager"
        "/var/lib/netbird"
        "/var/lib/nixos"
        "/var/lib/sbctl"
        "/var/cache"
        "/var/log"
      ];
      
      users.erased = {
        directories = [
          ".ssh"
          ".mozilla"
          ".config/discord"
          ".config/WebCord"
          ".config/Code"
          ".local/share/PrismLauncher"
          ".local/state/wireplumber" # Saves audio volumes
          "Documents"
          "Downloads"
          "Desktop"
        ];
      };
    };
  };

  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
}
