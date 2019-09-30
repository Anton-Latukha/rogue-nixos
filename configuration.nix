# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, lib, options, ... }:

let

#### All kind of paths
  etcDir = builtins.readFile ./etcDir;
  nixOsDir = "${etcDir}/nixos";
  serviceDir = "${nixOsDir}/service";
  hostDir = "${nixOsDir}/host";
  hostId = builtins.readFile "${etcDir}/hostId";
  curHostDir = "${hostDir}/${hostId}";

in
{

#### Importing host configuration

  imports = [ "${curHostDir}/configuration.nix" ];

}
