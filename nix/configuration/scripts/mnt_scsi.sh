#!/usr/bin/env bash

sudo iscsiadm -m discovery -t sendtargets -p 192.168.2.16
sudo iscsiadm --mode node --targetname iqn.2005-10.org.freenas.ctl:desktop --portal 192.168.2.16 --login
## sudo mount /dev/sdb1 /mnt/iscsi_3tb
