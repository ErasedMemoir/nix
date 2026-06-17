{ pkgs, ... }:
let
  pname = "sunshine";
  version = "2026.516.143833";

  src = pkgs.fetchurl {
    url = "https://github.com/LizardByte/Sunshine/releases/download/v${version}/sunshine.AppImage";
    hash = "sha256-0O4KnPtm8nhptVlFX4RiLSFhUEfM80Q8mi9XLKlxx6I=";
  };

  appimageContents = pkgs.appimageTools.extractType2 {
    inherit pname src version;
  };

  sunshineAppImage = pkgs.appimageTools.wrapType2 {
    profile = "unset LD_LIBRARY_PATH";
    inherit pname src version;

    extraInstallCommands = ''
      install -Dm444 \
        ${appimageContents}/usr/share/sunshine/udev/rules.d/60-sunshine.rules \
        $out/lib/udev/rules.d/60-sunshine.rules
    '';

    meta.mainProgram = pname;
  };
in
{
  services.sunshine = {
    enable = true;
    openFirewall = true;
    # Set the package to the AppImage until latest version was packaged in nixpkgs
    package = sunshineAppImage;
    settings = {
      capture = "kwin";
      encoder = "software";
    };
  };
}
