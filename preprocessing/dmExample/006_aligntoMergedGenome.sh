### Align, Sort and Build indeces

#For some reason bowtie2 on my mac doens't like these gzipped
#but is fine when I use my copy on the cluster.
#To ensure it works for everyone, and given that they
#are small I just gunzip them for now.

cd ./dmhsReads
gunzip *
cd ..


mkdir ./alignedReads
cd ./alignedReads
genome=../genomes/dmhs/dmhs
for fq in ../dmhsReads/*fq
do
	echo $fq
	root=`basename $fq`
	bowtie2  -x $genome -U $fq > tmp.sam \
	&& samtools view -Sbh tmp.sam > tmp.bam \
	&& samtools sort tmp.bam > ${root}.bam  \
	&& samtools index ${root}.bam
done
rm tmp.sam tmp.bam

cd ..
cd ./dmhsReads
gzip *
cd ..

