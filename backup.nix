{ pkgs, ... }:

let

  backupFolders = "/root /tmp";

in {


  #environment.systemPackages = with pkgs; [
  #  unstable.jdupes    # Deduplication utilitie
  #];


  systemd = {


    # Timer for file deduplication
      timers.deduplication = {

        description = "Git backup of commits in ${dedupFolders}";

        timerConfig = {
          # Time to wait after boot before trigger first time
          OnBootSec = "1min";
          # Time between consecutive triggering
          OnCalendar = "*-*-* 00/4:00:00"; # Every hours that delete on 4 (every 4 hours)
        };

        wantedBy = [ "timers.target" ];    # To be enabled, is hooked to the default timers traget

      };


    # This service should be run by the timer. Not by itself, not by NixOS.
    services.deduplication = {

      description = "Deduplication of files in ${dedupFolders}";

        serviceConfig = {
          Type = "oneshot";    # Service designed to run by timer once at a time.git
          ExecStart = "/run/current-system/sw/bin/jdupes -q -L -r ${dedupFolders}";    # Runs deduplications for mentioned folders
      };


      # NixOS upgrades does not trigger start of service, because only timer trigger should start service
      restartIfChanged = false;

    };


  };


}
