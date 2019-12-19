library(edgeR)

x <- read.delim("h1_merge_counts.tab", stringsAsFactors=FALSE)
group <- 2:dim(x)[2]
genes <- x[,1]

my_g=x[,2:dim(x)[2]]
rownames(my_g)=x[,1]
y <- DGEList(counts=my_g, group=group, genes=genes)
y <- calcNormFactors(y, method="TMM")
write.table(cpm(y),"normalize_19dec19.tab",sep="\t",quote=FALSE)
y <- estimateCommonDisp(y)


