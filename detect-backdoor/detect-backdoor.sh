#!/bin/bash
#Developer : echa
MONITORDIR="/home/test/test-filter"
MONITORDIR2="/home/test/test-filter2"
inotifywait -m -r -e create --format '%w%f' "${MONITORDIR}" "${MONITORDIR2}" | while read NEWFILE
do
        newfile=$(ls -Art /home/test/test-filter | tail -1 );
        newfile2=$(ls -Art /home/test/test-filter2 | tail -1 );
        if file $newfile $newfile2 | grep -qE 'php|txt|jpg.php'; then
                echo "$MONITORDIR/$newfile"
                echo "$MONITORDIR2/$newfile2"
                bash /home/test/bot.sh
        fi
sleep 2;
done

