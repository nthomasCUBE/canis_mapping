rm -r COUNT2
mkdir COUNT2

GENOME=$1

if [ $GENOME == "familaris" ]
then
        for FILE in $(ls canis/SAM/*)
        do
                echo $FILE
                BN=$(basename $FILE)
                python DEXSeq-master/inst/python_scripts/dexseq_count.py --paired yes Canis_familiaris.CanFam3.1.98.flattened.gff3 ${FILE} COUNT2/${BN}.count
        done
elif [ $GENOME == "dingo" ]
then
        for FILE in $(ls SAM/*)
        do
                echo $FILE
                BN=$(basename $FILE)
                python DEXSeq-master/inst/python_scripts/dexseq_count.py --paired yes Canis_lupus_dingo.ASM325472v1.98_flattened.gff3 ${FILE} COUNT2/${BN}.count
        done
fi




