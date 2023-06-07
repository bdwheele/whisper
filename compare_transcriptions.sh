#!/bin/bash

if [ $# -lt 2 ]; then
    echo Usage: $0 "<text1>" "<text2>"
    exit 1
fi

wdiff --ignore-case --statistics <(cat "$1" | sed 's~[^[:alnum:]]\+~ ~g')  <(cat "$2" | sed 's~[^[:alnum:]]\+~ ~g')
