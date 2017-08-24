# Brundle_Example

Two example workflows to demonstrated how to normalise ChIP-seq data using the [Brundle R-package](https://github.com/andrewholding/Brundle).

**ctcfExample.Rmd** provides a complete workflow using data that was 
generated with an internal CTCF based control. (Bright pink on figure).

![CTCF Workflow](/images/brundle_workflow_ctcf.png?raw=true)

**dmExample.Rmd** shows a similar workflow for data with a spike-in control. (Dark blue on figure).


![Dm Workflow](/images/brundle_workflow_dm.png?raw=true)

**Preprocessing** contains examples of how to preprocess the samples. This includes
the pipleline to align reads a merged human-drosophila genome. Both examples
include sample input data to test the preprocessing. These are the segments highlighted 
in dark pink or light blue on the relivant workflow. 

Brundle can be found at https://github.com/andrewholding/Brundle

Examples_for_package.R was used to provide the R data files (.rda) for the
man page examples in the Brundle package.

