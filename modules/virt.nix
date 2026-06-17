{ modulesPath, pkgs, ... }:
{
  imports = [ (modulesPath + "/virtualisation/qemu-vm.nix") ];

  virtualisation = {
    memorySize = 12288;
    diskImage = null;
    cores = 8;

    forwardPorts = [
      {
        host.address = "127.0.0.1";
        from = "host";
        host.port = 2222;
        guest.port = 22;
      }
    ];

    fileSystems."/data" = {
      device = "/dev/disk/by-label/data";
      neededForBoot = true;
      fsType = "ext4";
    };

    qemu = {
      forceAccel = true;
      package = pkgs.unstable.qemu;
      drives = [
        {
          file = "$DATA_IMAGE";
          driveExtraOpts.format = "raw";
          deviceExtraOpts.serial = "data";
        }
      ];

      options = [
        "-machine q35"
        "-vga none"
        "-cpu host"
        "-display egl-headless"
        # "-display gtk,gl=on"
        "-device virtio-vga-gl,hostmem=4G,blob=true,drm_native_context=true"
      ];
    };
  };
}
