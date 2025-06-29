# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
final: prev: {
  volume = final.callPackage ./volume { };
  rime-ice = final.callPackage ./rime-ice { };
  #davinci-resolv = final.callPackage ./davinci { };
  
}
