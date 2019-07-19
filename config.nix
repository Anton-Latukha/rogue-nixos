{ config, pkgs, ... }:
{
  packageOverrides = pkgs: {
    wine = pkgs.wine.override { gstreamerSupport = false; };
  };
}
