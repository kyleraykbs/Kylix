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
    kitty = importApply ./kitty.nix toplevel;
    pywal = importApply ./pywal.nix toplevel;
    vscode = importApply ./vscode.nix toplevel;
    default.imports = combineModules config.flake.homeManagerModules;
  };
}