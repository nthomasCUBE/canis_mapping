options(stringsAsFactors=FALSE)

data=read.csv("rpkm_20dec19.txt",sep="\t",header=T)

NAMES=list()
NAMES["L7_RX_CGATGT_OSCA_8_10M.fastq.sam.count"]="T"
NAMES["Bella_C_AGTCAA_L007_RX_20M.fastq.sam.count"]="T"
NAMES["L6_RX_GGCTAC_OSCA_32_Mono_Bone_10M.fastq.sam.count"]="C"
NAMES["Gus_N_CTTGTA_L007_RX_20M.fastq.sam.count"]="T"
NAMES["OSCA_30_cells_ACTTGA_L006_RX_20M.fastq.sam.count"]="C"
NAMES["OSCA_78_cells_CAGATC_L006_RX_20M.fastq.sam.count"]="C"
NAMES["X1033_ACAGTG_L006_RX_20M.fastq.sam.count"]="T"
NAMES["L7_RX_ATCACG_OSCA_73_Tissue_10M.fastq.sam.count"]="T"
NAMES["X440_TGACCA_L006_RX_20M.fastq.sam.count"]="T"
NAMES["Oso_D_GGCTAC_L007_RX_20M.fastq.sam.count"]="T"
NAMES["X320_TTAGGC_L006_RX_20M.fastq.sam.count"]="T"
NAMES["L6_RX_ACTTGA_OSCA_8_Mono_Bone_10M.fastq.sam.count"]="C"
NAMES["X1091_GCCAAT_L006_RX_20M.fastq.sam.count"]="T"
NAMES["Osca_40_cells_GATCAG_L007_RX_20M.fastq.sam.count"]="C"
NAMES["L7_RX_CTTGTA_OSCA_71_Tissue_10M.fastq.sam.count"]="T"

cn=(unlist(NAMES[colnames(data)]))
cnT=which(cn=="T")
cnC=which(cn=="C")

cnT=as.vector(cnT)
cnC=as.vector(cnC)

A=c(); B=c(); C=c(); D=c(); E=c(); F=c();

for(x in 1:dim(data)[1]){
#for(x in 1:10){
	c1=data[x,cnT]
	c2=data[x,cnC]
	c1=as.vector(unlist(c1))
	c2=as.vector(unlist(c2))
        D=c(D,mean(c1))
        E=c(E,mean(c2))
        F=c(F,sd(c(c1,c2))/mean(c(c1,c2)))
	c1=sd(c1)/mean(c1)
	c2=sd(c2)/mean(c2)
	A=c(A,rownames(data)[x])
	B=c(B,c1)
	C=c(C,c2)
}
df=data.frame(A,B,C,D,E,F)
colnames(df)=c("entity_id","T_cov","C_cov","T_mean","C_mean","CT_cov")
write.table(df,"h3_cov.txt")
