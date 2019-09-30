{ pkgs, ... }:

let

  backupRepos = ''/home/pyro/org/dictionary
    /home/pyro/org/journal
    /home/pyro/org/word
  '';

in {


  #environment.systemPackages = with pkgs; [
  #  unstable.jdupes    # Deduplication utilitie
  #];


  systemd = {

    # Timer for file deduplication
      timers.backupGitPush = {

        description = "Git backup of commits in ${backupRepos}";

        timerConfig = {
          # Time to wait after boot before trigger first time
          OnBootSec = "1min";
          # Time between consecutive triggering
          OnCalendar = "*-*-* 00/4:00:00"; # Every hours that delete on 4 (every 4 hours)
        };

        wantedBy = [ "timers.target" ];    # To be enabled, is hooked to the default timers traget

      };


    # This service should be run by the timer. Not by itself, not by NixOS.
    services.backupGitPush = {

      description = "Git backup of commits in ${backupRepos}";

        serviceConfig = {
          Type = "oneshot";    # Service designed to run by timer once at a time.git
          ExecStart = "echo ${backupRepos} | xargs I'{!}' cd '{!}'&&/run/current-system/sw/bin/git push --all";    # Runs backup for mentioned folders
      };


      # NixOS upgrades does not trigger start of service, because only timer trigger should start service
      restartIfChanged = false;

    };


  };


}
