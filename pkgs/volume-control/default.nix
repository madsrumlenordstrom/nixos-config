{ lib
, pkgs
, writeShellApplication
, ...
}:

with lib;

writeShellApplication
{
  name = "volume-control";
  meta = {
    mainProgram = "volume-control";
    platforms = platforms.linux;
  };

  runtimeInputs = with pkgs; [
    wireplumber
    gnused
    libnotify
  ];

  checkPhase = "";

  text = let
    volumeMessage = "󰕾 Audio volume";
    mutedMessage = "󰝟 Audio muted";
    messageTag = "volume-control";
    changePercentage = 3;
  in /* bash */ ''
    # Script to control volume 

    ctl=""
    val=${toString changePercentage}
    message=""

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
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    volume="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed -r 's/Volume:\s//g;s/(0\.|0\.0|\.)//g')" 
    volume=$(($volume + $val))
    if [ "$volume" -le "0" ]
    then
      # Show the sound muted notification
      volume="0"
      message="${mutedMessage}"
    else
      message="${volumeMessage}"
    fi

    # Show the volume notification
    notify-send -a "change-volume" -u low -h string:x-dunst-stack-tag:${messageTag} -h int:value:"$volume" "$message"

    # Set volume
    wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ $ctl
  '';
}
