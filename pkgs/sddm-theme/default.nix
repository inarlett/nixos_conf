{
  sddm-astronaut,
  stdenv,
}:
stdenv.mkDerivation rec {
  buildInputs = [
    sddm-astronaut
  ];
  installPhase = ''
    rm 
  '';
  name = "sddm-theme";
}
