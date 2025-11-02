#!/bin/bash
#SBATCH -A C3SE408-25-2
#SBATCH -J quast_analysis
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=4
#SBATCH -t 01:00:00
#SBATCH --output=/cephyr/users/linneasj/Vera/bact_project2/logs/quast_%j.out
#SBATCH --error=/cephyr/users/linneasj/Vera/bact_project2/logs/quast_%j.err

CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/singularity_images/quast.sif"

DATA_PATH="/cephyr/users/linneasj/Vera/bact_project2/data"
RESULTS_PATH="/cephyr/users/linneasj/Vera/bact_project2/quast_output"
OUTPUT_DIR="${RESULTS_PATH}/results/quast_results"

# Create necessary directories
mkdir -p ${OUTPUT_DIR}

# Bind input and output
export SINGULARITY_BINDPATH="${DATA_PATH}:/data,${OUTPUT_DIR}:/output"

# Run QUAST
singularity exec ${CONTAINER_PATH} quast.py \
    -o /output \
    --threads 4 \
    --plots-format png \
    --labels "Polished" \
    /data/assembly.fasta

echo "QUAST analysis completed"