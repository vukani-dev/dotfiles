#!/bin/sh

dte () {
    DATE=$(date "+ %a, %b %d | %H:%M")
    printf "📅 %s" "$DATE"
}


bat () {
    CHARGE=$(cat /sys/class/power_supply/BAT1/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT1/status)

    if [ "$STATUS" != "Discharging" ]; then
        printf "🔌 %s" "$CHARGE"
    else
        printf "🔋 %s" "$CHARGE"
    fi
}


net () {
    connection_type=$(nmcli -t -f TYPE connection show --active | grep -v 'loopback')

if [[ $connection_type == "802-11-wireless" ]]; then
    # If the connection type is Wi-Fi, get the SSID
    wifi_name=$(nmcli -t -f NAME connection show --active | grep -vE '^lo$')
    ESSID="$wifi_name"
elif [[ $connection_type == "802-3-ethernet" ]]; then
    # If the connection type is Ethernet, print "Wired"
    ESSID="Wired"
else
    # If there is no active connection, print "No connection"
    ESSID="No connection"
fi

        printf "🌐 %s" "$ESSID"
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

mus () {
    if ps -C mpd > /dev/null; then
        TRACK=$(mpc current)
        POSITION=$(mpc status | grep "%)" | awk '{ print $3 }' | awk -F/ '{ print $1 }')
        DURATION=$(mpc current -f %time%)
        STATUS=$(mpc status | sed -n 2p | awk '{print $1;}')

        if [ "$STATUS" = "" ]; then
            printf ""
            
        else
            if [ "$STATUS" = "[playing]" ]; then
                printf "▶  %s %s/%s |" "$TRACK" "$POSITION" "$DURATION"
            else
                printf "=  %s %s/%s |" "$TRACK" "$POSITION" "$DURATION"
            fi
        fi
        
    fi
}

while true 
do 
    xsetroot -name " $(mus) $(sound) | $(bat) | $(dte) "
    sleep .5 
done
