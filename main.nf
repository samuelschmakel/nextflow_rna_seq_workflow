#! /usr/bin/env nextflow

log.info """\
    R N A S E Q - N F   P I P E L I N E
    ===================================
    transcriptome: ${params.transcriptome_file}
    reads        : ${params.reads}
    outdir       : ${params.outdir}
    """
    .stripIndent(true)

/*
 * define the 'INDEX' process that creates a binary index given the transcriptome file
 */
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

 workflow {
    Channel.fromFilePairs(params.reads, checkIfExists: true).set { read_pairs_ch }

    index_ch = INDEX(params.transcriptome_file)
    quant_ch = QUANTIFICATION(index_ch, read_pairs_ch)
    fastqc_ch = FASTQC(read_pairs_ch)
    MULTIQC(quant_ch.mix(fastqc_ch).collect())
 }

 workflow.onComplete {
    log.info (workflow.success ? "\n Finished! Output report: $params.outdir/multiqc_report.html\n" : "Oops .. something went wrong")
 }