# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, options, ... }:{

  id = {
    hostId = builtins.readFile "${etcDir}/hostId";
  }
#### All kind of paths
  with id; dirs = {

    etcDir = "/etc";
    nixOsDir = "${etcDir}/nixos";
    serviceDir = "${nixOsDir}/service";
    hostDir = "${nixOsDir}/host";
    curHostDir = "${hostDir}/${hostId}";

  };

#### Importing host configuration
  with dirs; imports = [ "${curHostDir}/configuration.nix" ];

}
