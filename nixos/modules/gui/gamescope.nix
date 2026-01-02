{
  inputs,
  pkgs,
  ...
}:
{
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
  
}
