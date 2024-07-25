[[ -f ~/.Xmodmap]] && xmodmap ~/.Xmodmap
xmodmap -e 'clear lock' &
synclient AreaLeftEdge=150 &
synclient AreaRightEdge=1700 &
~/projects/Bash/Download\ Monitoring/./Download-Monitoring.sh &

