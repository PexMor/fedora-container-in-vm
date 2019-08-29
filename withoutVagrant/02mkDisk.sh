#!/bin/bash

SRC=$PWD/`ls tmp/Fedora-Cloud-*.qcow2 | tail -1`

if [ ! -z "$SRC" ]; then
    FN="$PWD/tmp/work-disk.qcow2"
    [ -f "$FN" ] || qemu-img create -f qcow2 -b "${SRC}" "$FN" 20G
fi
