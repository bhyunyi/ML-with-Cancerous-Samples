#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --time=10:00:00
#SBATCH --mem=25GB
#SBATCH --job-name=nf_rnaseq_transcriptomics
#SBATCH --mail-type=FAIL
#SBATCH --account=pr_284_general
#SBATCH --mail-user=by2372@nyu.edu

module purge
module load nextflow/24.10.4

nextflow run nf-core/rnaseq -r 3.14.0 \
--input /scratch/by2372/Transcriptomics_Final_Project/nfcore_RNAseq/rnaseq_samplesheet_61_98.csv \
--outdir res \
--pseudo_aligner salmon \
--fasta /scratch/by2372/Transcriptomics_Final_Project/nfcore_RNAseq/hg38_ref/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz \
--gtf /scratch/by2372/Transcriptomics_Final_Project/nfcore_RNAseq/hg38_ref/Homo_sapiens.GRCh38.113.gtf.gz \
--extra_salmon_quant_args \"--gcBias\" \
-profile nyu_hpc \
--account=pr_284_general \
-c /scratch/by2372/Transcriptomics_Final_Project/nfcore_RNAseq/rnaseq.config \
-params-file /scratch/by2372/Transcriptomics_Final_Project/nfcore_RNAseq/rnaseq.json # note: we pass the JSON or YAML file in to nextflow here

module purge
