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
  pname = "sddm-theme";
  installPhase = ''
    cp -r ${pkgs.sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme ./theme
    sed -i 's#^ConfigFile=.*#ConfigFile=Themes/pixel_sakura.conf#' ./theme/metadata.desktop
    sed -i '/FontSize/d' ./theme/Themes/pixel_sakura.conf
    sed -i '/Hide.*true\|true.*Hide/s/true/false/g' ./theme/Themes/pixel_sakura.conf

    mkdir -p $out/share/sddm/themes/${pname}
    mv ./theme/* $out/share/sddm/themes/${pname}
  '';
}
