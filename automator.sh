# !/bin/bash
output="output.txt"
touch "$output"
for i in $(seq 1 10000); do
	echo "$i" >> "$output"
done
