{
  lib,
  pkgs,
  ...
}:
{
  xdg.configFile."nvim/lua/lazy-path.lua".text =
    let
      plugins = with pkgs.vimPlugins; [
        blink-cmp
      ];
      mkEntryFromDrv =
        drv:
        if lib.isDerivation drv then
          {
            name = "${lib.getName drv}";
            path = drv;
          }
        else
          drv;
      lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
    in
    ''
      return "${lazyPath}"
    '';
}
