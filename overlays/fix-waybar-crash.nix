final: prev: {
  waybar = prev.waybar.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (prev.fetchpatch {
        url = "https://patch-diff.githubusercontent.com/raw/Alexays/Waybar/pull/4589.patch";
        sha256 = "sha256-Obr1dkuZLuNFWAbUVSLOi61kJU7WCaDLAL9ZIErnshs=";
      })
    ];
  });
}
