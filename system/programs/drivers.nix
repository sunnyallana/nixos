{ pkgs, ... }:

{
  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt
        intel-media-driver
        libvdpau-va-gl
        intel-compute-runtime
      ];
    };
  };

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
}
