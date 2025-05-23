#!/usr/bin/env bash
#

PERCENT=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)
case $((\
$PERCENT >= 0 && $PERCENT <= 20 ? 1 : \
$PERCENT > 20 && $PERCENT <= 40 ? 2 : \
$PERCENT > 40 && $PERCENT <= 60 ? 3 : \
$PERCENT > 60 && $PERCENT <= 80 ? 4 : 5)) in
#
1) echo $STATUS:"":$PERCENT% ;;
2) echo $STATUS:"":$PERCENT% ;;
3) echo $STATUS:"":$PERCENT% ;;
4) echo $STATUS:"":$PERCENT% ;;
5) echo $STATUS:"":$PERCENT% ;;
esac
