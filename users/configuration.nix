{
  home-manager,
  lib,
  inputs,
  ...
}@arguments:

let
  utils = import ./../utils.nix arguments;
  users =
    let
      filter = name: type: type == "directory" && !lib.strings.hasPrefix "_" name;
    in
    lib.filterAttrs filter (builtins.readDir ./.);
in
{
  imports =
    let
      mapping = (name: _: ./${name}/configuration.nix);
    in
    [ home-manager.nixosModules.home-manager ] ++ (lib.attrsets.mapAttrsToList mapping users);

  home-manager =
    # Import user programs
    let
      mapping =
        name: value:
        let
          _files = utils.listVisibleFilesRecursive ./${name}/programs;
          files = lib.filter (_path: lib.strings.hasSuffix ".nix" _path) _files;
        in
        {
          imports = files;
          home = rec {
            username = lib.mkDefault name;
            homeDirectory = lib.mkDefault "/home/${username}";
          };
        };
    in
    {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = inputs;
      users = lib.mapAttrs mapping users;
    };
}
