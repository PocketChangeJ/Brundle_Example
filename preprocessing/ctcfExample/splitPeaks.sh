#This script was run in a directory containing the output 
#from macs2 (ie. peak files) for all of BAM files.

#Merge the peaks called by macs2 on the aligned reads for two
#CTCF ChIP-seq experiments. One is untreated and one is treated 
#with fulvestrant.


cat SLX-14229.D701_D504.HJJL7BBXX.s_8.r_1.fq.gz_peaks.xls   \
SLX-14229.D702_D503.HJJL7BBXX.s_8.r_1.fq.gz_peaks.xls > CTCF_merged.bed
    
#Remove comments from start of macs2 peak file because we have two copies.
#One from each of the merged files.
grep -v \# CTCF_merged.bed  | grep -v start > CTCF_merged_filtered.bed

#Sort the bed
sort -k1,1 -k2,2n CTCF_merged_filtered.bed > CTCF_merged_sorted_filtered.bed

#Make a union of any overlapping peak. This removes duplicates from peaks
#called in both experiemnts.
bedtools merge -i CTCF_merged_sorted_filtered.bed  >CTCF_union.bed

#Now we have a CTCF set of concensus peaks from our two experiements 
#we use them to filter our peak files for each of the other samples.

mkdir CTCF

for f in *.narrowPeak
do
	echo $f
	bedtools intersect -a $f -b CTCF_union.bed  > CTCF/$f 
done

mkdir ER
for f in *.narrowPeak
do
	echo $f
	bedtools subtract -b CTCF_union.bed -a $f -A > ER/$f 
done

