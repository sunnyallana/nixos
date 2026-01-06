{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [ hyprpolkitagent ];
}
