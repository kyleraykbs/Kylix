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
    gtk = importApply ./gtk.nix toplevel;
    qt = importApply ./qt.nix toplevel;
    default.imports = combineModules config.flake.homeManagerModules;
  };
}