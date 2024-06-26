toplevel: { config, lib, pkgs, ... }:
let
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

    icons = {
      package = mkOption {
        type = types.package;
        default = pkgs.qogir-icon-theme;
      };

      themeName = mkOption {
        type = types.str;
        default = "Qogir-manjaro";
      };
    };

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

  config = {
    kyler.toolkits = {
      gtk = {
        icons = {
          themeName = lib.mkDefault cfg.icons.themeName;
          package = lib.mkDefault cfg.icons.package;
        };
        enable = mkIf cfg.autoEnable (mkDefault true);
      };

      qt = {
        icons = {
          themeName = lib.mkDefault cfg.icons.themeName;
          package = lib.mkDefault cfg.icons.package;
        };
        enable = mkIf cfg.autoEnable (mkDefault true);
      };
    };

    kyler.system = mkIf cfg.autoEnable {
      cursor.enable = mkDefault true;
      font.enable = mkDefault true;
    };

    kyler.applications = mkIf cfg.autoEnable {
      kitty.enable = mkDefault true;
      pywal.enable = mkDefault true;
      vscode.enable = mkDefault true;
    };
  };
}
