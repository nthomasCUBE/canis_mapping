rm Aligned.out.sam
rm ReadsPerGene.out.tab

gtfreference="Canis_lupus_dingo.ASM325472v1.98.gtf"

for A in $(ls raw_reads/raw_reads/*fastq | sort | grep "" | grep "_R1_")
do
        echo $A
        B=$(ls $A | sed 's/_R1_/_R2_/g')
        echo $B
        C=$(ls $A | sed 's/_R1_/_RX_/g')
        echo $C
        C=$(basename $C)
        ls -al $A
        ls -al $B

        tmp1=$(mktemp)
        tmp2=$(mktemp)
        head -n 10000 $A > $tmp1
        head -n 10000 $B > $tmp2

        ./STAR-2.7.3a/bin/Linux_x86_64/STAR --genomeDir canis/test/genome --quantMode GeneCounts --sjdbGTFfile $gtfreference --readFilesIn $tmp1 $tmp2
        mv Aligned.out.sam ${C}.sam
        mv ReadsPerGene.out.tab ${C}_ReadsPerGene.tab
done

