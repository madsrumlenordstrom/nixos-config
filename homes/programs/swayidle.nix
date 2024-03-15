{ inputs, outputs, lib, config, pkgs, ... }:
{
  services.swayidle = let 
    # inactiveTime = 900; # Seconds idle before going to sleep
    inactiveTime = 900; # Seconds idle before going to sleep
    swaylock = "${config.programs.swaylock.package}/bin/swaylock";
    swaymsg = "${config.wayland.windowManager.sway.package}/bin/swaymsg";
    outputPower = "${swaymsg} output \"*\" power";
  in {
    enable = true;

    timeouts = [
      # For when the inactive time has already been reached and display is locked. It should then quickly power off display if user remains inactive
      { timeout = 10; command = "if ${pkgs.procps}/bin/pgrep --exact --full ${swaylock}; then ${outputPower} off; fi"; resumeCommand = "${outputPower} on"; }

      # Timeout for locking windown manager
      { timeout = inactiveTime; command = "${swaylock}"; }

      # Timeout for powering off displays
      { timeout = inactiveTime + 10; command = "${outputPower} off"; resumeCommand = "${outputPower} on"; }
    ];
  };

  # Fix
  systemd.user.services.swayidle.Service.Restart = lib.mkForce "on-failure";
  systemd.user.services.swayidle.Service.RestartSec = 3;
}
