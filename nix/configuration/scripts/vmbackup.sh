#!/usr/bin/env bash

ISCSI=/run/media/martin/084838c0-5823-4c7f-8faf-0f447e4f3285
F4TB=/home/martin/4TB
rsync=/usr/bin/rsync

cp -r  /home/martin/2TB/VMS  /home/martin/4TB/VM_Backups/
cp -r  /home/martin/2TB/VMS $ISCSI/VMs
