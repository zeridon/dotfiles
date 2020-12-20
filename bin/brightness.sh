#!/usr/bin/env bash
#
#set -x
#
# Example for triggerhappy
# https://github.com/wertarbyte/triggerhappy/issues/27
# KEY_KPPLUS+KEY_LEFTMETA  1 /home/zeridon/tmp/brightness.sh -u 5
# KEY_KPMINUS+KEY_LEFTMETA 1 /home/zeridon/tmp/brightness.sh -d 5

while getopts ":u:d:" opt; do
	case ${opt} in
		u) # process option a
			_action='u'
			_val=${OPTARG}
			;;
		d) # process option t
			_action='d'
			_val=${OPTARG}
			;;
		\?)
			echo "Usage: $0 -u|-d <number>"
			exit -9
			;;
		:)
			echo "Invalid option: $OPTARG requires an argument" 1>&2
			exit -20
			;;
	esac
done
shift $((OPTIND -1))

if [ ${_val} > 100 ] ; then _val=100 ; fi
if [ ${_val} < 1 ] ; then _val=1 ; fi

_max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
_cur=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
_step=$((_max/100))

case ${_action} in
	u)
		_next=$((_cur + _val * _step))
		;;
	d)
		_next=$((_cur - _val * _step))
		;;
	*)
		:
		;;
esac

if [ ${_next} > ${_max} ] ; then _next=${_max} ; fi
if [ ${_next} < 1 ] ; then _next=1 ; fi

echo ${_next} > /sys/class/backlight/intel_backlight/brightness
