#!/bin/bash

{ which curl; which convert; which composite; } >> /dev/null || exit 1

BASE=$(dirname $(readlink -f $0))

rm ${BASE}/*.png
curl "https://va-rv.pogoalerts.net/static/icons-safe-1.png" > icons.png

for x in $(seq 0 27)
do 
    for y in $(seq 0 13)
    do 
        x1=$((x+1))
        n=$((x1+(28*y)))
        convert icons.png -crop 40x40+$((x*40))+$((y*40)) ${BASE}/${n}.png
    done
done

for t in $(echo "instinct mystic valor")
do
    for l in $(seq 1 5)
    do
        curl "https://va-rv.pogoalerts.net/static/forts/shield/${t}_${l}.png" > ${BASE}/${t}_${l}.png
    done

    for l in $(cat ${BASE}/raid-levels.txt)
    do
        n=$(echo $l | cut -d, -f1)
        r=$(echo $l | cut -d, -f2)
        
        composite -gravity center ${BASE}/${n}.png ${BASE}/${t}_${r}.png ${BASE}/${t}_r${n}.png
    done
done

for x in $(echo "legendary rare")
do
    curl "https://va-rv.pogoalerts.net/static/raids/egg_${x}.png" > ${BASE}/egg_${x}.png
done

exit 0
