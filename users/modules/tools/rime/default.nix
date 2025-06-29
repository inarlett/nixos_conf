{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  xdg={
    configFile={
	"fcitx/rime/default.custom.yaml".source = ./rime.yaml;
    };
    dataFile={
    	"fcitx5/rime/default.custom.yaml".source = ./rime.yaml;
    };

  };
}
