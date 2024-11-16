# **Nextflow RNA-Seq Workflow**

This repository contains a simple RNA-Seq analysis workflow designed to process paired-end FASTQ files and generate a MultiQC report. The pipeline is implemented using [Nextflow](https://www.nextflow.io/) for robust and reproducible data analysis.

---

## **Features**
- Supports paired-end FASTQ files as input.
- Performs alignment using Salmon, quantification, and FASTQC.
- Generates a comprehensive [MultiQC](https://multiqc.info/) HTML report.

---

## **Requirements**
To run this workflow, ensure the following software is installed:
- [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) (v22.04.0 or later)
- [Conda](https://docs.conda.io/en/latest/) (if using `-profile conda`) or [Docker](https://www.docker.com/) (if using `-profile docker`).

---

## **Installation**

1. Clone the repository:
   ```bash
   git clone git@github.com:samuelschmakel/nextflow_rna_seq_workflow.git
   cd nextflow_rna_seq_workflow

2. Ensure Nextflow is correctly installed and available in your `$PATH`:
   ```bash
   nextflow -version

## **Usage**

**1. Running the pipeline with custom data:

    ```bash
    nextflow run main.nf -profile local_pc --reads "<path_to_reads>"

- **Input Requirement**: The pipeline expects paired-end FASTQ files named with a numbering scheme (e.g., `example1.fq`, `example2.fq`).
- Replace <path_to_reads> with the path to your FASTQ files.

**2. Running the pipeline with demo data:
To test the pipeline using the included demo dataset, use the demo profile:

    ```bash
    nextflow run main.nf -profile local_pc,demo

## **Output** ##
The pipeline generates a MultiQC HTML report summarizing the analysis.

## **Profiles**

## **Customization**
You can adjust parameters directly in the nextflow.config file or override them in the command line. For example:

    ```bash
    nextflow run main.nf --outdir custom_results --threads 8

## **Support**
For questions, issues, or feature requests, feel free to open an issue.
