{ pkgs, lib }:
let
  modifier = "Mod4";
  swaysome = builtins.readFile(./. + "/swaysome.conf");
  helpers = import ../../helpers.nix {
    inherit
      pkgs
      lib;
  };
in
{
  enable = true;
  package = (helpers.nixGLMesaWrap pkgs.sway);

  systemd = {
    enable = true;
  };

  wrapperFeatures = {
    gtk = true;
  };

  config = {
    modifier = modifier;
    bars = [
      {
        command = "waybar";
      }
    ];
    terminal = "wezterm";
    menu = "wofi --show drun | xargs swaymsg exec -- ";

    output = {
      "DP-2" = {
        scale = "1.5";
      };
    };

    startup = [
      { command = "wezterm"; }
      { command = "firefox"; }
      { command = "1password &"; }
    ];
  };

  extraConfig = builtins.concatStringsSep "\n" [
    "set $mod ${modifier}"
    "bindsym $mod+q exec swaylock"
    swaysome
  ];
}
