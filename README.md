# Nextflow RNA-Seq Workflow

This is a simple workflow that takes as input paired end fastq reads and outputs a multiQC html file.

# Usage

To clone the pipeline, run the following command:
`git clone git@github.com:samuelschmakel/nextflow_rna_seq_workflow.git`

Next, to run the pipeline, use the `--reads` argument to specify the path to the data you'd like to use. 
The pipeline expects paired end fastq files that are numbered (i.e. example1.fq, example2.fq, etc.)
`nextflow run main.nf -profile local_pc --reads <path to reads file>`

Alternatively, you can use the `demo` profile to run the pipeline on a demo data set.
`nextflow run main.nf -profile local_pc,demo`
