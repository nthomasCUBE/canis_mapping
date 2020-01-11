#!/usr/bin/bash

echo "-------------------------------------------------------------"

PATH=hisat2-2.1.0:$PATH

echo "-------------------------------------------------------------"

GENOME=Canis_familiaris.CanFam3.1.dna_sm.toplevel.fa
SHORT_NAME=$(echo $GENOME | sed 's/\./ /g' | cut -f 1 -d " ")

echo "starting hisat2 index"

#hisat2-build ${GENOME} ${SHORT_NAME}

echo "end hisat2 index"

echo "-------------------------------------------------------------"

echo "starting hisat2 mapping"

for A in $(ls ../_old/canis/raw_reads/raw_reads/*fastq | sort | grep "" | grep "_R1_")
do
        date
        echo $A
        B=$(ls $A | sed 's/_R1_/_R2_/g')
        C=$(ls $A | sed 's/_R1_/_RX_/g')
        C=$(basename $C)

        hisat2 -p 16 -x ${SHORT_NAME} -1 ${A} -2 ${B} -S ${C}.sam

        echo $A
        echo $B
        echo $C
        date
done

echo "end hisat2 mapping"

date

echo "-------------------------------------------------------------"
