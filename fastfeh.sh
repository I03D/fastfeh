#!/bin/bash

set -x

path=$(dirname "$0")

function initialize {
	# Если папки нет, создать и скопировать изображение-пример:
	if [ ! -d "$1/$2" ]; then
		mkdir "$1" -p
		cp "$path/$2" "$1/$2"
	fi
}

mkdir "$HOME/wallpapers" -p

day_folder=$HOME/wallpapers/day
night_folder=$HOME/wallpapers/night

initialize $day_folder "day_sample.png"
initialize $night_folder "night_sample.png"

# Выбрать обои в зависимости от текущей темы:

theme=${THEME}
if [ "$theme" == "" ]; then theme=$(cat "$HOME/.theme")
fi

if [ "$theme" == "dark" ]; then
	rand=$(find "$night_folder" | shuf -n 1)
else
	rand=$(find "$day_folder" | shuf -n 1)
fi

# Установить изображение на рабочий стол:
feh --bg-scale "$rand"

