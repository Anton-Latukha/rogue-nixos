{ config, pkgs, ... }:
let

  config = config.nixpkgs.config;

in {
  packageOverrides = pkgs: {
    wine = pkgs.wine.override { gstreamerSupport = false; };
  };
}
