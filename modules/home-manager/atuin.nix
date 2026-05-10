{ catppuccinLib }:
{ config, lib, pkgs, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.atuin;
  enable = cfg.enable && config.programs.atuin.enable;
  themeName = "catppuccin-${cfg.flavor}-${cfg.accent}";
in

{
  options.catppuccin.atuin = catppuccinLib.mkCatppuccinOption {
    name = "atuin";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    programs.atuin = {
      settings.theme.name = themeName;
      themes.${themeName} = pkgs.runCommandLocal "${themeName}.toml" { } ''
        cp "${sources.atuin}/${cfg.flavor}/${themeName}.toml" "$out"
      '';
    };
  };
}
