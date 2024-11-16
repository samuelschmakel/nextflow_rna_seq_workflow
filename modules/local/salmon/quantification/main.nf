#! /usr/bin/env nextflow

process QUANTIFICATION {

    container "community.wave.seqera.io/library/salmon:1.10.3--fcd0755dd8abb423"
    conda "bioconda::salmon=1.10.3"

    input:
    path salmon_index
    tuple val(sample_id), path(reads)

    output:
    path "$sample_id"

    script:
    """
    salmon quant --threads $task.cpus --libType=U -i $salmon_index -1 ${reads[0]} -2 ${reads[1]} -o $sample_id
    """
 }