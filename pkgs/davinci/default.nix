# DaVinci is a FHS wrapper in NixOS, so both the wrapper and binary need changes
{ pkgs,xkeyboard_config }:
pkgs.davinci-resolve-studio.override (old: {
  davinciResolveStudioZip = "/home/inf/Downloads/davinci-resolve-studio-src.zip";
})
