{
  config,
  inputs,
  pkgs,
  ...
}:

let
  modules_path_base = "${config.home.homeDirectory}/.nixos/users/modules";
  gui_path_base = "${modules_path_base}/gui";
  hyprland_path = "${gui_path_base}/hypr";
  waybar_path = "${gui_path_base}/waybar";
  wpaperd_path = "${gui_path_base}/wpaperd";
in
{
  home = {
    file = {
      ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink waybar_path;
      ".config/wpaperd".source = config.lib.file.mkOutOfStoreSymlink wpaperd_path;
    };
    packages = [
      #inputs.hy3.packages.x86_64-linux.hy3
    ];
    sessionVariables = {
      ANKI_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
    };
  };
  programs = {
    hyprlock = {
      enable = true;
    };
    wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "hyprlock";
          text = "Lock";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
        }
        {
          label = "logout";
          action = "hyprctl dispatch exit";
          text = "Logout";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
        }
        {
          label = "suspend";
          action = "systemctl suspend && hyprlock";
          text = "Sleep";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
        }
      ];
      settings={
        # BACKGROUND
background = {
    #path = screenshot;
    path = /home/inf/Pictures/Wallpapers/wp4574930-ftl-faster-than-light-wallpapers.jpg;
    #color = $background;
    blur_passes = 2;
    contrast = 1;
    brightness = 0.5;
    vibrancy = 0.2;
    vibrancy_darkness = 0.2;
};

# GENERAL
general = {
    no_fade_in = true;
    no_fade_out = true;
    hide_cursor = false;
    grace = 0;
    disable_loading_bar = true;
};

# INPUT FIELD
input-field = {
    size = [ 250 60 ];
    outline_thickness = 2;
    dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8;
    dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0;
    dots_center = true;
    outer_color = rgba(0, 0, 0, 0);
    inner_color = rgba(0, 0, 0, 0.2);
    font_color = $foreground;
    fade_on_empty = false;
    rounding = -1;
    check_color = rgb(204, 136, 34);
    placeholder_text = <i><span foreground="##cdd6f4">Input Password...</span></i>;
    hide_input = false;
    position = 0, -200;
    halign = center;
    valign = center;
};

# DATE
label = {
  text = cmd[update:1000] echo "$(date +"%A, %B %d")";
  color = rgba(242, 243, 244, 0.75);
  font_size = 22;
  font_family = JetBrains Mono;
  position = 0, 300;
  halign = center;
  valign = center;
};

# TIME
label = {
  text = cmd[update:1000] echo "$(date +"%-I:%M")";
  color = rgba(242, 243, 244, 0.75);
  font_size = 95;
  font_family = JetBrains Mono Extrabold;
  position = 0, 200;
  halign = center;
  valign = center;
};



# Profile Picture
image = {
    path = /home/inf/Pictures/IMG_0688_739.JPG;
    size = 100;
    border_size = 2;
    border_color = $foreground;
    position = 0, -100;
    halign = center;
    valign = center;
};
      };
    };
  };
  services = {
    hypridle = {
      enable = true;
    };
  };
  wayland.windowManager.hyprland = {
    settings = {
      "$scale" = "2";
      monitor = ", highres, auto, $scale";
      "$mod" = "SUPER";

      general = {
        resize_on_border = true;
      };
      misc = {
        force_default_wallpaper = 0;
      };

      env = [
        "QT_QPA_PLATFORM,wayland;xcb"
        "GTK_IM_MODULE,fcitx"
        "QT_IM_MODULE,fcitx"
        "XMODIFIERS,@im=fcitx"
        "INPUT_METHOD,fcitx"
        "SDL_IM_MODULE,fcitx"
      ];

      exec-once = [
        "hypridle"
        "waybar"
        "dunst"
        "fcitx5 -r"
        "polkit-gnome-agent"
        "systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland"
        "gammastep"
        "killall -9 clash-meta;sudo clash-meta -d ~/.config/mihomo/"
        "wpaperd"
        "goldendict"
        "clipse -listen"
      ];

      windowrulev2 = [
        "float,size 800 600, class:(GoldenDict-ng)"
        "float, class:^(one\\.alynx\\.showmethekey)$"
        "pin, class:^(one\\.alynx\\.showmethekey)$"
      ];
      windowrule = [
        "float, class:(clipse)"
        "size 622 652, class:(clipse)"
        "stayfocused, class:(clipse)"
      ];

      # ==========================
      # All binds (merged)
      # ==========================
      bind = [
        # Application
        "$mod, RETURN, exec, kitty"
        "$mod, D, exec, wofi --show drun --allow-images"
        "$mod, T, exec, goldendict $(wl-paste)"
        "CONTROL, semicolon, exec, kitty --class clipse -e clipse"

        # Window control
        "$mod SHIFT, Q, killactive"
        "ALT, F4, killactive"
        "$mod, F, fullscreen"
        "CTRL ALT, Delete, exec, hyprctl dispatch exit 0"

        # Movement
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, Space, togglefloating"

        # Layout control
        "$mod, G, togglesplit"
        "$mod, W, layoutmsg, orientationtop"
        "$mod, E, layoutmsg, orientationcenter"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Media
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"

        # Advanced
        "$mod, R, exec, hyprctl reload"
        "$mod SHIFT, E, exec, wlogout"
        ",XF86Sleep, exec, hyprlock"

        # Submap triggers
        "$mod, R, submap, $resize"
        "$mod, M, submap, $mouse"
        "$mod, S, submap, $screenshot"
      ];

      binde = [
        # resize submap movement
        ", h, resizeactive, -40 0"
        ", l, resizeactive, 40 0"
        ", k, resizeactive, 0 40"
        ", j, resizeactive, 0 -40"

        # mouse submap movement
        ", h, exec, ydotool mousemove -- -10 0"
        ", j, exec, ydotool mousemove -- 0 10"
        ", k, exec, ydotool mousemove -- 0 -10"
        ", l, exec, ydotool mousemove -- 10 0"
        "SHIFT, h, exec, ydotool mousemove -- -50 0"
        "SHIFT, j, exec, ydotool mousemove -- 0 50"
        "SHIFT, k, exec, ydotool mousemove -- 0 -50"
        "SHIFT, l, exec, ydotool mousemove -- 50 0"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      submap = {
        "$resize" = [
          ", escape, submap, reset"
          ", return, submap, reset"
        ];
        "$mouse" = [
          ",f, exec,hyprctl dispatch submap reset && wl-kbptr -o modes=floating,click -o mode_floating.source=detect"
          ",t, exec,hyprctl dispatch submap reset && wl-kbptr -o modes=tile,bisect"
          ",z, exec, ydotool click 0xC0"
          ",x, exec, ydotool click 0xC1"
          ",c, exec, ydotool click 0xC2"
          ", escape, submap, reset"
          ", return, submap, reset"
        ];
        "$screenshot" = [
          ",s, exec,hyprctl dispatch submap reset && ~/Documents/scripts/window/wayland/screenshot.sh"
          ",q, exec,hyprctl dispatch submap reset && ~/Documents/scripts/window/wayland/scan.sh"
          ",l, exec,hyprctl dispatch submap reset && ~/Documents/scripts/window/wayland/latex.sh"
          ", escape, submap, reset"
          ", return, submap, reset"
        ];
      };

      animations.enabled = false;
      debug.disable_logs = false;

      decoration = {
        rounding = 0;
        blur.enabled = false;
        shadow.enabled = false;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad.natural_scroll = "yes";
      };
    };
    enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprscrolling
    ];
  };
}
