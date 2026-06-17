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
        {
          file = "/etc/ssh/ssh_host_rsa_key";
          configureParent = true;
          how = "symlink";
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          configureParent = true;
          how = "symlink";
        }
      ];

      directories = [
        {
          directory = "/home/vm";
          user = "vm";
        }
        {
          directory = "/tmp";
          mode = "1777";
        }
        "/var/lib/netbird"
        "/var/cache"
        "/var/log"
      ];
    };
  };

  zramSwap.enable = true;
  boot.tmp.cleanOnBoot = true;
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
}
