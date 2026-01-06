{ lib, ... }@arguments:

# Import overlays
let
  utils = import ./../utils.nix arguments;
  _filter = _path: (lib.strings.hasSuffix ".nix" _path && _path != ./configuration.nix);
  files = utils.listVisibleFilesRecursive ./.;
in
{
  nixpkgs.overlays = map import (lib.filter _filter files);
}
