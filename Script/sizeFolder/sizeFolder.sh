#!/bin/bash
TOTAL_SIZE_HUMAN=$(du -c -k -h /home/user* | tail -1 | cut -dt -f1 )" = taille totale des répertoires humains"
echo $TOTAL_SIZE_HUMAN
du -s -k -h $HOME
capacity_warning=$(du -s -k $HOME | cut -d/ -f1)
if [ $capacity_warning -ge 100 ]
then
	echo "WARNING --> Storage is greater than 100 Ko"
fi
size=$(du -b /home/user* | cut -d/ -f1 | tr "\n" " ")
user=$(du -b /home/user* | cut -d/ -f3 | tr "\n" " ")
declare -a sizes
read -a sizes << !
$size
!
declare -a users
read -a users << !
$user
!
i=0
k=0;
j=0;
m=0
declare -a sort_sizes
declare -a sort_sizes_users
max=0
while [ $k -lt ${#sizes[*]} ]
do
	j=0
	max=${sizes[0]}
	while [ $j -lt ${#sizes[*]} ]
	do
		if [ $max -le ${sizes[j]} ]
		then
			max=${sizes[j]}
			current_max=$j
		fi
		j=$((j+1))
	done;
	sort_sizes[k]=$max;
	sort_sizes_users[k]=${users[current_max]}
	sizes[current_max]=-1
	k=$((k+1))
done
i=0
while [ $i -lt 5 ]
do
	Ko=$(( (${sort_sizes[i]}/1024) ))
	Mo=$(( (Ko/1024) % 1024 ))
	Go=$(( (Mo/1024) % 1024 ))
	To=$(( (Go/1024) % 1024 ))
	echo ${sort_sizes_users[i]} "a une taille de : "$To" To | " $Go" Go | "$Mo" Mo | "$Ko" Ko"
	i=$((i+1))
done
