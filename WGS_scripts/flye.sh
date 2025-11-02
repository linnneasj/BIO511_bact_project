#!/bin/bash
#SBATCH -A C3SE408-25-2
#SBATCH -J flye_polished
#SBATCH -p vera  
#SBATCH -N 1 --cpus-per-task=12
#SBATCH -t 02:30:00
#SBATCH --output=/cephyr/users/linneasj/Vera/bact_project2/logs/flye_polished_%j.out
#SBATCH --error=/cephyr/users/linneasj/Vera/bact_project2/logs/flye_polished_%j.err

# Set paths - ADJUST THESE TO YOUR ACTUAL PATHS  
DATA_PATH="/cephyr/users/linneasj/Vera/bact_project2/data"
RESULTS_PATH="/cephyr/users/linneasj/Vera/bact_project2"
SINGULARITY_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/singularity_images/flye.sif"

# Set bind paths for Singularity
export SINGULARITY_BINDPATH="${DATA_PATH}:/data,${RESULTS_PATH}:/results"

# Set sample and output paths
ONT_READS="${DATA_PATH}/sample_trimmed6.fastq"
OUTPUT_DIR="${RESULTS_PATH}/flye_output" 

# Create output directories
mkdir -p ${OUTPUT_DIR}

# Run Flye assembly with enhanced polishing
singularity exec ${SINGULARITY_PATH} flye --nano-raw /data/sample_trimmed6.fastq \
     --out-dir /results/flye_output \
     --threads 12 \
     --iterations 5 

echo "Polished ONT assembly completed"