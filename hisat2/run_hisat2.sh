#!/usr/bin/bash

PATH=hisat2-2.1.0:$PATH

echo "-------------------------------------------------------------"

GENOME=Canis_familiaris.CanFam3.1.dna_sm.toplevel.fa
SHORT_NAME=$(echo $GENOME | sed 's/\./ /g' | cut -f 1 -d " ")

echo "starting hisat2 index"

#hisat2-build ${GENOME} ${SHORT_NAME}

echo "end hisat2 index"


echo "starting hisat2 mapping"

head -n 10000 ../_old/canis/raw_reads/raw_reads/1033_ACAGTG_L006_R1_20M.fastq > tmp1.fastq
head -n 10000 ../_old/canis/raw_reads/raw_reads/1033_ACAGTG_L006_R1_20M.fastq > tmp2.fastq

hisat2 -x ${SHORT_NAME} -1 tmp1.fastq -2 tmp2.fastq -S tmp12.sam

echo "end hisat2 mapping"

echo "-------------------------------------------------------------"



