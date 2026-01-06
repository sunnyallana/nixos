{ pkgs, lib, ... }:

let
  maple-ui = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "maple-ui-font";
    version = "unstable-2024-01-01";

    srcs = [
      (pkgs.fetchurl {
        url = "https://github.com/subframe7536/maple-font/raw/other-resources/cn-resource/maple-ui/Maple%20UI.ttf";
        sha256 = "sha256-rUAEjONhJGub49VwJcK5llhzUx0aa81wSKK3CVtGN0g=";
      })
      (pkgs.fetchurl {
        url = "https://github.com/subframe7536/maple-font/raw/other-resources/cn-resource/maple-ui/Maple%20UI%20Bold.ttf";
        sha256 = "sha256-iB8Fyb2t3IZKgkzpfkbSR+ssaL6fxJsbPqZcns/y6KQ=";
      })
    ];

    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      install -Dm644 -t $out/share/fonts/truetype ${toString srcs}
      runHook postInstall
    '';

    meta = with lib; {
      description = "Maple UI font family";
      homepage = "https://github.com/subframe7536/maple-font";
      license = licenses.ofl;
      platforms = platforms.all;
    };
  };
in
{
  fonts = {
    packages = with pkgs; [
      maple-ui
      maple-mono.NF
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Maple Mono NF" ];
        sansSerif = [ "Maple UI" ];
        serif = [ "Maple UI" ];
      };
    };
  };
}
