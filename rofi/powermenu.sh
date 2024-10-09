#!/usr/bin/env bash
dir="$HOME/.config/rofi"
theme='this'

# Options
shutdown=' | shutdown'
reboot=' | reboot'
lock=' | lock'
suspend=' | suspend'
yes='yes'
no='no'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-theme ${dir}/${theme}.rasi
}

#Confirmation CMD
# confirm_cmd() {
# 	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
# 		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
# 		-theme-str 'listview {columns: 2; lines: 1;}' \
# 		-theme-str 'element-text {horizontal-align: 0.5;}' \
# 		-theme-str 'textbox {horizontal-align: 0.5; background-color: var(background-alt); text-color: var(foreground);}' \
# 		-dmenu \
# 		-p 'Confirmation' \
# 		-mesg 'Are you Sure?' \
# 		-theme ${dir}/${theme}.rasi
# }

# Ask for confirmation
# cexit() {
# 	#echo -e "$yes\n$no" | confirm_cmd
# }
#
# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	# selected="$(cexit)"
	if [[ "true" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--suspend' ]]; then
			mpc -q pause
			amixer set Master mute
			systemctl suspend	
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		if [[ -x '/usr/bin/betterlockscreen' ]]; then
			betterlockscreen -l
		elif [[ -x '/usr/bin/i3lock' ]]; then
			i3lock
		fi
        ;;
    $suspend)
		run_cmd --suspend
        ;;
esac
