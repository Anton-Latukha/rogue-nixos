# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, options, ... }:{

  etc = "/etc"
  hostId = builtins.readFile "${etc}/hostId";
  nixOsPath = "${etc}/nixos"
  servicePath = "${nixOsPath}/service"

  import "./hosts/${hostId}/configuration.nix";

}
