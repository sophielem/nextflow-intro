#!/bin/bash -ue
bowtie2 -q -1 reads_1.fastq -2 reads_2.fastq -x index_prefix -S output.sam -p nb_cpus
