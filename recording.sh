#!/usr/bin/env bash

OPTIONS=("One track recording" "Double track recording" "Stop recording")

CHOICE=$(printf "%s\n" "${OPTIONS[@]}" | rofi -dmenu -p "Select which type of recording")

REC_DIR="$HOME/Vídeos/Recordings"
mkdir -p "$REC_DIR"
SIMPLE_REC_FILE="$REC_DIR/SIM_$(date +%Y-%m-%d_%H:%M:%S).mkv"
ADV_REC_FILE="$REC_DIR/ADV_$(date +%Y-%m-%d_%H:%M:%S).mkv"

toggle_mic_on() {
    MIC_STATUS=$(amixer get Capture | grep -o 'off')

    if [ "$MIC_STATUS" == "off" ]; then
        notify-send "Microphone active"
        amixer set Capture toggle
    fi
}

simple_recording() {
    toggle_mic_on
    notify-send "One track recording on run"
    gpu-screen-recorder -w screen -f 60 -a "default_output|default_input" -o $SIMPLE_REC_FILE
    notify-send "Saved recording to: $SIMPLE_REC_FILE"
}

advanced_recording() {
    toggle_mic_on
    notify-send "Double track recording on run"
    gpu-screen-recorder -w screen -f 60 -a default_output -a default_input -o $ADV_REC_FILE
    notify-send "Saved recording to: $ADV_REC_FILE"
}

stop() {
    pkill -SIGINT -f gpu-screen-recorder && notify-send "Stopping recording"
}

main() {
    case "$CHOICE" in
    "One track recording")
        simple_recording
        ;;
    "Double track recording")
        advanced_recording
        ;;
    "Stop recording")
        stop
        ;;
    *)
        exit 0
        ;;
    esac
}

main "$@"
