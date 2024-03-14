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
    kbBrightnessMessage = "󰌌 Keyboard brightness";
    messageTag = "kb-brightness-control";
    changePercentage = 3;
    device = "*kbd_backlight"; # Find with 'brightnessctl --list'
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
    max_bright="$(brightnessctl -m --device='${device}' max)" 
    bright="$(brightnessctl -m --device='${device}' get)" 
    bright=$(($bright * 100 / $max_bright))
    bright=$(($bright + $val))
    if [ "$bright" -le "0" ]
    then
    	bright=0
    fi
    notify-send -u low -h string:x-dunst-stack-tag:${messageTag} -h int:value:"$bright" "${kbBrightnessMessage}"

    # Set brightness
    brightnessctl -q --device='${device}' set $ctl
  '';
}
