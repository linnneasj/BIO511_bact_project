#!/bin/bash

#SBATCH -A C3SE408-25-2
#SBATCH -J kraken2_job
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=12 # Request 1 node with 12 CPUs
#SBATCH -t 01:00:00
#SBATCH --output=/cephyr/users/linneasj/Vera/bact_project2/logs/kraken2_%j.out  # Standard output
#SBATCH --error=/cephyr/users/linneasj/Vera/bact_project2/logs/kraken2_%j.err   # Standard error

# Set paths - ADJUST THESE TO YOUR ACTUAL PATHS
CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/singularity_images/kraken2.sif"
DB_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/ref_dbs/kraken2db"
DATA_PATH="/cephyr/users/linneasj/Vera/bact_project2/data"
RESULTS_PATH="/cephyr/users/linneasj/Vera/bact_project2"

# Bind paths for container
export SINGULARITY_BINDPATH="${DB_PATH}:/db,${DATA_PATH}:/data,${RESULTS_PATH}:/results"

# Create results directory
mkdir -p ${RESULTS_PATH}

# Identify sample
sample="sample_trimmed6"
echo "Processing sample: ${sample}"

# Run Kraken2 classification
srun singularity exec ${CONTAINER_PATH} kraken2 \
        --db /db \
        --threads 8 \
        --output /results/${sample}_kraken2_output.txt \
        --report /results/${sample}_kraken2_report.txt \
        --classified-out /results/${sample}_classified#.fastq \
        --unclassified-out /results/${sample}_unclassified#.fastq \
        /data/${sample}.fastq

echo "Completed classification for ${sample}"

echo "All samples processed successfully"