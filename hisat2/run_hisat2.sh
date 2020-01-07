#!/usr/bin/bash

PATH=hisat2-2.1.0:$PATH

echo "-------------------------------------------------------------"

GENOME=Canis_familiaris.CanFam3.1.dna_sm.toplevel.fa
SHORT_NAME=$(echo $GENOME | sed 's/\./ /g' | cut -f 1 -d " ")

echo "starting hisat2 index"

hisat2-build ${GENOME} ${SHORT_NAME}

echo "end hisat2 index"


echo "starting hisat2 mapping"

echo "end hisat2 mapping"

echo "-------------------------------------------------------------"




