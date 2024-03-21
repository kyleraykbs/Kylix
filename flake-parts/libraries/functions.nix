_: { config, lib, ... }:
let
  inherit (lib)
    mkOption
    types
    ;
in
{
  config.flake.lib = rec {
    hexToInt = hxstr: (builtins.fromTOML "a = 0x${hxstr}").a;
    hexToRGB = hxstr: let
      hxstrclean = builtins.replaceStrings ["#"] [""] hxstr;
      r = builtins.toString (hexToInt (builtins.substring 0 2 hxstrclean));
      g = builtins.toString (hexToInt (builtins.substring 2 2 hxstrclean));
      b = builtins.toString (hexToInt (builtins.substring 4 2 hxstrclean));
    in { r = r; g = g; b = b; };
    hexToRGBWithSep = hxstr: sep: "${(hexToRGB hxstr).r}  ${sep}  ${(hexToRGB hxstr).g}  ${sep} ${(hexToRGB hxstr).b}";
    combineModules = modules: builtins.attrValues (lib.filterAttrs (k: _: k != "default") modules);
    verifyHexColor = clr: (if lib.strings.hasInfix "#" clr then clr else "#${clr}");
    mapColorHex = colors: clr: verifyHexColor (lib.attrsets.attrByPath [clr] null colors);
  };
}