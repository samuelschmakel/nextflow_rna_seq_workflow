#! /usr/bin/env nextflow

process INDEX {

    container "community.wave.seqera.io/library/salmon:1.10.3--fcd0755dd8abb423"
    conda "bioconda::salmon=1.10.3"

    input:
    path transcriptome

    output:
    path 'salmon_index'

    script:
    """
    salmon index --threads $task.cpus -t $transcriptome -i salmon_index
    """
 }