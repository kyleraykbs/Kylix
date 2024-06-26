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

    style = mkOption {
      type = types.str;
      default = "Fusion";
    };

    icons = {
      package = mkOption {
        type = types.package;
        default = pkgs.qogir-icon-theme;
      };

      themeName = mkOption {
        type = types.str;
        default = "Qogir";
      };
    };

    colorMap = {
      # TODO: make colorMap an actual colorMap because I justed used the list of colors to save time
      background = mkOption {
        type = basecolors;
        default = "base00";
      };
      
      foreground = mkOption {
        type = basecolors;
        default = "base07";
      };
      
      elementBackground = mkOption {
        type = basecolors;
        default = "base00";
      };

      lessBright = mkOption {
        type = basecolors;
        default = "base05";
      };

      dark = mkOption {
        type = basecolors;
        default = "base01";
      };
      
      lessDark = mkOption {
        type = basecolors;
        default = "base03";
      };

      shadow = mkOption {
        type = basecolors;
        default = "base02";
      };

      highlight = mkOption {
        type = basecolors;
        default = "base0A";
      };

      link = mkOption {
        type = basecolors;
        default = "base0A";
      };

      visitedLink = mkOption {
        type = basecolors;
        default = "base0E";
      };

      altBackground = mkOption {
        type = basecolors;
        default = "base01";
      };

      tooltipBackground = mkOption {
        type = basecolors;
        default = "base01";
      };

      windowDisabled = mkOption {
        type = basecolors;
        default = "base02";
      };

      shadowDisabled = mkOption {
        type = basecolors;
        default = "base01";
      };

      disabledHighlight = mkOption {
        type = basecolors;
        default = "base04";
      };
    };
  };

  config = let
    qtctconf = ''
      [Appearance]
      color_scheme_path=~/.config/qt6ct/colors/kyler.conf
      custom_palette=true
      icon_theme=${cfg.icons.themeName}
      standard_dialogs=default
      style=${cfg.style}

      [Fonts]
      fixed="Sans Serif,11,-1,5,50,0,0,0,0,0"
      general="Sans Serif,11,-1,5,50,0,0,0,0,0"

      [Interface]
      activate_item_on_single_click=1
      buttonbox_layout=0
      cursor_flash_time=1000
      dialog_buttons_have_icons=1
      double_click_interval=400
      gui_effects=@Invalid()
      keyboard_scheme=2
      menus_have_icons=true
      show_shortcuts_in_context_menus=true
      stylesheets=@Invalid()
      toolbutton_style=4
      underline_shortcut=1
      wheel_scroll_lines=3

      [Troubleshooting]
      force_raster_widgets=1
      ignored_applications=@Invalid()
    '';

    themefile = ''
      [ColorScheme]
      active_colors=#ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.elementBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.lessBright)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.dark)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.lessDark)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.elementBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.shadow)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.highlight)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.link)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.visitedLink)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.altBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.tooltipBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #80${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}
      disabled_colors=#ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.windowDisabled)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.elementBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.lessBright)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.windowDisabled)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.lessDark)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.windowDisabled)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.windowDisabled)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.elementBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.elementBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.shadowDisabled)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.disabledHighlight)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.link)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.visitedLink)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.altBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.tooltipBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #80${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}
      inactive_colors=#ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.elementBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.lessBright)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.dark)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.lessDark)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.elementBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.shadow)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.highlight)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.link)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.visitedLink)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.altBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.tooltipBackground)}, #ff${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.foreground)}, #80${builtins.replaceStrings ["#"] [""] (mapColorHex cfg.colorsOverride cfg.colorMap.background)}
    '';

  in mkIf cfg.enable {
    home.packages = with pkgs; [
      qt6ct
      qt5ct
    ] ++ [cfg.icons.package];

    home.sessionVariables = {
      QT_QPA_PLATFORMTHEME="qt5ct:qt6ct";
    };
    
    # Todo: Add interfact support
    # I have to impliment this now! WWWWW NVIM IS AWESOME!
    xdg.configFile."qt6ct/qt6ct.conf".text = qtctconf;
    xdg.configFile."qt5ct/qt5ct.conf".text = qtctconf;

    xdg.configFile."qt5ct/colors/kyler.conf".text = themefile;
    xdg.configFile."qt6ct/colors/kyler.conf".text = themefile;
  };
}
