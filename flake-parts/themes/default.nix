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
    mkDefault
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
    kyler.system = {
      cursor.enable = mkDefault true;
      font.enable = mkDefault true;
    };

    kyler.applications = {
      kitty.enable = mkDefault true;
      pywal.enable = mkDefault true;
      vscode.enable = mkDefault true;
    };

    kyler.toolkits = {
      gtk.enable = mkDefault true;
      qt.enable = mkDefault true;
    };
  };
}
