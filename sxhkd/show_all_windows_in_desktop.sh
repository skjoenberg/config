for n in $(bspc query -d focused -N)
do
    echo "Working on $n file name now"
    bspc node $n -g hidden=off
done