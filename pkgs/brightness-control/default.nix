{ lib
, pkgs
, writeShellApplication
, ...
}:

with lib;

writeShellApplication
{
  name = "brightness-control";
  meta = {
    mainProgram = "brightness-control";
    platforms = platforms.linux;
  };

  runtimeInputs = with pkgs; [
    libnotify
    brightnessctl
  ];

  checkPhase = "";

  text = let
    brightnessMessage = "󰍹 Screen brightness";
    messageTag = "brightness-control";
    changePercentage = 3;
  in /* bash */ ''

    # Script to control brightness of screen

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
    max_bright="$(brightnessctl -m max)" 
    bright="$(brightnessctl -m get)" 
    bright=$(($bright * 100 / $max_bright))
    bright=$(($bright + $val))
    if [ "$bright" -le "0" ]
    then
    	bright=0
    fi
    notify-send -u low -h string:x-dunst-stack-tag:${messageTag} -h int:value:"$bright" "${brightnessMessage}"

    # Set brightness
    brightnessctl -q set $ctl
  '';
}
