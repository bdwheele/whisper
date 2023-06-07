#!/bin/bash

if [ $# -lt 2 ]; then
    echo Usage: $0 "<audio>" "<model>" "[<language>]" "[translate]"
    exit 1
fi

if [ $# -eq 3 ]; then
    outdir=results/$(basename $1)_${2}_${3}
    langopt="--language $3"
elif [ $# -eq 4 ]; then
    outdir=results/$(basename $1)_${2}_${3}_en
    langopt="--language $3 --task translate"
else
    outdir=results/$(basename $1)_$2
    langopt=
fi

if [ -e $outdir ]; then
    echo Output directory $outdir exists. Remove it before continuing
    exit 1
fi

mkdir $outdir



unbuffer /bin/time ./whisper.sif --model $2 --output_dir $outdir $langopt $1 | tee $outdir/$(basename $1).out

