#!/bin/bash

BU=https://download.fedoraproject.org/pub/fedora/linux/releases/30/Cloud/x86_64/images/

[ -d tmp ] || mkdir tmp

FN=tmp/list.html
[ -f "$FN" ] || curl -L --output "$FN" "$BU"

IFN=tmp/`cat "$FN" | grep href= | tr '"' "\n" | grep qcow2$`
[ -f "$IFN" ] || curl -L --output "$IFN" "$BU/$IFN"
