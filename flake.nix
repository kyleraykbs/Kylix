{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; }
      (toplevel@ {config, flake-parts-lib, lib, ...}:
      let
        inherit (flake-parts-lib) importApply;

        flakeModules = {
          functions = importApply ./flake-parts/libraries/functions.nix toplevel;
          system = importApply ./flake-parts/themes/system toplevel;
          types = importApply ./flake-parts/libraries/types.nix toplevel;
          applications = importApply ./flake-parts/themes/applications toplevel;
          toolkits = importApply ./flake-parts/themes/toolkits toplevel;
        };
      in {
        options.flake.homeManagerModules = lib.mkOption {
          type = lib.types.attrs;
          default = { };
        };

        options.flake.lib = lib.mkOption {
          type = lib.types.attrs;
          default = { };
        };

        imports = with flakeModules; [
          functions
          types
          applications
          system
          toolkits
        ];

        config = {
          flake = {
            inherit flakeModules;
            homeManagerModules = {
              themes = importApply ./flake-parts/themes toplevel;
              default.imports = config.flake.lib.combineModules config.flake.homeManagerModules;
            };
          };
        };
      });
}
