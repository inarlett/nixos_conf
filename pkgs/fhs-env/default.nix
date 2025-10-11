{pkgs, ...}:
let
  libs = with pkgs; [
    # Basic
    bash
    zsh
    alsa-lib
    autoconf
    binutils
    curl
    git
    gnumake
    stdenv.cc
    unzip
    util-linux
    wget
    vim
    neovim
    python312
    pkg-config
    SDL2
    gcc
    nodejs_22
    # Others - MSST
    # portaudio
    # pango
    # cairo
    # harfbuzz
    # fontconfig
    # freetype
    # gdk-pixbuf
    # atk
    # gobject-introspection
    xorg.libX11
    xorg.xorgproto
    xorg.libXext
    xorg.libXi
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXxf86vm
    xorg.libXtst
    xorg.xmessage
    libdrm
    libgbm
    libpulseaudio
    libxkbcommon
    # libepoxy
    wayland
    # gtk3
    # gtkmm3
    # gtk2
    # gtkmm2
    # glib
    glibc
    zlib
    # Others - MIDI -> AUDIO
    libvorbis
    libogg
    libopus
    # fluidsynth
  ];
  base = pkgs.appimageTools.defaultFhsEnvArgs;
  
in
with pkgs; buildFHSEnv {
  name = "MyFHS";
  targetPkgs = pkgs:
    (base.targetPkgs pkgs)
    ++
    libs;
  profile = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath libs}:$LD_LIBRARY_PATH"
  '';
  extraOutputsToInstall = ["dev"];
}
