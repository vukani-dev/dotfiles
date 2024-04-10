#!/bin/sh

# Very simple statusbar because nothing else is needed!
dte () {
    DATE=$(date "+ %a, %b %d | %H:%M")
    printf "📅 %s" "$DATE"
}


bat () {
    hostname=$(uname -n); if [ "$hostname" = "dala" ] || [ "$hostname" = "monk" ]; then BAT=BAT0; elif [ "$hostname" = "necessary" ]; then BAT=BAT1; else BAT="Unknown"; fi;
    CHARGE=$(cat /sys/class/power_supply/"$BAT"/capacity)
    STATUS=$(cat /sys/class/power_supply/"$BAT"/status)

    if [ "$STATUS" != "Discharging" ]; then
        printf "🔌 %s" "$CHARGE"
    else
        printf "🔋 %s" "$CHARGE"
    fi
}


sound () {
    VOL=$(pulsemixer --get-volume | awk '{print $1}')
    if [ "$VOL" -eq 0 ]; then
        printf "🔇"
    elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
        printf "🔈 %s" "$VOL"
    elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
        printf "🔉 %s" "$VOL"
    else
        printf "🔊 %s" "$VOL"
    fi
}


while true 
do 
    xsetroot -name " $(sound) | $(bat) | $(dte) "
    sleep .5 
done
