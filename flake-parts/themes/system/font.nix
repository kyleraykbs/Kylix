toplevel: { config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.kyler.system.font;
in
{
  options.kyler.system.font = {
    enable = mkEnableOption "cursor";

    packages = mkOption {
      type = types.listOf types.package;
      default = [
        config.kyler.system.font.primaryPackage
      ];
    };

    serif = mkOption {
      type = types.listOf types.str;
      default = [ config.kyler.system.font.primaryName ];
    };

    sansSerif = mkOption {
      type = types.listOf types.str;
      default = [ config.kyler.system.font.primaryName ];
    };

    monospace = mkOption {
      type = types.listOf types.str;
      default = [ config.kyler.system.font.primaryName ];
    };

    size = mkOption {
      type = types.int;
      default = 12;
    };

    primaryPackage = mkOption {
      type = types.package;
      default = pkgs.ubuntu_font_family;
    };

    primaryName = mkOption {
      type = types.str;
      default = "Ubuntu Mono";
    };
  };

  config = mkIf cfg.enable {
    home.packages = cfg.packages;

    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = cfg.serif;
          sansSerif = cfg.sansSerif;
          monospace = cfg.monospace;
        };
      };
    };
  };
}
