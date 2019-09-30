# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, options, ... }:{

  host-id = builtins.readFile "/etc/host-id";

  import "./hosts/${host-id}/configuration.nix";

}
