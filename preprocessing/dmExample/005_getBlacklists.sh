mkdir blacklists
cd ./blacklists
# Human hg19/GRCh37
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeMapability/wgEncodeDacMapabilityConsensusExcludable.bed.gz --no-check-certificate  
gunzip wgEncodeDacMapabilityConsensusExcludable.bed.gz
mv wgEncodeDacMapabilityConsensusExcludable.bed hg19-blacklist.bed

# Drosophila dm3
wget http://www.broadinstitute.org/~anshul/projects/fly/blacklist/dm3-blacklist.bed.gz --no-check-certificate  
gunzip dm3-blacklist.bed.gz

### Generate a merged Drosophila/Human blacklist
droso=./dm3-blacklist.bed
homo=./hg19-blacklist.bed

sed "s/^/hs_/" $homo |cut -f1-3 > tmp
sed "s/^/dm_/" $droso > tmp2
cat tmp tmp2 > dmhs-blacklist.bed
rm tmp tmp2


