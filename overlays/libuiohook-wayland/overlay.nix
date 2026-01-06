final: prev: {
  libuiohook = prev.libuiohook.overrideAttrs (old: rec {
    version = "fork-${src.rev}";
    src = prev.fetchFromGitHub {
      owner = "TolikPylypchuk";
      repo = "libuiohook";
      rev = "57a8f17";
      sha256 = "sha256-exBXmXcDN3loY8z4XoNCEoXI4vVvyaJflQl4KKAW92k=";
    };

    cmakeFlags = (old.cmakeFlags or [ ]) ++ [ "-DENABLE_TEST=OFF" ];
    outputs = [ "out" ];
    postInstall = null;
    patches = (old.patches or [ ]) ++ [ ./fix-uiohook-pc.patch ];
  });
}
