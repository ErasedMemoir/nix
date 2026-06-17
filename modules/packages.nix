{ pkgs, ... }:
{
  services = {
    bpftune.enable = true;

    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };

    netbird = {
      enable = true;
      package = pkgs.unstable.netbird;
    };

    openssh = {
      enable = true;
      openFirewall = true;
    };
  };

  programs = {
    firefox.enable = true;
    nix-ld.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
    };

    steam = {
      enable = true;
      extraPackages = with pkgs; [ kdePackages.breeze ];
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
      package = pkgs.steam.override { extraArgs = "-silent steam://open/main"; };
    };
  };
}
