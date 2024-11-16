#! /usr/bin/env nextflow

process MULTIQC {
    container "community.wave.seqera.io/library/multiqc:1.25.1--dc1968330462e945"
    conda "bioconda::multiqc=1.25.1"

    publishDir params.outdir, mode:'copy'

    input:
    path '*'

    output:
    path 'multiqc_report.html'

    script:
    """
    multiqc .
    """
 }