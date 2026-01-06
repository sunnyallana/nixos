{
  catppuccin,
  config,
  pkgs,
  ...
}:

let
  colloidIcons = (
    pkgs.colloid-icon-theme.override {
      schemeVariants = [ "catppuccin" ];
    }
  );

  qtctConfig = {
    icon_theme = "Colloid-Catppuccin-Dark";
    style = "kvantum";
  };
in
{
  imports = [ catppuccin.homeModules.catppuccin ];
  catppuccin = {
    enable = true;
    waybar.mode = "createLink";
    gtk.icon.enable = false;
    kvantum.enable = false; # since it doesn't allow for qtct being an exception in it's assertions
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
    name = "catppuccin-mocha-mauve-cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 24;
  };

  gtk = {
    theme = {
      name = "catppuccin-mocha-mauve-compact";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "mocha";
        size = "compact";
      };
    };
    iconTheme = {
      name = "Colloid-Catppuccin-Dark";
      package = colloidIcons;
    };
  };

  # Manual kvantum support
  home.packages = with pkgs; [
    colloidIcons
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
  ];

  xdg.configFile."Kvantum/catppuccin-mocha-mauve".source =
    "${config.catppuccin.sources.kvantum}/share/Kvantum/catppuccin-mocha-mauve";
  qt.kde.settings = {
    "kdeglobals".Icons.Theme = "Colloid-Catppuccin-Dark";
    "Kvantum/kvantum.kvconfig".General.theme = "catppuccin-mocha-mauve";
    "qt5ct/qt5ct.conf".Appearance = qtctConfig;
    "qt6ct/qt6ct.conf".Appearance = qtctConfig;
  };
}
