import sys
import string

print("load_seqs")
fh=file("GCA_003254725.1_ASM325472v1_genomic.fna")
sq={}
for line in fh.readlines():
	line=line.strip()
	if(len(line)>0 and line[0]==">"):
		cid=line[1:].split()[0]
		sq[cid]=[]
	else:
		sq[cid].append(line)
print("finished_load_seqs")

fh=file("Canis_lupus_dingo.ASM325472v1.98.gtf")
MAP={}
for line in fh.readlines():
	line=line.strip()
	vals=line.split("\t")
	if(len(vals)>2 and vals[2]=="exon"):
		c_id=line.split(" exon_id ")[1].split(";")[0].replace("\"","")
		MAP[c_id]=[vals[0],vals[3],vals[4],vals[6]]

for sq_ in sq:
	sq[sq_]=string.join(sq[sq_],"")

fw=file("exon_gc.txt","w")
for MAP_ in MAP:
	arr=MAP[MAP_]
	csq=sq[arr[0]]
	csq=csq[(int(arr[1])-1):int(arr[2])].upper()
	if(arr[3]=="-"):
		arr=[]
		for x in range(1,len(csq)):
			if(csq[x]=="A"):
				arr.append("T")
			elif(csq[x]=="G"):
				arr.append("C")
			elif(csq[x]=="C"):
				arr.append("G")
			elif(csq[x]=="T"):
				arr.append("A")
			elif(csq[x]=="N"):
				arr.append("N")
			else:
				print(csq[x])
				sys.exit()
		csq=string.join(arr,"")
	if((csq.count("N")/2+csq.count("C")+csq.count("G"))>0):
		gc=(100*(csq.count("N")/2+csq.count("C")+csq.count("G")))/len(csq)
	else:
		gc=0
	fw.write(MAP_+"\t"+str(gc)+"\n")
fw.close()

