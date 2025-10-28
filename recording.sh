#!/usr/bin/env bash

toggle_mic_on() {
  MIC_STATUS=$(amixer get Capture | grep -o 'off')

  if [ "$MIC_STATUS" == "off" ]; then
    notify-send "Microphone active"
    amixer set Capture toggle
  else
    notify-send "Microphone active"
  fi
}

record() {
  toggle_mic_on
}

record
