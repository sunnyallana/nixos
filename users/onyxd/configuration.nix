# warning: error: unable to download 'https://attic.xuyh0120.win/lantian/nar/yzncylfazzl7plzm8j0rr64yr934s6y8.nar': HTTP error 200 (curl error: Failure when receiving data from the peer); retrying from offset 46821485 in 271 ms

{
  users.users.onyxd = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "libvirtd"
      "input"
    ];
    hashedPassword = "$y$j9T$jq.0seQ5KcrbGp8gFVu0g1$TYh2bfQDHt37oJAB/HjbrGOTeZ4oGL0sz3xpK8Mm2dA"; # nix shell nixpkgs#mkpasswd --command "mkpasswd"
  };

  home-manager.users.onyxd = {
    home.stateVersion = "25.11";
    programs.home-manager.enable = true;
  };
}
