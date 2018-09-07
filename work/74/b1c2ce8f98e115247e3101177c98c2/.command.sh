#!/bin/bash -ue
bowtie2 -q -1 reads_1.fastq -2 reads_2.fastq -x /data/FN433596 -S output.sam -p nb_cpus 1
