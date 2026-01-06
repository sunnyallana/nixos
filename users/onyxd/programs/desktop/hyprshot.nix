{ pkgs, lib, ... }:

let
  hyprshotGui = pkgs.stdenv.mkDerivation rec {
    pname = "hyprshot-gui";
    version = "v1.5.0";
    src = pkgs.fetchFromGitHub {
      owner = "s-adi-dev";
      repo = "hyprshot-gui";
      rev = version;
      sha256 = "sha256-Sbl4O/mVPP1kCjwS/MF2TYdKd/3dUKHvscsffiOqC2o=";
    };

    buildInputs = with pkgs; [
      (python3.withPackages (ps: with ps; [ pygobject3 ]))
      gobject-introspection
    ];

    nativeBuildInputs = with pkgs; [ wrapGAppsHook4 ];

    installPhase = ''
      mkdir -p $out/bin $out/share/applications
      cd src
      cp hyprshot-gui $out/bin/
      cp hyprshot.desktop $out/share/applications/
    '';

    postFixup = ''
       wrapProgram $out/bin/hyprshot-gui \
      	    --prefix PATH : ${lib.makeBinPath (with pkgs; [ hyprshot ])}
    '';
  };
in
{
  home.packages = [ hyprshotGui ];
}
