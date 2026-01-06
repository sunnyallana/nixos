{ lib, ... }:

{
  services.dunst = {
    enable = true;
    settings.global = {
      corner_radius = 8;
      gap_size = 8;
      frame_width = 2;
    };
  };

  systemd.user.services.dunst = lib.mkForce { };
}
