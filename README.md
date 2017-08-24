# Brundle_Example

This repository contains two example workflows to demonstrated how to normalise ChIP-seq data using the [Brundle R-package](https://github.com/andrewholding/Brundle). Before trying these examples you should first familiarise yourself with [DiffBind](https://bioconductor.org/packages/release/bioc/html/DiffBind.html)
and it's own examples as it forms the basis of the analysis.

The following examples are also avalible as a Docker container from [Brundle on Docker Hub](https://hub.docker.com/r/andrewholding/brundle/), the container contains all the packages pre-installed and with all the tools needed for the preprocessing workflow. Instructions for [running the container are below](https://github.com/andrewholding/Brundle_Example/blob/master/README.md#using-docker-container).

## Contents

**[ctcfExample.Rmd](https://github.com/andrewholding/Brundle_Example/blob/master/ctcfExample.Rmd?raw=true)** provides a complete workflow using data that was 
generated with an internal CTCF based control. (Bright pink on figure).

![CTCF Workflow](https://cdn.rawgit.com/andrewholding/Brundle_Example/master/images/workflow_ctcf.svg?raw=true)

**[dmExample.Rmd](https://github.com/andrewholding/Brundle_Example/blob/master/dmExample.Rmd)** shows a similar workflow for data with a spike-in control. (Light blue on figure).


![Dm Workflow](https://cdn.rawgit.com/andrewholding/Brundle_Example/master/images/workflow_dm.svg)

The **Preprocessing** folder contains examples of how to preprocess the samples. This includes
the pipleline to align reads to merged human-drosophila genome and how to split ER and CTCF peaks.
Both examples include sample input data to test the preprocessing. These are the segments highlighted 
in dark pink or dark blue on the relivant workflow. 

Examples_for_package.R is only provided for reference and was used to provide the R data files (.rda) for the
man page examples in the Brundle package.

## Using Docker Container

Docker provides a reproducible way of executing the same code. In the container for Brundle are all the packages
and tools needed to run the pipleline are pre-installed. Below is a quick summary on how to run the container.

First install “Docker Toolbox” [https://www.docker.com/products/docker-toolbox], then run the “Docker Quickstart Terminal”.

![BrundleDocker](https://cdn.rawgit.com/andrewholding/Brundle_Example/master/images/BrundleDocker.svg?raw=true)


1)	When the terminal loads note the IP address reported in the terminal.
2)	Run the container with `docker run –d –p 8787:8787  andrewholding/brundle`.
3)	In a web browser go to the http://<ip-address>:8787. Where <ip-address> is the one we noted earlier.
4)	This will open a copy of Rstudio running in the container (username: rstudio, password: rstudio).
5)	Click the ‘Knitr’ button.
6)	The analysis will run and output the report in a new window (warning: this may be blocked by popup blockers).

The docker container also contains all the tools needed to run the pre-processing. When you started the container you should also get container id (not shown). Using the following command will provide an interactive terminal.

`docker exec -it <container> bash`

The scripts you need are in “~/preprocessing”.

To stop the container from the same terminal run

`docker stop <container>`

