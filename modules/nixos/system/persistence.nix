# ==============================================================================
# MODULE: persistence.nix
# Description: Impermanence state definitions. Maps critical state files from
# the persistent BTRFS /data subvolume to the ephemeral root on boot.
# ==============================================================================
{
  preservation = {
    enable = true;
    preserveAt."/data" = {
      # Hide bind mounts from file managers to maintain a clean UI
      commonMountOptions = [
        "x-gvfs-hide"
        "x-gdu.hide"
      ];

      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      directories = [
        {
          directory = "/etc/nixos";
          user = "erased";
        }
        "/var/lib/cloudflare-warp"
        "/etc/NetworkManager"
        "/var/lib/netbird"
        "/var/lib/nixos"
        "/var/lib/sbctl"
        "/var/cache"
        "/var/log"
      ];
    };
  };

  # Suppress systemd warnings for machine-id handled during initrd execution
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
}
