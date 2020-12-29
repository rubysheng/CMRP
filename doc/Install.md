# Installing the CMRP
================================

Installing the Comparative Meta RNA-Seq Data Standardized Analysis Pipeline (CMRP) can be accomplished by downloading the code with the following command and then following the steps below.

	$ git clone https://github.com/rubysheng/CMRP.git

Step 1: Perl Dependencies
-------------------------

The OrthoMCL Pipeline requires Perl as well as the following Perl modules.
## Requirement

- "ascp"
- "fastqc"
- "multiqc"
- "trim_galore"
- "trinity"
  + bowtie2
  + jellyfish
  + salmon
  + samtools
  + rsem-calculate-expression
- "transdecoder"
- "trinotate"
  + blastx
- "Orthomcl-pipeline"

Download manually. Errors may occur while running software included in CMRP due to using different version of software. If this happens then please check the [method] (https://github.com/rubysheng/CMRP/blob/bombina/script/section1.2_checksoftware.sh) that the developers used to download the specific version of software.
