# -------------------------------------------------------------------------------
# making the index

GENOME=GCA_003254725.1_ASM325472v1_genomic.fna

./STAR-2.7.3a/bin/Linux_x86_64/STAR --runMode genomeGenerate --genomeDir test/genome/ --genomeFastaFiles ${GENOME}

# -------------------------------------------------------------------------------
# mapping the reads

for A in $(ls raw_reads/raw_reads/*fastq | sort | grep "" | grep "_R1_")
do
        echo $A
        B=$(ls $A | sed 's/_R1_/_R2_/g')
        echo $B
        C=$(ls $A | sed 's/_R1_/_RX_/g')
        echo $C
        ls -al $A
        ls -al $B
        echo
        ./STAR-2.7.3a/bin/Linux_x86_64/STAR --genomeDir canis/test/genome --readFilesIn $A $B
done
# -------------------------------------------------------------------------------

