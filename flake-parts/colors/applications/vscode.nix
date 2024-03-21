toplevel: { pkgs, config, lib, ... }:
let
  inherit (toplevel.config.flake.lib)
    verifyHexColor
    mapColorHex
    ;
  
  inherit (toplevel.config.flake.lib.types)
    colors
    basecolors
    buildColorsOverrideType
    ;

  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;
  
  cfg = config.kyler.applications.vscode;
in
{
  options.kyler.applications.vscode = {
    enable = mkEnableOption "vscode plugin setup.";

    # No colormap here as vscode uses pywals colormap
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      # TODO: impliment this without using Wal.

      userSettings = {
        #"workbench.colorTheme" = "Wal";
      };
    };
  };
}