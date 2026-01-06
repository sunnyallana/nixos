{
  catppuccin,
  ...
}:

{
  imports = [ catppuccin.nixosModules.catppuccin ];

  catppuccin = {
    enable = true;
    sddm.font = "Maple UI";
  };
}
