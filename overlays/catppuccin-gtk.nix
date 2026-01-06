final: prev: {
  catppuccin-gtk = prev.catppuccin-gtk.overrideAttrs (old: rec {
    version = "1.0.5";

    src = prev.fetchFromGitHub {
      owner = "VanillaDaFur";
      repo = "catppuccin-gtk";
      tag = "v${version}";
      fetchSubmodules = true;
      hash = "sha256-JZoREtFF17Ze/lPrpnqkJclqpZquVKRv53Fp+Ztg3tw=";
    };

    patches = [ ];
  });
}
