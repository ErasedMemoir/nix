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
