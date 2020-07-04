#!/bin/bash

ROOT_UID=0
SUCCES=0
count_account=0

if [ "$UID" -ne "$ROOT_UID" ]
then
    echo "Need to run this script as ROOT"
    exit $E_NOTROOT
fi

while [ $count_account != 10 ]
do
    echo "account creation start..."
    NUMBER=$RANDOM
    USER="user"
    USERNAME="${USER}${NUMBER}"
    grep -q "$USERNAME" /etc/passwd
    while [ $? -ne $SUCCES ]
    do
        NUMBER=$RANDOM
        USER="user"
        USERNAME="${USER}${NUMBER}"
        grep -q "$USERNAME" /etc/passwd
    done
    echo "$USERNAME valid, account creation in progress..."
    password=$USERNAME
    pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
    useradd -p $pass -d /home/"$USERNAME" -m -g users -s /bin/bash "$USERNAME"
    echo "this account $USERNAME is created"
    echo "folder and file creation..."
    ((count_account++))
    cd /home/$USERNAME
    count_file=0
    while [ $count_file != 10 ]
    do
        FILESIZE=0
        PLANCHER=5000
        ECHELLE=50000
        while [ "$FILESIZE" -le $PLANCHER ]
        do
            FILESIZE=$RANDOM
            let "FILESIZE %= $ECHELLE"
        done
        FIC="file"
        FIC="${FIC}${count_file}"
        dd if=/dev/urandom of=$FIC count=$FILESIZE
    done
    echo "this account $USERNAME is setup"
done

exit 0