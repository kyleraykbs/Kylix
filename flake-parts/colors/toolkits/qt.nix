toplevel: { config, lib, pkgs, ... }:
let
  inherit (toplevel.config.flake.lib)
    verifyHexColor
    mapColorHex
    hexToRGB
    hexToRGBWithSep
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
  
  cfg = config.kyler.toolkits.qt;
in {
  options.kyler.toolkits.qt = {
    enable = mkEnableOption "QT theming.";

    colorsOverride = mkOption {
      type = buildColorsOverrideType config.kyler.colors;
      default = {};
    };

    opacity = mkOption {
      type = types.int;
      default = config.kyler.opacity;
    };

    colorMap = {
      # TODO: make colormap an actual colormap because I jused used the list of colors to save time
    };
  };

  config = mkIf cfg.enable {
    # I have to impliment this later.
  };
}