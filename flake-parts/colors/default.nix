toplevel: { config, lib, ... }:
let
  inherit (toplevel.config.flake.lib)
    verifyHexColor
    ;

  inherit (toplevel.config.flake.lib.types)
    colors
    ;

  inherit (lib)
    mkOption
    mkEnableOption
    mkIf
    types
    ;
  
  cfg = config.kyler;
in
{
  options.kyler = {
    applications = {};

    colors = mkOption {
      type = types.nullOr colors;
      default = null;
    };

    opacity = mkOption {
      type = types.int;
      default = 100;
    };

    autoEnable = mkEnableOption "Automatically enable all home theming and NixOS theming.";
  };

  config = mkIf cfg.autoEnable {
    kyler.applications = {
      kitty.enable = true;
      pywal.enable = true;
      vscode.enable = true;
    };

    kyler.toolkits = {
      gtk.enable = true;
      qt.enable = true;
    };
  };
}