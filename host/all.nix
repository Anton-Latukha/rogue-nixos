{ ... }:{

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  boot.cleanTmpDir = true;  # Clean /tmp on boot
  boot.tmpOnTmpfs = true;  # /tmp on ram drive

}
