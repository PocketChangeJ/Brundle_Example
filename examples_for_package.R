#Author: Andrew Holding

# The packages are found on GitHub as AndrewHolding/Brundle &
# AndrewHolding/BrundleData. They can be installed with
#
#install.packages("devtools")
#library(devtools)
#
#install_github("AndrewHolding/packagename")
#
#This script was used to generate the data for the examples in the Brundle man
#pages.
#
#save() points have been commented out to avoid writing unnecessary writing of
#files. Data() is loaded as in the example manpages but is not needed if script
#is run in order.
#
#The markdown in this directory will be move useful for most people.

library(Brundle)
library(BrundleData)

#Set for you installed location of BrundleData
setwd(system.file("extdata",package="BrundleData"))

### Examples for analysis using Diffbind and linear fit

#Set up the intial settings as normal
jg.controlMinOverlap      <- 5
jg.controlSampleSheet     <-
    system.file("extdata", "samplesheet_SLX14438_hs_CTCF_DBA.csv", package =
                    "Brundle")
jg.experimentSampleSheet  <-
    system.file("extdata", "samplesheet_SLX14438_hs_ER_DBA.csv", package =
                    "Brundle")
jg.treatedCondition       =  "Fulvestrant"
jg.untreatedCondition     =  "none"



#Load the data from the BAM files. These are only chr22 to reduce size. Still to
#big for the Bioconductor package size limit.
dbaExperiment <- jg.getDba(jg.experimentSampleSheet, bRemoveDuplicates=TRUE)
dbaControl    <- jg.getDba(jg.controlSampleSheet, bRemoveDuplicates=TRUE)

#Save the data for the examples in the package
#save(dbaExperiment, file="data/dbaExperiment.rda")

#Convert the DBA into a peakset we can manipulate

### Example for function jg.dbaGetPeakset
data(dbaExperiment, package="Brundle")
jg.experimentPeakset <- jg.dbaGetPeakset(dbaExperiment)
### Example finishes

#Repeat for the control samples/peaks & save for examples in package
jg.controlPeakset    <- jg.dbaGetPeakset(dbaControl)
#save(jg.controlPeakset, file="data/jg.controlPeakset.rda")

#Extract a maxtix of counts in peaks for each rep of a specific condition.
#Note in this example we specify the condition, but we could use the varible
#we assigned at the start.

### Example for function jg.getControlCounts
data(jg.controlPeakset, package="Brundle")
fpath <- system.file("extdata", "samplesheet_SLX14438_hs_CTCF_DBA.csv",package="Brundle")
jg.controlSampleSheet<-fpath
jg.controlCountsTreated<-jg.getControlCounts(jg.controlPeakset,
                                             jg.controlSampleSheet,
                                             "Fulvestrant")
### Example finishes

#Repeat for the untreated/control samples
jg.controlCountsUntreated<-jg.getControlCounts(jg.controlPeakset,
                                               jg.controlSampleSheet,
                                               jg.untreatedCondition)

#Get the sample names for replicates that represent the two conditions.
jg.untreatedNames <- names(jg.controlCountsUntreated)
jg.treatedNames   <- names(jg.controlCountsTreated)

#Save data for examples in package
#save(jg.controlCountsTreated, file="data/jg.controlCountsTreated.rda")
#save(jg.controlCountsUntreated, file="data/jg.controlCountsUntreated.rda")

#Plot of the normalisation, for visualisation only, not necessary for analysis.
### Example for jg.plotNormalization
data(jg.controlCountsTreated, package="Brundle")
data(jg.controlCountsUntreated, package="Brundle")
jg.plotNormalization(jg.controlCountsTreated,
                     jg.controlCountsUntreated)
## jg.plotNormalization finshes

#Calculate the noralisation coefficent
### Example of jg.getNormalizationCoefficient
data(jg.controlCountsTreated, package="Brundle")
data(jg.controlCountsUntreated, package="Brundle")
jg.coefficient<-jg.getNormalizationCoefficient(jg.controlCountsTreated,
                                               jg.controlCountsUntreated)
