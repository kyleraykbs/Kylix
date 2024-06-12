toplevel: { config, lib, flake-parts-lib, ... }:
let
  inherit (flake-parts-lib) importApply;

  inherit (toplevel.config.flake.lib)
    combineModules
    ;

  inherit (lib)
    mkOption
    types
    ;
in
{
  config.flake.homeManagerModules = {
    cursor = importApply ./cursor.nix toplevel;
    default.imports = combineModules config.flake.homeManagerModules;
  };
}
