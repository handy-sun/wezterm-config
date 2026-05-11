# WezTerm Home Manager configuration.
#
# Home Manager owns the stable declarative pieces: theme and font settings.
# Runtime behavior stays in Lua modules loaded from extra.lua.
{
  inputs,
  lib,
  pkgs,
  ...
}:

let
  wezConfDir = inputs.my-wezterm;
  qimocha = (builtins.fromTOML (builtins.readFile (wezConfDir + "/colors/qimocha.toml"))).colors;
in
{
  xdg.configFile = {
    "wezterm/config".source = wezConfDir + "/config";
    "wezterm/events".source = wezConfDir + "/events";
    "wezterm/utils".source = wezConfDir + "/utils";
    "wezterm/backdrops".source = wezConfDir + "/backdrops";
    "wezterm/custom.lua".source = wezConfDir + "/custom.lua";
  };

  programs.wezterm = {
    enable = true;

    colorSchemes = { inherit qimocha; };

    settings = {
      color_scheme = "qimocha";

      font_size = if pkgs.stdenv.isDarwin then 16.0 else 12.0;
      font = lib.generators.mkLuaInline ''
        wezterm.font_with_fallback({
          "NotoMono NFM",
          "FiraCode Nerd Font Mono",
          "JetBrains Mono",
          "DejaVu Sans Mono",
          "Droid Sans Mono",
          "Consolas",
        })
      '';

      freetype_load_target = "Normal";
      freetype_render_target = "Normal";
    };

    extraConfig = builtins.readFile (wezConfDir + "/extra.lua");
  };
}
