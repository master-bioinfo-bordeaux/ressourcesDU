#!bin/bash


# Create directories
mkdir -p data/zmays-snps/data/seqs/
mkdir -p data/zmays-snps/analysis/ data/zmays-snps/scripts/
mkdir -p data/fasta/

# Create fastq files
touch data/zmays-snps/data/seqs/zmaysA_R1.fastq
touch data/zmays-snps/data/seqs/zmaysA_R2.fastq
touch data/zmays-snps/data/seqs/zmaysB_R1.fastq
touch data/zmays-snps/data/seqs/zmaysB_R2.fastq
touch data/zmays-snps/data/seqs/zmaysC_R1.fastq
touch data/zmays-snps/data/seqs/zmaysC_R2.fastq

printf ">seq1\nACGT\n>qes2\nCCCA\n>esq3\nATATAT" > data/fasta/multi.fasta
printf ">INS_HUMAN\nMALWMRLLPLLALLALWGPDPAAAFVNQHLCGSHL\nVEALYLVCGERGFFYTPKTRREAEDLQVGQVELGG\nGPGAGSLQPLALEGSLQKRGIVEQCCTSICSLYQL\nENYCN" > data/fasta/insulin.fasta
