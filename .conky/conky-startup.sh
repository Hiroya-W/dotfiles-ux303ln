sleep 20s
killall conky
cd "/home/hiroya/.conky/conky_rings"
conky -c "/home/hiroya/.conky/conky_rings/cpu" &
cd "/home/hiroya/.conky/conky_rings"
conky -c "/home/hiroya/.conky/conky_rings/mem" &
cd "/home/hiroya/.conky/conky_rings"
conky -c "/home/hiroya/.conky/conky_rings/notes" &
cd "/home/hiroya/.conky/conky_rings"
conky -c "/home/hiroya/.conky/conky_rings/rings" &
