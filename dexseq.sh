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
	countData=read.csv("h1_merge_counts_counts.txt",sep="\t",header=T,row.names=1)
	sampleData=data.frame(condition=c(rep("treated",7),rep("untreated",8)))
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

