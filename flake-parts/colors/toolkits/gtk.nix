toplevel: { config, lib, pkgs, ... }:
let
  inherit (toplevel.config.flake.lib)
    verifyHexColor
    mapColorHex
    hexToRGB
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
  
  cfg = config.kyler.toolkits.gtk;
in
{
  options.kyler.toolkits.gtk = {
    enable = mkEnableOption "GTK theming.";

    colorsOverride = mkOption {
      type = buildColorsOverrideType config.kyler.colors;
      default = {};
    };

    opacity = mkOption {
      type = types.int;
      default = config.kyler.opacity;
    };

    colorMap = {
      accent_color = mkOption {
        type = basecolors;
        default = "base0A";
      };
      accent_bg_color = mkOption {
        type = basecolors;
        default = "base0A";
      };
      accent_fg_color = mkOption {
        type = basecolors;
        default = "base00";
      };
      destructive_color = mkOption {
        type = basecolors;
        default = "base08";
      };
      destructive_bg_color = mkOption {
        type = basecolors;
        default = "base08";
      };
      destructive_fg_color = mkOption {
        type = basecolors;
        default = "base00";
      };
      success_color = mkOption {
        type = basecolors;
        default = "base0B";
      };
      success_bg_color = mkOption {
        type = basecolors;
        default = "base0B";
      };
      success_fg_color = mkOption {
        type = basecolors;
        default = "base00";
      };
      warning_color = mkOption {
        type = basecolors;
        default = "base0E";
      };
      warning_bg_color = mkOption {
        type = basecolors;
        default = "base0E";
      };
      warning_fg_color = mkOption {
        type = basecolors;
        default = "base00";
      };
      error_color = mkOption {
        type = basecolors;
        default = "base08";
      };
      error_bg_color = mkOption {
        type = basecolors;
        default = "base08";
      };
      error_fg_color = mkOption {
        type = basecolors;
        default = "base00";
      };
      window_bg_color = mkOption {
        type = basecolors;
        default = "base00";
      };
      window_fg_color = mkOption {
        type = basecolors;
        default = "base05";
      };
      view_bg_color = mkOption {
        type = basecolors;
        default = "base00";
      };
      view_fg_color = mkOption {
        type = basecolors;
        default = "base05";
      };
      headerbar_bg_color = mkOption {
        type = basecolors;
        default = "base01";
      };
      headerbar_fg_color = mkOption {
        type = basecolors;
        default = "base05";
      };
      sidebar_bg_color = mkOption {
        type = basecolors;
        default = "base01";
      };
      sidebar_fg_color = mkOption {
        type = basecolors;
        default = "base05";
      };
      card_bg_color = mkOption {
        type = basecolors;
        default = "base01";
      };
      card_fg_color = mkOption {
        type = basecolors;
        default = "base05";
      };
      dialog_bg_color = mkOption {
        type = basecolors;
        default = "base01";
      };
      dialog_fg_color = mkOption {
        type = basecolors;
        default = "base05";
      };
      popover_bg_color = mkOption {
        type = basecolors;
        default = "base01";
      };
      popover_fg_color = mkOption {
        type = basecolors;
        default = "base01";
      };
      scrollbar_outline_color = mkOption {
        type = basecolors;
        default = "base02";
      };

      blue = mkOption {
        type = basecolors;
        default = "base0D";
      };
      green = mkOption {
        type = basecolors;
        default = "base0B";
      };
      yellow = mkOption {
        type = basecolors;
        default = "base0A";
      };
      orange = mkOption {
        type = basecolors;
        default = "base09";
      };
      red = mkOption {
        type = basecolors;
        default = "base08";
      };
      purple = mkOption {
        type = basecolors;
        default = "base0E";
      };
      brown = mkOption {
        type = basecolors;
        default = "base0F";
      };
      light = mkOption {
        type = basecolors;
        default = "base01";
      };
      dark = mkOption {
        type = basecolors;
        default = "base01";
      };
      headerbar_border_color = mkOption {
        type = basecolors;
        default = "base01";
      };
    };
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3";
      };
    };

    xdg.configFile = let
      finalCss = ''
        @define-color accent_color ${mapColorHex cfg.colorsOverride cfg.colorMap.accent_color};
        @define-color accent_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.accent_bg_color};
        @define-color accent_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.accent_fg_color};
        @define-color destructive_color ${mapColorHex cfg.colorsOverride cfg.colorMap.destructive_color};
        @define-color destructive_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.destructive_bg_color};
        @define-color destructive_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.destructive_fg_color};
        @define-color success_color ${mapColorHex cfg.colorsOverride cfg.colorMap.success_color};
        @define-color success_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.success_bg_color};
        @define-color success_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.success_fg_color};
        @define-color warning_color ${mapColorHex cfg.colorsOverride cfg.colorMap.warning_color};
        @define-color warning_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.warning_bg_color};
        @define-color warning_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.warning_fg_color};
        @define-color error_color ${mapColorHex cfg.colorsOverride cfg.colorMap.error_color};
        @define-color error_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.error_bg_color};
        @define-color error_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.error_fg_color};
        @define-color window_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.window_bg_color};
        @define-color window_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.window_fg_color};
        @define-color view_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.view_bg_color};
        @define-color view_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.view_fg_color};
        @define-color headerbar_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.headerbar_bg_color};
        @define-color headerbar_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.headerbar_fg_color};
        @define-color headerbar_border_color rgba(${(hexToRGB (mapColorHex cfg.colorsOverride cfg.colorMap.headerbar_border_color)).r}, ${(hexToRGB (mapColorHex cfg.colorsOverride cfg.colorMap.headerbar_border_color)).g}, ${(hexToRGB (mapColorHex cfg.colorsOverride cfg.colorMap.headerbar_border_color)).b}, 0.7);
        @define-color headerbar_backdrop_color @window_bg_color;
        @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
        @define-color headerbar_darker_shade_color rgba(0, 0, 0, 0.07);
        @define-color sidebar_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.sidebar_bg_color};
        @define-color sidebar_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.sidebar_fg_color};
        @define-color sidebar_backdrop_color @window_bg_color;
        @define-color sidebar_shade_color rgba(0, 0, 0, 0.07);
        @define-color secondary_sidebar_bg_color @sidebar_bg_color;
        @define-color secondary_sidebar_fg_color @sidebar_fg_color;
        @define-color secondary_sidebar_backdrop_color @sidebar_backdrop_color;
        @define-color secondary_sidebar_shade_color @sidebar_shade_color;
        @define-color card_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.card_bg_color};
        @define-color card_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.card_fg_color};
        @define-color card_shade_color rgba(0, 0, 0, 0.07);
        @define-color dialog_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.dialog_bg_color};
        @define-color dialog_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.dialog_fg_color};
        @define-color popover_bg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.popover_bg_color};
        @define-color popover_fg_color ${mapColorHex cfg.colorsOverride cfg.colorMap.popover_fg_color};
        @define-color popover_shade_color rgba(0, 0, 0, 0.07);
        @define-color shade_color rgba(0, 0, 0, 0.07);
        @define-color scrollbar_outline_color ${mapColorHex cfg.colorsOverride cfg.colorMap.scrollbar_outline_color};
        @define-color blue_1 ${mapColorHex cfg.colorsOverride cfg.colorMap.blue};
        @define-color blue_2 ${mapColorHex cfg.colorsOverride cfg.colorMap.blue};
        @define-color blue_3 ${mapColorHex cfg.colorsOverride cfg.colorMap.blue};
        @define-color blue_4 ${mapColorHex cfg.colorsOverride cfg.colorMap.blue};
        @define-color blue_5 ${mapColorHex cfg.colorsOverride cfg.colorMap.blue};
        @define-color green_1 ${mapColorHex cfg.colorsOverride cfg.colorMap.green};
        @define-color green_2 ${mapColorHex cfg.colorsOverride cfg.colorMap.green};
        @define-color green_3 ${mapColorHex cfg.colorsOverride cfg.colorMap.green};
        @define-color green_4 ${mapColorHex cfg.colorsOverride cfg.colorMap.green};
        @define-color green_5 ${mapColorHex cfg.colorsOverride cfg.colorMap.green};
        @define-color yellow_1 ${mapColorHex cfg.colorsOverride cfg.colorMap.yellow};
        @define-color yellow_2 ${mapColorHex cfg.colorsOverride cfg.colorMap.yellow};
        @define-color yellow_3 ${mapColorHex cfg.colorsOverride cfg.colorMap.yellow};
        @define-color yellow_4 ${mapColorHex cfg.colorsOverride cfg.colorMap.yellow};
        @define-color yellow_5 ${mapColorHex cfg.colorsOverride cfg.colorMap.yellow};
        @define-color orange_1 ${mapColorHex cfg.colorsOverride cfg.colorMap.orange};
        @define-color orange_2 ${mapColorHex cfg.colorsOverride cfg.colorMap.orange};
        @define-color orange_3 ${mapColorHex cfg.colorsOverride cfg.colorMap.orange};
        @define-color orange_4 ${mapColorHex cfg.colorsOverride cfg.colorMap.orange};
        @define-color orange_5 ${mapColorHex cfg.colorsOverride cfg.colorMap.orange};
        @define-color red_1 ${mapColorHex cfg.colorsOverride cfg.colorMap.red};
        @define-color red_2 ${mapColorHex cfg.colorsOverride cfg.colorMap.red};
        @define-color red_3 ${mapColorHex cfg.colorsOverride cfg.colorMap.red};
        @define-color red_4 ${mapColorHex cfg.colorsOverride cfg.colorMap.red};
        @define-color red_5 ${mapColorHex cfg.colorsOverride cfg.colorMap.red};
        @define-color purple_1 ${mapColorHex cfg.colorsOverride cfg.colorMap.purple};
        @define-color purple_2 ${mapColorHex cfg.colorsOverride cfg.colorMap.purple};
        @define-color purple_3 ${mapColorHex cfg.colorsOverride cfg.colorMap.purple};
        @define-color purple_4 ${mapColorHex cfg.colorsOverride cfg.colorMap.purple};
        @define-color purple_5 ${mapColorHex cfg.colorsOverride cfg.colorMap.purple};
        @define-color brown_1 ${mapColorHex cfg.colorsOverride cfg.colorMap.brown};
        @define-color brown_2 ${mapColorHex cfg.colorsOverride cfg.colorMap.brown};
        @define-color brown_3 ${mapColorHex cfg.colorsOverride cfg.colorMap.brown};
        @define-color brown_4 ${mapColorHex cfg.colorsOverride cfg.colorMap.brown};
        @define-color brown_5 ${mapColorHex cfg.colorsOverride cfg.colorMap.brown};
        @define-color light_1 ${mapColorHex cfg.colorsOverride cfg.colorMap.light};
        @define-color light_2 ${mapColorHex cfg.colorsOverride cfg.colorMap.light};
        @define-color light_3 ${mapColorHex cfg.colorsOverride cfg.colorMap.light};
        @define-color light_4 ${mapColorHex cfg.colorsOverride cfg.colorMap.light};
        @define-color light_5 ${mapColorHex cfg.colorsOverride cfg.colorMap.light};
        @define-color dark_1 ${mapColorHex cfg.colorsOverride cfg.colorMap.dark};
        @define-color dark_2 ${mapColorHex cfg.colorsOverride cfg.colorMap.dark};
        @define-color dark_3 ${mapColorHex cfg.colorsOverride cfg.colorMap.dark};
        @define-color dark_4 ${mapColorHex cfg.colorsOverride cfg.colorMap.dark};
        @define-color dark_5 ${mapColorHex cfg.colorsOverride cfg.colorMap.dark};
      '';
    in {
      "gtk-3.0/gtk.css".text = finalCss;
      "gtk-4.0/gtk.css".text = finalCss;
    };
  };
}