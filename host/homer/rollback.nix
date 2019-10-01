{

  systemd = {


    timers.rollback = {


      description = "Checks every N minutes does system need to rollback. Runs service with same name.";

      timerConfig = {
        # Time to wait after boot before trigger first time
        OnBootSec = "10min";
        # Time between consecutive triggering
        OnUnitActiveSec = "20m";
      };

      wantedBy = [ "timers.target" ];    # To be enabled, is hooked to the default timers traget

    };


    # This service should be run by the timer. Not by itself, not by NixOS.
    services.rollback = {


      description = "Service that does NixOS rollbacks";

      serviceConfig = {
        Type = "oneshot";    # Service designed to run by timer once at a time.
        ExecStart = "/run/current-system/sw/bin/bash -x /etc/nixos/rollback.sh";    # Runs rollback script
      };

      # NixOS upgrades does not trigger start of service, because only timer trigger should start service
      restartIfChanged = false;

    };


  };


}

