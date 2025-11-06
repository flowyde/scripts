#!/usr/bin/env bash

FILE_DIR="$HOME/Imagens/Screenshots"
mkdir -p "$FILE_DIR"
FILE="$FILE_DIR/$(date +%Y%m%d_%H%M%S).png"

show_help() {
    echo "Usage: $0 [--flameshot] [full|region]"
}

print_region_grim() {
    REGION=$(slurp -c ff00ffff -b 000000aa)
    grim -g "$REGION" "$FILE" &&
        wl-copy <"$FILE" &&
        notify-send "Region Screenshot Taken" "File saved in $FILE"
}

print_full_grim() {
    grim "$FILE" &&
        wl-copy <"$FILE" && \ 
    notify-send "Fullscreen Screenshot Taken" "File saved in $FILE"
}

print_region_flameshot() {
    flameshot gui -p "$FILE" &&
        wl-copy <"$FILE" &&
        notify-send --icon=$FILE "Region Screenshot Taken with Flameshot" "File saved in $FILE"
}

print_full_flameshot() {
    flameshot full -p "$FILE" &&
        wl-copy <"$FILE" &&
        notify-send --icon=$FILE "Fullscreen Screenshot Taken with Flameshot" "File saved in $FILE"
}

error() {
    echo "Invalid option, use -h or --help for more info."
}

main() {
    local USE_FLAMESHOT=false

    if [[ "$1" == "--flameshot" ]]; then
        USE_FLAMESHOT=true
        shift
    fi

    case "${1:-}" in
    -h | --help) show_help ;;
    region)
        if $USE_FLAMESHOT; then
            print_region_flameshot
        else
            print_region_grim
        fi
        ;;
    full)
        if $USE_FLAMESHOT; then
            print_full_flameshot
        else
            print_full_grim
        fi
        ;;
    *) error ;;
    esac
}

main "$@"
