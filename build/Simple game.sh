#!/bin/sh
echo -ne '\033c\033]0;Simple game\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Simple game.x86_64" "$@"
