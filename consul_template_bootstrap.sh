#!/bin/bash

####### start consul-template

# consul-template ...

/root/tsf-consul-template-docker/script/start.sh


####### clean up files

for str in ${BOOT_FILES//;/ } ; do
    if [ "$str" = "/" ]; then
        echo "Can not delete path /"
        exit 1
    fi

    if [[ -n "$str" ]] && [[ -e "$str" ]] ; then
    	echo "remove file $str on disk"
    	rm -f $str
    fi
done

####### check files


# TODO: test. delete
# BOOT_FILES="/path/to/file1;/path/to/file2"

# default sleep 30*2s = 1min
BOOT_FILES_TRY_TIMES=${BOOT_FILES_TRY_TIMES:-30}
found_empty=0
for (( i = 1; i <= BOOT_FILES_TRY_TIMES; i++ )); do
    echo "check boot files #$i"
    found_empty=0
    for str in ${BOOT_FILES//;/ } ; do
        if [[ -n "$str" ]]; then
            if [[ -e "$str" ]]; then
                echo "file $str exists"
            else
                echo "file $str not exists, will retry in 2s"
                sleep 2
                found_empty=1
                break
            fi
        fi
    done
    if [[ $found_empty -eq 1 ]]; then
        sleep 2
    else
        break
    fi
done

if [[ $found_empty -eq 0 ]]; then
    echo "all files exist, continue starting"
else
    echo "some file not exist and hit retry limit"
    exit 1
fi