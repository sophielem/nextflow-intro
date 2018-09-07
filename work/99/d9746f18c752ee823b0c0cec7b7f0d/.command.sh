#!/bin/bash -ue
bowtie2 -q -1 ERR036019samp_1.fastq.gz -2 ERR036019samp_2.fastq.gz -x /home/sdv/m2bi/slematre/Documents/gestion_projet/nextflow-intro/data/FN433596 -S output.sam -p 3
