#!/usr/bin/env bash


FILE_DIR="$HOME/Imagens/Screenshots"; mkdir -p "$FILE_DIR"
FILE="$FILE_DIR/$(date +%Y%m%d_%H%M%S).png"

show_help(){
  echo "Usage: $0 [full|region|window]"
}

print_region(){
  REGION=$(slurp -c ff00ffff -b 000000aa)
  grim -g "$REGION" "$FILE" && \
  wl-copy < "$FILE" && \
  notify-send "Region Screenshot Taken" "File saved in $FILE"
}

print_full(){
  grim "$FILE" && \
  wl-copy < "$FILE" && \ 
  notify-send "Fullscreen Screenshot Taken" "File saved in $FILE"
}

error(){
  echo "Opção invalida, utilize -h ou --help para mais informações"
}

main() {
  case "${1:-}" in 
    -h|--help) show_help;;
    region) print_region;;
    full) print_full;;
    *) error;;
  esac
}

main "$@"
