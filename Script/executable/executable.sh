#!/bin/bash
FILE=./exe-list.txt
array=( $(find / -perm /6000 -type f 2>/dev/null) )
If [[ -f  "$FILE" ]]; then
	for i in ${array[@]}
	do
		if [[ ! $(grep -x "$I" "${FILE##*/)"  ]];
		filedate=$(date -r $i +"%d-%m-%Y %H:%M:%S")
		echo "Avertissement : $i modifiée le $filedate"
		fi
	done
Else
{ [ "${#array[@]}" -eq 0 ]  || printf "%s\n" "${array[@]}"; }  > "$FILE"
fi