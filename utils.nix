{ lib, ... }:

{
  listVisibleFilesRecursive =
    dir:
    let
      pipe = [
        (lib.filterAttrs (name: _: !lib.strings.hasPrefix "_" name))
        (lib.mapAttrsToList (
          name: type:
          (if type == "directory" then lib.filesystem.listFilesRecursive else lib.id) /${dir}/${name}
        ))
        lib.flatten
      ];
    in
    lib.pipe (builtins.readDir dir) pipe;
}
