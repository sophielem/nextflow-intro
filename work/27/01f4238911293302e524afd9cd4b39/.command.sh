#!/bin/bash -ue
bowtie2 -q -1 ERR036019samp_1.fastq.gz ERR036019samp_2.fastq.gz[0]-2 ERR036019samp_1.fastq.gz ERR036019samp_2.fastq.gz[1] -x /data/FN433596.fasta -S output.sam -p nb_cpus 1
