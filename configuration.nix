# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, lib, options, ... }:

let

  etcDir = "/etc";
  nixOsDir = "${etcDir}/nixos";
  serviceDir = "${nixOsDir}/service";
  hostDir = "${nixOsDir}/host";
  hostId = builtins.readFile "${etcDir}/hostId";
  curHostDir = "${hostDir}/${hostId}";

in

{


#### All kind of paths



#### Importing host configuration

  imports = [ "${curHostDir}/configuration.nix" ];

}
