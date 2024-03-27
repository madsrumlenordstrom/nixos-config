{ lib
, pkgs
, writeShellApplication
, ...
}:

with lib;

writeShellApplication
{
  name = "kbd-brightness-control";
  meta = {
    mainProgram = "kbd-brightness-control";
    platforms = platforms.linux;
  };

  runtimeInputs = with pkgs; [
    libnotify
    brightnessctl
  ];

  checkPhase = "";

  text = let
    changePercentage = 3;
    device = "*kbd_backlight"; # Find with 'brightnessctl --list'
  in /* bash */ ''

    # Script to control brightness of keyboard

    get_max_brightness() {
      brightnessctl --machine-readable --device='${device}' max
    }

    get_brightness() {
      brightnessctl --machine-readable --device='${device}' get
    }

    get_brightness_percentage() {
      echo $(($(get_brightness) * 100 / $(get_max_brightness)))
    }

    notify_brightness() {
      notify-send --hint string:x-canonical-private-synchronous:kbd-brightness-control --hint int:value:$(get_brightness_percentage)  --icon keyboard-brightness-symbolic "Keyboard brightness" $1
    }

    increase_brightness() {
      brightnessctl --quiet --device='${device}' set ${toString changePercentage}%+
      notify_brightness "increased"
    }

    decrease_brightness() {
      brightnessctl --quiet --device='${device}' set ${toString changePercentage}%-
      notify_brightness "decreased"
    }

    case $1 in
      increase)
        increase_brightness
      ;;
      decrease)
        decrease_brightness
      ;;
      *)
        echo "Run script with correct argument:\n$0 <increase|decrease>"
        exit 1
      ;;
    esac
  '';
}
