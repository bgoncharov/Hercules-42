./manger &

sleep 5

kill -s KILL $(pgrep podargos lampon xanthos deinos)
kill -s KILL $(pgrep yes)
kill -s KILL $(top -l 1 | grep manger | awk '{print $1}')

rm -rf *.poo

gcc -o my_mares my_mares.c

./my_mares &

sleep 5

killall -9 my_mares
