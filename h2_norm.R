library(edgeR)

x = read.delim("h1_merge_counts_counts_flattened_True.txt", stringsAsFactors=FALSE)
group <- 2:dim(x)[2]
genes <- x[,1]

x2 = read.csv("h1_merge_counts_length_flattened_True.txt",sep="\t")

my_g=x[,2:dim(x)[2]]
rownames(my_g)=x[,1]
y <- DGEList(counts=my_g, group=group, genes=genes)
y$genes$Length=x2[,2]
mycounts <- rpkm(y)

write.table(mycounts, file = "rpkm_20dec19.txt", dec = ".", sep = "\t", quote = FALSE)


