#!/bin/bash
BAT=$(ls /sys/class/power_supply | grep BAT | head -n 1 | awk '{print $1}')
while true; do

  bat_lvl=$(cat /sys/class/power_supply/${BAT}/capacity)
  bat_status=$(cat /sys/class/power_supply/${BAT}/status)

  if [ $"bat_status" == "Discharging" ] ; then

      if [ "$bat_lvl" -le 15 ]; then
        notify-send --urgency=CRITICAL -i battery-empty -h int:value:${bat_lvl} "Battery Low" "Level: ${bat_lvl}%"
        sleep 300
      elif [ "$bat_lvl" -le 20 ]; then
        notify-send --urgency=NORMAL -i battery-caution -t 15000 -h int:value:${bat_lvl} "Battery Low" "Level: ${bat_lvl}%"
        sleep 300
      elif [ "$bat_lvl" -le 30 ]; then
        notify-send --urgency=LOW -i battery-low -t 10000 -h int:value:${bat_lvl} "Battery Low" "Level: ${bat_lvl}%"
        sleep 300
      else
        sleep 120
      fi
  fi
done

