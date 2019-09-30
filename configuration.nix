# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, lib, options, ... }:

let

  hostIdSet = {
    hostId = builtins.readFile "${etcDir}/hostId";
  };

  with hostIdSet; confDirSet = {

#### All kind of paths

  etcDir = "/etc";
  nixOsDir = "${etcDir}/nixos";
  serviceDir = "${nixOsDir}/service";
  hostDir = "${nixOsDir}/host";
  curHostDir = "${hostDir}/${hostId}";
  };

in

{

#### Importing host configuration

  with ConfDirSet; imports = [ "${curHostDir}/configuration.nix" ];

}
