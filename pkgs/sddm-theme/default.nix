{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  buildInputs = [
    pkgs.sddm-astronaut
  ];
  dontUnpack = true; # without providing src
  nativeBuildInputs = [
    pkgs.qt6.wrapQtAppsHook # For graphical applications depending on Qt
  ];
  name = "sddm-theme";
  installPhase = ''
    mkdir -p $out/share/sddm/themes/${name}
    cp -r ${pkgs.sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme/* $out/share/sddm/themes/${name}/
    sed -i 's#^ConfigFile=.*#ConfigFile=Themes/pixel_sakura.conf#' $out/share/sddm/themes/${name}/metadata.desktop
  '';
}
