#!/bin/bash
#SBATCH -A C3SE408-25-2 
#SBATCH -J prokka_baseline
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=8
#SBATCH -t 01:00:00
#SBATCH --output=/cephyr/users/linneasj/Vera/bact_project2/logs/prokka_baseline_%j.out # output log, adjust path to where you want to save logs
#SBATCH --error=/cephyr/users/linneasj/Vera/bact_project2/logs/prokka_baseline_%j.err # error log, adjust path to where you want to save logs

# Set paths - ADJUST THESE TO YOUR ACTUAL PATHS
CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/singularity_images/prokka.sif"
RESULTS_PATH="/cephyr/users/linneasj/Vera/bact_project2/prokka_output"
ASSEMBLIES_DIR="/cephyr/users/linneasj/Vera/bact_project2/data"
OUTPUT_DIR="${RESULTS_PATH}/annotation/prokka_baseline"

# Bind paths for container
export SINGULARITY_BINDPATH="${ASSEMBLIES_DIR}:/data,${RESULTS_PATH}:/results"

# Create output directories
# If needed: mkdir -p ${RESULTS_PATH}
mkdir -p ${OUTPUT_DIR}

# Input assembly
ASSEMBLY="/data/assembly.fasta"

# Set a prefix variable for naming outputs
PREFIX="$(basename ${ASSEMBLY} .fa)_baseline"

# Run Prokka (baseline)
singularity exec ${CONTAINER_PATH} prokka \
  --cpus 8 \
  --outdir /results/annotation/prokka_baseline \
  --prefix ${PREFIX} \
  --locustag BIO511 \
  --genus Corynebacterium \
  --species neomassiliense \
  --force \
  ${ASSEMBLY}

echo "Baseline Prokka annotation completed"