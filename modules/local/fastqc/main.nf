#! /usr/bin/env nextflow

process FASTQC {
    container "community.wave.seqera.io/library/fastqc:0.12.1--af7a5314d5015c29"
    conda "bioconda::fastqc=0.12.1"

    tag "FASTQC on $sample_id"

    input:
    tuple val(sample_id), path(reads)

    output:
    path "fastqc_${sample_id}_logs"

    script:
    """
    mkdir fastqc_${sample_id}_logs
    fastqc -o fastqc_${sample_id}_logs -f fastq -q ${reads}
    """ 
 }