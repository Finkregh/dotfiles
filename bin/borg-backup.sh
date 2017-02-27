#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

REPOSITORY="/mnt/usb-green/borg-laptop"
_NOTIFY_TIMEOUT=10000

pacman -Qqe > /root/backup/package-list.txt

zpool status usb-green || zpool import usb-green || exit 1

IFS= read -s  -p Password: pwd
export BORG_PASSPHRASE="${pwd}"
echo ""

notify-send -t ${_NOTIFY_TIMEOUT} -u normal "starting borg backup" "home"
borg create --progress --compression lz4 -v --stats ${REPOSITORY}::lorenzen-home-'{now:%Y-%m-%d}' /home/lorenzen --exclude /home/lorenzen/.cache # || { echo >&2 "first backup-run failed, exiting!"; exit 1; }

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machine's archives also.
borg prune -v --list ${REPOSITORY} --prefix 'lorenzen-home-' \
        --keep-daily=7 --keep-weekly=4 --keep-monthly=6

notify-send -t ${_NOTIFY_TIMEOUT} -u normal "finished borg backup" "home"

notify-send -t ${_NOTIFY_TIMEOUT} -u normal "starting borg backup" "system"

borg create --progress --one-file-system -v --stats --compression lz4 ${REPOSITORY}::system-'{now:%Y-%m-%d}' / \
               --exclude /proc \
               --exclude /media \
               --exclude /home \
               --exclude /mnt \
               --exclude /sys \
               --exclude /run \
               --exclude /dev \
               --exclude /tmp



borg prune -v --list ${REPOSITORY} --prefix 'system-' \
        --keep-daily=7 --keep-weekly=4 --keep-monthly=6

notify-send -t ${_NOTIFY_TIMEOUT} -u normal "finished borg backup" "system"
