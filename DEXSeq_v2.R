library(DEXSeq)

options(stringsAsFactors=FALSE)

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
	sampleTable=data.frame(
		condition=sampleDataArr,
		row.names=colnames(countData),
		libType=rep("paired-end",length(dim(countData)[2])))
        design <- formula( ~ sample + exon + condition:exon )
        d=read.csv("h1_merge_counts_length.txt",sep="\t",header=T)
	groupID=d[,3]
	featureID=d[,1]

        arr=list()
        arr[[1]]=countData
        arr[[2]]=sampleTable
        arr[[3]]=design
        arr[[4]]=groupID
        arr[[5]]=featureID
	return(arr)
}

#	---------------------------------------------------

#arr=set_default()
arr=set_real_data()

countData=arr[[1]]
sampleTable=arr[[2]]
design=arr[[3]]
groupID=arr[[4]]
featureID=arr[[5]]

countFiles = list.files("COUNT", pattern="*.count$", full.names=TRUE)
flattenedFile="Canis_lupus_dingo.ASM325472v1.98_flattened.gff3"

BPPARAM <- MulticoreParam(workers = 10)

print("1")
print(countFiles)
print(sampleTable)
print(flattenedFile)

DEXSeqDataSet = DEXSeqDataSetFromHTSeq(
   countFiles,
   sampleData=sampleTable,
   design= ~ sample + exon + condition:exon,
   flattenedfile=flattenedFile )

#DEXSeqDataSet=DEXSeqDataSet( countData, sampleData, design,featureID, groupID )
print("2")
DEXSeqDataSet <- DEXSeq::estimateSizeFactors(DEXSeqDataSet)
print("3")
DEXSeqDataSet <- DEXSeq::estimateDispersions(DEXSeqDataSet, BPPARAM = BPPARAM)
print("4")
DEXSeqDataSet <- DEXSeq::testForDEU(DEXSeqDataSet, BPPARAM = BPPARAM)
print("5")
DEXSeqDataSet <- DEXSeq::estimateExonFoldChanges(DEXSeqDataSet, BPPARAM = BPPARAM)
print("6")
results <- DEXSeq::DEXSeqResults(DEXSeqDataSet)
print(results)

#save.image("DEXSeq.RData")

#       ---------------------------------------------------

