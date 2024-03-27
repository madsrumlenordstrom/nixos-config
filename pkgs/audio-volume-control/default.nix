{ lib
, pkgs
, writeShellApplication
, ...
}:

with lib;

writeShellApplication
{
  name = "audio-volume-control";
  meta = {
    mainProgram = "audio-volume-control";
    platforms = platforms.linux;
  };

  runtimeInputs = with pkgs; [
    wireplumber
    gnused
    libnotify
  ];

  checkPhase = "";

  text = let
    changePercentage = 3;
  in /* bash */ ''
    # Script to control volume 

    get_volume() {
      echo "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed -r 's/Volume:\s//g;s/(0\.|0\.0|\.)//g;s/\[MUTED\]//g')" 
    }

    get_muted() {
      if [[ $(wpctl get-volume @DEFAULT_AUDIO_SINK@) == *"[MUTED]" ]]; then echo true; else echo false; fi
    }

    get_icon() {
      if [[ $(get_muted) == true ]]; then echo "audio-volume-muted-symbolic"; else echo "audio-volume-high-symbolic"; fi
    }

    notify_volume() {
      notify-send --hint string:x-canonical-private-synchronous:audio-volume-control --hint int:value:$(get_volume)  --icon $(get_icon) "Audio volume" $1
    }

    toggle_volume() {
      wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      notify_volume $(if [[ $(get_muted) == true ]]; then echo "muted"; else echo "unmuted"; fi)
    }

    unmute_volume() {
      wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    }

    increase_volume() {
      unmute_volume
      wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ "${toString changePercentage}%+"
      notify_volume "increased"
    }

    decrease_volume() {
      unmute_volume
      wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ "${toString changePercentage}%-"
      notify_volume "decreased"
    }

    case $1 in
      increase)
        increase_volume
      ;;
      decrease)
        decrease_volume
      ;;
      toggle)
        toggle_volume
      ;;
      *)
        echo "Run script with correct argument:\n$0 <increase|decrease|toggle>"
        exit 1
      ;;
    esac
  '';
}
