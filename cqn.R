library(EDASeq)
library(cqn)

options(stringsAsFactors=FALSE)

L=read.csv("h1_merge_counts_length.txt",sep="\t",header=T)

Data <- as.matrix(read.table("h1_merge_counts_counts.txt",sep="\t",header=TRUE,row.names=1, check.names=F))

my_x=rep(1,dim(Data)[1])
my_x=sample(50:80,length(my_x),replace=TRUE)

cqn.subset <- cqn(Data,x=my_x,lengths=L[,2])
RPKM.cqn=cqn.subset$y+cqn.subset$offset


