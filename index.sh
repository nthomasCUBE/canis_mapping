GENOME=$1

if [ $GENOME == "familaris" ]
then
        echo "familaris"
        GENOME=Canis_familiaris.CanFam3.1.dna_sm.toplevel.fa
elif [ $GENOME == "dingo" ]
then
        echo "dingo"
        GENOME=GCA_003254725.1_ASM325472v1_genomic.fna
fi

if [ $1 == "familaris" ] || [ $1 == "dingo" ]
then
        echo "Mapping"
        ../canis/STAR-2.7.3a/bin/Linux_x86_64/STAR --runMode genomeGenerate --genomeDir index --genomeFastaFiles ${GENOME} --limitGenomeGenerateRAM 16000000000
fi





