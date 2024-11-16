#! /usr/bin/env nextflow

log.info """\
    R N A S E Q - N F   P I P E L I N E
    ===================================
    transcriptome: ${params.transcriptome_file}
    reads        : ${params.reads}
    outdir       : ${params.outdir}
    """
    .stripIndent(true)

include {INDEX} from './modules/local/salmon/index/main.nf'
include {QUANTIFICATION} from './modules/local/salmon/quantification/main.nf'
include {FASTQC} from './modules/local/fastqc/main.nf'
include {MULTIQC} from './modules/local/multiqc/main.nf'

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