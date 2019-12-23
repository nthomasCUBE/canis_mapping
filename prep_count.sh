rm -r COUNT2
mkdir COUNT2

for FILE in $(ls SAM/*)
do
	echo $FILE
	BN=$(basename $FILE)
	python DEXSeq-master/inst/python_scripts/dexseq_count.py --paired yes Canis_lupus_dingo.ASM325472v1.98_flattened.gff3 ${FILE} COUNT2/${BN}.count
done

