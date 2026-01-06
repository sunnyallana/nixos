{
  config,
  ...
}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings =
      let
        mod = "SUPER";
      in
      {
        exec-once = [
          "systemctl --user start hyprpolkitagent"
          "dunst"
          "elephant"
          "walker --gapplication-service"
          "waybar"
          "ghostty"
        ];

        general = {
          gaps_in = 4;
          gaps_out = 8;

          border_size = 2;
          "col.active_border" = "$mauve";
          "col.inactive_border" = "$overlay0";

          allow_tearing = true;
        };

        decoration = {
          rounding = 5;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
        };

        animations = {
          enabled = true;

          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOut,0.68,0,0.32,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 3, easeInOut, slidefade"
          ];
        };

        dwindle.preserve_split = true;

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        input.accel_profile = "flat";

        bindr = [ "${mod}, ${mod}_L, exec, walker" ];
        bindm = [
          "${mod}, mouse:272, movewindow"
          "${mod} SHIFT, mouse:272, resizewindow"
        ];
        bind = [
          "${mod}, 1, workspace, 1"
          "${mod}, 2, workspace, 2"
          "${mod}, 3, workspace, 3"
          "${mod}, 4, workspace, 4"
          "${mod}, 5, workspace, 5"
          "${mod}, 6, workspace, 6"
          "${mod}, 7, workspace, 7"
          "${mod}, 8, workspace, 8"
          "${mod}, 9, workspace, 9"
          "${mod}, 0, workspace, 10"
          "${mod}, L, exec, uwsm stop"
          "${mod}, F, togglefloating"
          "${mod}, W, killactive"
          "${mod}, S, exec, hyprshot-gui"

          "${mod} SHIFT, 1, movetoworkspace, 1"
          "${mod} SHIFT, 2, movetoworkspace, 2"
          "${mod} SHIFT, 3, movetoworkspace, 3"
          "${mod} SHIFT, 4, movetoworkspace, 4"
          "${mod} SHIFT, 5, movetoworkspace, 5"
          "${mod} SHIFT, 6, movetoworkspace, 6"
          "${mod} SHIFT, 7, movetoworkspace, 7"
          "${mod} SHIFT, 8, movetoworkspace, 8"
          "${mod} SHIFT, 9, movetoworkspace, 9"
          "${mod} SHIFT, 0, movetoworkspace, 10"

          "${mod} Alt, 1, movetoworkspacesilent, 1"
          "${mod} Alt, 2, movetoworkspacesilent, 2"
          "${mod} Alt, 3, movetoworkspacesilent, 3"
          "${mod} Alt, 4, movetoworkspacesilent, 4"
          "${mod} Alt, 5, movetoworkspacesilent, 5"
          "${mod} Alt, 6, movetoworkspacesilent, 6"
          "${mod} Alt, 7, movetoworkspacesilent, 7"
          "${mod} Alt, 8, movetoworkspacesilent, 8"
          "${mod} Alt, 9, movetoworkspacesilent, 9"
          "${mod} Alt, 0, movetoworkspacesilent, 10"
        ];

        windowrule = [
          "suppress_event maximize, match:class .*"
          "no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0" # Fix dragging issues when used with XWayland
          "float on, size 960 640, center on, match:initial_title Hyprshot"
        ];
      };
  };

  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
