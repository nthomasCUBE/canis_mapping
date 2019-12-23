library(cqn)

options(stringsAsFactors=FALSE)
options(digits=2)

L=read.csv("h1_merge_counts_length.txt",sep="\t",header=T)

Data <- as.matrix(read.table("h1_merge_counts_counts.txt",sep="\t",header=TRUE,row.names=1, check.names=F))

my_x=L[,4]

cqn.subset <- cqn(Data,x=my_x,lengths=L[,2])
cqn_norm=cqn.subset$y+cqn.subset$offset
write.table(cqn_norm,"cqn_23dec19.txt",sep="\t",quote=F)
write.table(cqn.subset$y,"cqn_no_offset_23dec19.txt",sep="\t",quote=F)

