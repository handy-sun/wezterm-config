# Convert WezTerm Config to Home Manager

## Goal

Use Home Manager for the parts that are naturally declarative, and keep the
existing Lua module system for the runtime-heavy WezTerm behavior.

Home Manager should own:

- `programs.wezterm.enable`
- `programs.wezterm.colorSchemes.qimocha`
- font settings in `programs.wezterm.settings`

Lua should still own:

- appearance options other than the color scheme
- general behavior options
- launch menu and domains
- key bindings and key tables
- mouse bindings
- event handlers
- backdrop switching
- platform-sensitive runtime logic

## Why This Split

The current Lua config already has useful module boundaries:

- `config/appearance.lua`
- `config/bindings.lua`
- `config/general.lua`
- `config/launch.lua`
- `config/domains.lua`
- `events/*.lua`
- `utils/*.lua`

Rewriting all of that as Nix `settings` makes the HM file large and brittle.
It also forces dynamic Lua concepts like `wezterm.action_callback`,
`wezterm.GLOBAL`, event handlers, and platform checks through Nix string
serialization.

The better boundary is:

- Nix declares stable data: theme and fonts.
- Lua keeps executable behavior.

## Important Home Manager Detail

`programs.wezterm.extraConfig` should be treated as code appended into the
Home Manager generated `wezterm.lua`.

That means `extra.lua` should not behave exactly like the original
top-level `wezterm.lua` by returning a fresh table. In the HM context, it should
modify the existing `config` table that Home Manager generated.

Bad shape:

```lua
return opt.options
```

Good shape:

```lua
for k, v in pairs(opt.options) do
    config[k] = v
end
```

This is likely the main reason the previous converted config could make WezTerm
fail at startup: there were two competing config construction paths.

## Target Shape

### `nix/wezterm.nix`

Keep this file small:

```nix
{
  inputs,
  lib,
  pkgs,
  ...
}:

let
  wezConfDir = inputs.my-wezterm;
  qimocha =
    (builtins.fromTOML (builtins.readFile (wezConfDir + "/colors/qimocha.toml"))).colors;
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
```

### `extra.lua`

Use this file as the Home Manager entrypoint equivalent of `wezterm.lua`.
It should load the normal Lua modules and merge their options into HM's
generated `config` table:

```lua
local Config = require("config")
require("utils.backdrops"):set_files():random()

require("events.right-status").setup()
require("events.left-status").setup()
require("events.tab-title").setup()
require("events.new-tab-button").setup()

local opt = Config:init()
    :append(require("config.appearance"))
    :append(require("config.bindings"))
    :append(require("config.general"))
    :append(require("config.launch"))
    :append(require("config.domains"))

for k, v in pairs(opt.options) do
    config[k] = v
end
```

Do not append `config.fonts`, because Home Manager owns fonts.

`extra.lua` lives at the repository root. The Home Manager module should read
it through the flake input, for example:

```nix
let
  wezConfDir = inputs.my-wezterm;
in
{
  programs.wezterm.extraConfig = builtins.readFile (wezConfDir + "/extra.lua");
}
```

## Lua Files to Remove or Change

Remove:

- `config/fonts.lua`

Keep:

- `colors/qimocha.toml`

Change:

- `wezterm.lua` should stop loading `config.fonts` if the project is moving
  fully to HM-managed fonts.
- `config/appearance.lua` should not define `color_scheme` if HM is the only
  source of theme selection.

If non-HM standalone Lua usage should continue to work, keep `wezterm.lua`
standalone-compatible and only omit `config.fonts` from `extra.lua`.
That is a separate compatibility decision.

## Collision Points to Avoid

Do not define the same option from both Nix `settings` and Lua `extra.lua`
unless the override is intentional.

High-risk duplicates:

- `font`
- `font_size`
- `freetype_load_target`
- `freetype_render_target`
- `color_scheme`
- `colorSchemes`

Acceptable in Lua:

- `background`
- `window_frame`
- key bindings
- event handlers
- launch menu
- domains

## Migration Steps

1. Trim `nix/wezterm.nix` to theme and font settings only.
2. Replace the current monolithic `extra.lua` with a small loader adapted
   from `wezterm.lua`.
3. Remove `config.fonts` from the HM loader path.
4. Remove `config/fonts.lua` if standalone Lua config no longer needs it.
5. Decide whether `config/appearance.lua` keeps `color_scheme = "qimocha"` for
   standalone use or whether HM fully owns the theme.
6. Validate with Home Manager build/switch.
7. Validate WezTerm can start and `wezterm show-keys` can load the generated
   config.

## Verification

Useful checks:

```sh
nix eval .#homeConfigurations.<name>.config.programs.wezterm.settings
home-manager build
home-manager switch
wezterm show-keys
```

If testing the generated file directly, inspect the final
`$XDG_CONFIG_HOME/wezterm/wezterm.lua` and confirm there is only one config
table construction path.
