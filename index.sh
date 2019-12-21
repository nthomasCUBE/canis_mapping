GENOME=GCA_003254725.1_ASM325472v1_genomic.fna

./STAR-2.7.3a/bin/Linux_x86_64/STAR --runMode genomeGenerate --genomeDir test/genome/ --genomeFastaFiles ${GENOME} --limitGenomeGenerateRAM 16000000000
