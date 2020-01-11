genome=$1

if [ $genome == "familiaris" ]
then
        gtfreference=Canis_familiaris.CanFam3.1.98.gtf
elif [ $genome == "dingo" ]
then
        gtfreference=Canis_lupus_dingo.ASM325472v1.98.gtf
else
        echo "ERROR - genome missing"
        exit
fi

rm Aligned.out.sam
rm ReadsPerGene.out.tab

for A in $(ls ../canis/raw_reads/raw_reads/*fastq | sort | grep "" | grep "_R1_")
do
        echo $A
        B=$(ls $A | sed 's/_R1_/_R2_/g')
        echo $B
        C=$(ls $A | sed 's/_R1_/_RX_/g')
        echo $C
        C=$(basename $C)

        ../canis/STAR-2.7.3a/bin/Linux_x86_64/STAR --runThreadN 16 --genomeDir index --quantMode GeneCounts --sjdbGTFfile $gtfreference --readFilesIn $A $B

        mv Aligned.out.sam ${C}.sam
        mv ReadsPerGene.out.tab ${C}_ReadsPerGene.tab

done
