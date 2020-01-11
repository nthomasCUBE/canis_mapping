#!/usr/bin/bash

GENOME=$1
POS=$2

echo $GENOME
echo $POS

if [ $GENOME == "familaris" ]
then
        arr=($(ls -d SAM/*))
        FILE=${arr[$POS]}
        BN=$(basename $FILE)
        echo $FILE
        tmp=$(mktemp)
        tmp=$(basename $tmp)
        less $FILE | grep -w "NH:i:1" > $tmp
        python ../_old/canis/DEXSeq-master/inst/python_scripts/dexseq_count.py --paired yes Canis_familiaris.CanFam3.1.98.flattened.gff3 ${tmp} COUNT2/${BN}.count
elif [ $GENOME == "dingo" ]
then
        arr=($(ls -d SAM/*))
        FILE=${arr[$POS]}
        BN=$(basename $FILE)
        echo $FILE
        tmp=$(mktemp)
        tmp=$(basename $tmp)
        less $FILE | grep -w "NH:i:1" > $tmp
        python ../_old/canis/DEXSeq-master/inst/python_scripts/dexseq_count.py --paired yes Canis_lupus_dingo.ASM325472v1.98_flattened.gff3 ${FILE} COUNT2/${BN}.count
fi
