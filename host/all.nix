{ ... }:{

  nixpkgs.config.allowUnfree = true;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  boot.cleanTmpDir = true;  # Clean /tmp on boot
  boot.tmpOnTmpfs = true;  # /tmp on ram drive

  nix.autoOptimiseStore = true;    # Autodeduplicate files in store


  services.fwupd.enable = true;

  programs.iotop.enable = true;
  programs.fish.enable = true;

  services.geoclue2.enable = true;
  services.localtime.enable = true;

  location.provider = "geoclue2";

  users.motd = ''


                                                               ==    ##   ##    
  {}            {}        __                                    ===   ## ##     
 {}              {}       \ \ ___                            ========== ##   /  
 {}              {}        \ \\  \  _____         ->             ##      ## //  
 {}              {}         \ \\  \ \____\      ->->->         ##          //   
{}                {}        / //   \  ____     ->->->->   ######          //////
 {}              {}        / // /\  \ \____\    ->->->       ## \\       //     
 {}              {}       /_//_/  \__\            ->        ##  /\\ ########### 
 {}              {}                                            // \\    ##      
  {}            {}                                            //   \\    ##     


  '';

}
