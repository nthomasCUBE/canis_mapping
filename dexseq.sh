library(DEXSeq)

options(stringsAsFactors=FALSE)

#	---------------------------------------------------
#
#	Set default values to test the package
#
#	---------------------------------------------------
set_default=function(){
	countData <- matrix( rpois(10000, 100), nrow=1000 )
	sampleData <- data.frame(
		condition=rep( c("untreated", "treated"), each=5 ) )
	design <- formula( ~ sample + exon + condition:exon )
	groupID <- rep(
		       paste0("gene", 1:10),
		       each= 100 )
	featureID <- rep(
		       paste0("exon", 1:100),
		       times= 10 )
	arr=list()
	arr[[1]]=countData
	arr[[2]]=sampleData
	arr[[3]]=design
	arr[[4]]=groupID
	arr[[5]]=featureID

	return(arr)
}

#       ---------------------------------------------------
#
#	Setting real values from the current experiment
#
#       ---------------------------------------------------
set_real_data=function(){

	NAMES=list()
	NAMES["L7_RX_CGATGT_OSCA_8_10M.fastq.count"]="T"
	NAMES["Bella_C_AGTCAA_L007_RX_20M.fastq.count"]="T"
	NAMES["L6_RX_GGCTAC_OSCA_32_Mono_Bone_10M.fastq.count"]="C"
	NAMES["Gus_N_CTTGTA_L007_RX_20M.fastq.count"]="T"
	NAMES["OSCA_30_cells_ACTTGA_L006_RX_20M.fastq.count"]="C"
	NAMES["OSCA_78_cells_CAGATC_L006_RX_20M.fastq.count"]="C"
	NAMES["X1033_ACAGTG_L006_RX_20M.fastq.count"]="T"
	NAMES["L7_RX_ATCACG_OSCA_73_Tissue_10M.fastq.count"]="T"
	NAMES["X440_TGACCA_L006_RX_20M.fastq.count"]="T"
	NAMES["Oso_D_GGCTAC_L007_RX_20M.fastq.count"]="T"
	NAMES["X320_TTAGGC_L006_RX_20M.fastq.count"]="T"
	NAMES["L6_RX_ACTTGA_OSCA_8_Mono_Bone_10M.fastq.count"]="C"
	NAMES["X1091_GCCAAT_L006_RX_20M.fastq.count"]="T"
	NAMES["Osca_40_cells_GATCAG_L007_RX_20M.fastq.count"]="C"
	NAMES["L7_RX_CTTGTA_OSCA_71_Tissue_10M.fastq.count"]="T"

	countData=read.csv("h1_merge_counts_counts.txt",sep="\t",header=T,row.names=1)
	sampleDataArr=c()
	for(i in 1:dim(countData)[2]){
		sampleDataArr=c(sampleDataArr,NAMES[colnames(countData)][i][[1]])
	}
	print(sampleDataArr)
	sampleData=data.frame(condition=sampleDataArr)
        design <- formula( ~ sample + exon + condition:exon )
        d=read.csv("h1_merge_counts_length.txt",sep="\t",header=T)
	groupID=d[,3]
	featureID=d[,1]

        arr=list()
        arr[[1]]=countData
        arr[[2]]=sampleData
        arr[[3]]=design
        arr[[4]]=groupID
        arr[[5]]=featureID
	return(arr)
}

#	---------------------------------------------------

#arr=set_default()
arr=set_real_data()

countData=arr[[1]]
sampleData=arr[[2]]
design=arr[[3]]
groupID=arr[[4]]
featureID=arr[[5]]

BPPARAM <- MulticoreParam(workers = 10)

DEXSeqDataSet=DEXSeqDataSet( countData, sampleData, design,featureID, groupID )
DEXSeqDataSet <- DEXSeq::estimateSizeFactors(DEXSeqDataSet)
DEXSeqDataSet <- DEXSeq::estimateDispersions(DEXSeqDataSet, BPPARAM = BPPARAM)
DEXSeqDataSet <- DEXSeq::testForDEU(DEXSeqDataSet, BPPARAM = BPPARAM)
DEXSeqDataSet <- DEXSeq::estimateExonFoldChanges(DEXSeqDataSet, BPPARAM = BPPARAM)
results <- DEXSeq::DEXSeqResults(DEXSeqDataSet)
print(results)

save.image("DEXSeq.RData")

#       ---------------------------------------------------