## jg.getNormalizationCoefficient example ends


#Calculates to correction factor for DiffBind, this currently doesn't have an
#example as it requires the Bam files.
jg.correctionFactor<-jg.getCorrectionFactor(jg.experimentSampleSheet,
                                            jg.treatedNames,
                                            jg.untreatedNames)

#Save data for examples in package
#save(jg.experimentPeakset, file="data/jg.experimentPeakset.rda")


#Apply the normalisation to the experimental peakset.
#As previously some varible have been replaced hard coded values for the
#example, these are jg.coefficient, jg.correctionFactor and sample names.
## Example of jg.applyNormalisation
data(jg.experimentPeakset, package="Brundle")
jg.experimentPeaksetNormalised<-jg.applyNormalisation(jg.experimentPeakset,
                                                      1.267618,
                                                      0.6616886,
                                                      c("1b", "2b", "3b"))
## end of example for jg.applyNormalisation


#Return values to Diffbind and plot normalised result.
jg.dba <- DiffBind:::pv.resetCounts(dbaExperiment,
                                    jg.experimentPeaksetNormalised)

#Plot the results of Chr22
dba.plotMA(dba.analyze(jg.dba),bSmooth=FALSE,bFlip = TRUE)

### End of DiffBind analysis

### Examples for analysis using DESeq size factors

#Get data in a format for DESeq

## Example of function jg.convertPeakset
data(dbaExperiment, package="Brundle")
jg.experimentPeakset <- jg.dbaGetPeakset(dbaExperiment)
jg.experimentPeaksetDeSeq<-jg.convertPeakset(jg.experimentPeakset)
## End of example for jg.convertPeakset

jg.controlPeakset    <- jg.dbaGetPeakset(dbaControl)
jg.controlPeaksetDeSeq<-jg.convertPeakset(jg.controlPeakset)

#save(jg.controlPeaksetDeSeq,file="data/jg.controlPeaksetDeSeq.rda")


#Get conditions dataframe for DeSeq2
jg.conditions <- read.csv(file=jg.controlSampleSheet, header=TRUE, sep=",")['Condition']
#save(jg.conditions,file="data/jg.conditions.rda")

# Run DeSeq on control
## Example of jg.runDeSeq
data(jg.controlPeaksetDeSeq,package="Brundle")
data(jg.conditions,package="Brundle")

# Establish size factors directly from Control data using DESeq2
jg.controlSizeFactors = estimateSizeFactorsForMatrix(jg.controlPeaksetDeSeq)

jg.controlDeSeq<-jg.runDeSeq(jg.controlPeaksetDeSeq, jg.conditions,jg.controlSizeFactors)
jg.controlResultsDeseq = results(jg.controlDeSeq)
## End of example for jg.runDeSeq

# Run DeSeq on experiment
jg.experimentDeSeq<-jg.runDeSeq(jg.experimentPeaksetDeSeq, jg.conditions,jg.controlSizeFactors)
jg.experimentResultsDeseq   = results(jg.experimentDeSeq)

#Save results for example plots
#save(jg.experimentResultsDeseq,file="data/jg.experimentResultsDeseq.rda")
#save(jg.controlResultsDeseq,file="data/jg.controlResultsDeseq.rda")


## Example of jg.plotDeSeq
data(jg.experimentResultsDeseq,package="Brundle")
jg.plotDeSeq(jg.experimentResultsDeseq,
             p=0.01,
             title.main="Fold-change in ER binding",
             flip=T
)
## End of Example for jg.plotDeSeq


#Draw Combined figure.
## Example of jg.plotDeSeqCombined
data(jg.controlResultsDeseq,package="Brundle")
data(jg.experimentResultsDeseq,package="Brundle")

jg.plotDeSeqCombined(jg.controlResultsDeseq,
                     jg.experimentResultsDeseq,
                     title.main="ER and CTCF Binding Folding changes on ER treatment",
                     p=0.01, flip=TRUE)
## End of Example for jg.plotDeSeqCombined

