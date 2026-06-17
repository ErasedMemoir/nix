# ==============================================================================
# MODULE: persistence.nix
# Description: Explicitly defines files and directories that must survive
# the ephemeral root wipe sequence upon system boot.
# ==============================================================================
{
  preservation = {
    enable = true;
    preserveAt."/data" = {
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

  # Service complains about missing machine-id, so we suppress it since we're preserving it in the initrd
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
}
