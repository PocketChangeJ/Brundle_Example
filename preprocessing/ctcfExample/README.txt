This folder contains an example how to split CTCF and ER peaks when using CTCF
binding to provide an internal standard. The files in the directory were
called against the aligned reads with macs2 using default settings.

The script splitPeaks.sh generates a consensus from the two CTCF (one treated 
and one untreated) samples that did not include the ER antibody in the 
pulldown step. Next, the script uses bedtools to filter the peaks into ER or
CTCF binding sites and stores them in the ER and CTCF subdirectory.


