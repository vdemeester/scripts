#!/bin/sh
# Quick and *very* dirty script to halt/reboot/suspend computer
# via ConsoleKit

if [ $1 = "halt" ]; then
	# Halt
	dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop
elif [ $1 = "reboot" ]; then
	# Reboot
	dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart
elif [ $1 = "suspend" ]; then
	# Suspend
	dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend
fi
