toplevel: { config, lib, ... }:
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
  
  cfg = config.kyler.applications.kitty;
in
{
  options.kyler.applications.kitty = {
    enable = mkEnableOption "kitty theming";

    colorsOverride = mkOption {
      type = buildColorsOverrideType config.kyler.colors;
      default = {};
    };

    opacity = mkOption {
      type = types.int;
      default = config.kyler.opacity;
    };

    font = {
      enable = mkOption {
        type = types.bool;
        default = config.kyler.system.font.enable;
      };

      package = mkOption {
        type = types.package;
        default = config.kyler.system.font.primaryPackage;
      };

      size = mkOption {
        type = types.int;
        default = config.kyler.system.font.size;
      };

      name = mkOption {
        type = types.str;
        default = config.kyler.system.font.primaryName;
      };
    };

    colorMap = {
      background = mkOption {
        type = basecolors;
        default = "base00";
      };
      foreground = mkOption {
        type = basecolors;
        default = "base05";
      };
      color0 = mkOption {
        type = basecolors;
        default = "base00";
      };
      color8 = mkOption {
        type = basecolors;
        default = "base01";
      };

      # red
      color1 = mkOption {
        type = basecolors;
        default = "base08";
      };
      color9 = mkOption {
        type = basecolors;
        default = "base08";
      };

      # green
      color2 = mkOption {
        type = basecolors;
        default = "base0B";
      };
      color10 = mkOption {
        type = basecolors;
        default = "base0B";
      };

      # yellow
      color3 = mkOption {
        type = basecolors;
        default = "base0A";
      };
      color11 = mkOption {
        type = basecolors;
        default = "base0A";
      };

      # blue
      color4 = mkOption {
        type = basecolors;
        default = "base0D";
      };
      color12 = mkOption {
        type = basecolors;
        default = "base0D";
      };

      # magenta
      color5 = mkOption {
        type = basecolors;
        default = "base0E";
      };
      color13 = mkOption {
        type = basecolors;
        default = "base0E";
      };

      # cyan
      color6 = mkOption {
        type = basecolors;
        default = "base0C";
      };
      color14 = mkOption {
        type = basecolors;
        default = "base0C";
      };

      # white
      color7 = mkOption {
        type = basecolors;
        default = "base06";
      };
      color15 = mkOption {
        type = basecolors;
        default = "base07";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      font = mkIf cfg.font.enable {
        size = cfg.font.size;
        package = cfg.font.package;
        name = cfg.font.name;
      };
      settings = {
        foreground = "${mapColorHex cfg.colorsOverride cfg.colorMap.foreground}";
        background = "${mapColorHex cfg.colorsOverride cfg.colorMap.background}";
        color0 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color0}";
        color1 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color1}";
        color2 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color2}";
        color3 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color3}";
        color4 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color4}";
        color5 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color5}";
        color6 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color6}";
        color7 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color7}";
        color8 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color8}";
        color9 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color9}";
        color10 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color10}";
        color11 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color11}";
        color12 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color12}";
        color13 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color13}";
        color14 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color14}";
        color15 = "${mapColorHex cfg.colorsOverride cfg.colorMap.color15}";
        background_opacity = "${builtins.toString ((cfg.opacity + 0.0) / 100.0)}";
      };
    };
  };
}
