{ inputs, lib, ... }:

let
  flakes = lib.filterAttrs (name: value: value ? outputs) inputs;
in
{
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/inputs/${name}";
    value.source = value.outPath;
  }) inputs;

  nix = {
    nixPath = [ "/etc/nix/inputs" ];
    registry = builtins.mapAttrs (_: value: { flake = value; }) flakes;
  };
}
