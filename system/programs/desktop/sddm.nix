{ pkgs, ... }:

let
  cursor = pkgs.catppuccin-cursors.mochaMauve;
in
{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    extraPackages = [ cursor ];
    settings.General.GreeterEnvironment = "XCURSOR_THEME=catppuccin-mocha-mauve-cursors,XCURSOR_SIZE=24,XCURSOR_PATH=${cursor}/share/icons:/run/current-system/sw/share/icons"; # why does this work :sob:
  };
}
