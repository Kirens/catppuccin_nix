{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.foot;
in

{
  options.catppuccin.foot = catppuccinLib.mkCatppuccinOption { name = "foot"; };

  config = lib.mkIf cfg.enable {
    programs.foot = {
      settings = {
        main.include =
          if cfg.flavor == "latte"
          then sources.foot + "/static/catppuccin-latte.ini"
          else sources.foot + "/catppuccin-${cfg.flavor}.ini";
      };
    };
  };
}
