#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --time=10:00:00
#SBATCH --mem=25GB
#SBATCH --job-name=get_SRAID_fastqs
#SBATCH --account=pr_284_general
#SBATCH --mail-user=by2372@nyu.edu

module purge
module load sra-tools/3.1.0

cd /scratch/by2372/Transcriptomics_Final_Project/SRA_files/

while read sra_id; do
    mkdir ${sra_id}
    prefetch "$sra_id" --output-directory /scratch/by2372/Transcriptomics_Final_Project/SRA_files/${sra_id}/
    fasterq-dump "$sra_id" \
        --outdir /scratch/by2372/Transcriptomics_Final_Project/SRA_files/${sra_id} \
        --threads 7
        
    pigz -p 7 /scratch/by2372/Transcriptomics_Final_Project/SRA_files/${sra_id}/*_1.fastq
    pigz -p 7 /scratch/by2372/Transcriptomics_Final_Project/SRA_files/${sra_id}/*_2.fastq
done < /scratch/by2372/Transcriptomics_Final_Project/SRA_files/SRA_IDs_3.txt


module purge

