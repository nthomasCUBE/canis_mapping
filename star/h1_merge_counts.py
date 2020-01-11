import string
import os
import sys


flattened=True
species="familaris"

if(species=="familaris"):
	my_file="Canis_familiaris.CanFam3.1.98.gtf"
elif(species=="dingo"):
	my_file="Canis_lupus_dingo.ASM325472v1.98.gtf"
else:
	print("species information missing")
	sys.exit()

if(flattened==True):
	main_dir="COUNT2"
else:
	main_dir="COUNT"

GC={}
try:
	fh=file("exon_gc.txt")
	for line in fh.readlines():
		line=line.strip()
		vals=line.split("\t")
		if(len(vals)>1):
			GC[vals[0]]=vals[1]
except Exception:
	print "no exon_gc.txt information exists"


fh=file(my_file)
C_L={}
G_MAP={}
for line in fh.readlines():
	line=line.strip()
	vals=line.split("\t")
	if(len(vals)>2 and vals[2]=="exon"):
		c_id=line.split(" exon_id ")[1].split(";")[0].replace("\"","")
                g_id=line.split("\tgene_id ")[1].split(";")[0].replace("\"","")
		c_l=int(vals[4])-int(vals[3])+1
		C_L[c_id]=c_l
		G_MAP[c_id]=g_id

files=os.listdir(main_dir)
MAP={}
ALL={}
for files_ in files:
	if(files_.find(".count")!=-1):
		fh=file(main_dir+"/"+files_)
		for line in fh.readlines():
			line=line.strip()
			vals=line.split("\t")
			if(vals[0][0:2]!="__"):
				if(MAP.get(vals[0])==None):
					MAP[vals[0]]={}
				MAP[vals[0]][files_]=vals[1]
				ALL[files_]=1

fw=file("h1_merge_counts_counts_flattened_%s.txt" % flattened,"w")
arr=["gene"]
for ALL_ in ALL:
	arr.append(ALL_)
fw.write(string.join(arr,"\t")+"\n")
for MAP_ in MAP:
	arr=[MAP_]
	for ALL_ in ALL:
		if(MAP[MAP_].get(ALL_)!=None):
			arr.append(MAP[MAP_][ALL_])
		else:
			arr.append(0)
	fw.write(string.join(arr,"\t")+"\n")
fw.close()

fw=file("h1_merge_counts_length_flattened_%s.txt" % flattened,"w")
fw.write("exon_id\tlength\tgene_id\tgc_cont\n")
for MAP_ in MAP:
	if(GC.get(MAP_)!=None):
		fw.write(MAP_+"\t"+str(C_L[MAP_])+"\t"+G_MAP[MAP_]+"\t"+GC[MAP_]+"\n")
	else:
                fw.write(MAP_+"\t"+str("-1")+"\t"+"-1"+"\t"+"-1"+"\n")
fw.close()



