# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
final: prev: {
  volume = final.callPackage ./volume { };
  #davinci-resolv = final.callPackage ./davinci { };
}
