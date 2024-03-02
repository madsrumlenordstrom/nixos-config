{ lib
, pkgs
, writeShellApplication
, ...
}:

with lib;

writeShellApplication
{
  name = "kb-brightness-control";
  meta = {
    mainProgram = "kb-brightness-control";
    platforms = platforms.linux;
  };

  runtimeInputs = with pkgs; [
    libnotify
    brightnessctl
  ];

  checkPhase = "";

  text = let
    kbBrightnessMessage = "Keyboard brightness";
    messageTag = "kb-brightness-control";
    changePercentage = 3;
  in /* bash */ ''

    # Script to control brightness of keyboard

    ctl=""
    val=${toString changePercentage}

    # Get argument
    if [ "$1" = "up" ]
    then
    	ctl="$val%+"
    elif [ "$1" = "down" ]
    then
    	ctl="$val%-"
    	val=-$val
    else
    	echo "Run script with correct argument:\n$0 <up|down>"
    	exit 1
    fi

    # Show notification
    bright="$(brightnessctl -m --device=smc::kbd_backlight get)" 
    bright=$(($bright * 100 / 255))
    bright=$(($bright + $val))
    if [ "$bright" -le "0" ]
    then
    	bright=0
    fi
    notify-send -a "change-kb-brightness" -u low -h string:x-dunst-stack-tag:${messageTag} -h int:value:"$bright" "${kbBrightnessMessage}"

    # Set brightness
    brightnessctl -q --device=smc::kbd_backlight set $ctl
  '';
}
