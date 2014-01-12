import sys
import os
import random
#################################################################
# Feature Painter by Beherith (mysterme@gmail.com)
# Place large amounts of random features in patches defined by an image
# Usage:
# Add the kinds of features you want placed per color channel to the lists below
# reds, greens, blues, alpha
# Paint an image, the same size as your feature map, with the colors on where you want the features
# Edit the filename and mapXsize parameters to your stuff
# Save your feature image as a .raw file (interlaced, with 1 channel alpha)
#



filename="trees.raw"
mapXsize=1280

reds =([])
for size in ['_m','_l','_xl','_xxl']:
	for types in ['_1','_2','_3']:
		reds.append('ad0_pine'+types+size)
pr = 0.03

greens = ([] )
pg=0.002

blues =([])

pb =0.02

alpha=([])
pa=0.00



file=open(filename,'rb')
out=open("featurepainter_export.txt",'w')

chn=4
i=0
random.seed()
cnt=0
while (1==1):
	ch=file.read(1)
	if len(ch)==0:
		break
	n=ord(ch[0])
	fname=""
	if n!=0:
		# print i
		n=float(n)
		if i%chn==0: #reds
			if random.random()<pr*n/255.0:
				fname=random.choice(reds)
				
		if i%chn==1: #greens
			if random.random()<pg*n/255.0:
				fname=random.choice(greens)
				
		if i%chn==2: #blues
			if random.random()<pb*n/255.0:
				fname=random.choice(blues)
				
		if i%chn==3: #alpha
			if random.random()<pa*n/255.0:
				fname=random.choice(alpha)

	if fname!="":
		outstr=('{ name = \''+fname+'\', x = '+str(((i/chn)%mapXsize)*8+4)+', z = '+str(((i/chn)/mapXsize)*8+4)+', rot = \"'+str(-1)+'\" },\n')
		out.write(outstr)
		print cnt,':',outstr
		cnt+=1
		
		
	i+=1
print 'total:',cnt,'out of ',i,'pixels'
out.close()
file.close()