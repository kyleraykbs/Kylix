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
  
  cfg = config.kyler.applications.pywal;
in
{
  options.kyler.applications.pywal = {
    enable = mkEnableOption "PYWal schema export.";

    colorsOverride = mkOption {
      type = buildColorsOverrideType config.kyler.colors;
      default = {};
    };

    opacity = mkOption {
      type = types.int;
      default = config.kyler.opacity;
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
      color1 = mkOption {
        type = basecolors;
        default = "base08";
      };
      color2 = mkOption {
        type = basecolors;
        default = "base09";
      };
      color3 = mkOption {
        type = basecolors;
        default = "base0A";
      };
      color4 = mkOption {
        type = basecolors;
        default = "base0B";
      };
      color5 = mkOption {
        type = basecolors;
        default = "base0C";
      };
      color6 = mkOption {
        type = basecolors;
        default = "base0D";
      };
      color7 = mkOption {
        type = basecolors;
        default = "base0E";
      };
      color8 = mkOption {
        type = basecolors;
        default = "base05";
      };
      color9 = mkOption {
        type = basecolors;
        default = "base01";
      };
      color10 = mkOption {
        type = basecolors;
        default = "base02";
      };
      color11 = mkOption {
        type = basecolors;
        default = "base03";
      };
      color12 = mkOption {
        type = basecolors;
        default = "base04";
      };
      color13 = mkOption {
        type = basecolors;
        default = "base05";
      };
      color14 = mkOption {
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
    home.file.".cache/wal/colors".text = ''
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color0}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color1}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color2}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color3}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color4}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color5}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color6}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color7}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color8}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color9}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color10}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color11}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color12}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color13}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color14}
      ${mapColorHex cfg.colorsOverride cfg.colorMap.color15}
    '';

    home.file.".cache/wal/colors.json".text = ''
      {
        "alpha": "${builtins.toString cfg.opacity}",

        "special": {
            "background": "${mapColorHex cfg.colorsOverride cfg.colorMap.background}",
            "foreground": "${mapColorHex cfg.colorsOverride cfg.colorMap.foreground}",
            "cursor": "${mapColorHex cfg.colorsOverride cfg.colorMap.color12}"
        },
        "colors": {
            "color0": "${mapColorHex cfg.colorsOverride cfg.colorMap.color0}",
            "color1": "${mapColorHex cfg.colorsOverride cfg.colorMap.color1}",
            "color2": "${mapColorHex cfg.colorsOverride cfg.colorMap.color2}",
            "color3": "${mapColorHex cfg.colorsOverride cfg.colorMap.color3}",
            "color4": "${mapColorHex cfg.colorsOverride cfg.colorMap.color4}",
            "color5": "${mapColorHex cfg.colorsOverride cfg.colorMap.color5}",
            "color6": "${mapColorHex cfg.colorsOverride cfg.colorMap.color6}",
            "color7": "${mapColorHex cfg.colorsOverride cfg.colorMap.color7}",
            "color8": "${mapColorHex cfg.colorsOverride cfg.colorMap.color8}",
            "color9": "${mapColorHex cfg.colorsOverride cfg.colorMap.color9}",
            "color10": "${mapColorHex cfg.colorsOverride cfg.colorMap.color10}",
            "color11": "${mapColorHex cfg.colorsOverride cfg.colorMap.color11}",
            "color12": "${mapColorHex cfg.colorsOverride cfg.colorMap.color12}",
            "color13": "${mapColorHex cfg.colorsOverride cfg.colorMap.color13}",
            "color14": "${mapColorHex cfg.colorsOverride cfg.colorMap.color14}",
            "color15": "${mapColorHex cfg.colorsOverride cfg.colorMap.color15}"
        }
    }
    '';
  };
}