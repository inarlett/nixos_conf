{
  polkit_gnome,
  stdenv,
}:
stdenv.mkDerivation rec {
  buildInputs = [
    polkit_gnome
  ];
  dontUnpack = true; # without providing src
  installPhase = ''
    mkdir -p $out/bin
    ln -s ${polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 $out/bin/polkit-gnome-agent
  '';
  name = "polkit-gnome-agent";
}
