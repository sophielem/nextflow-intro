#!/bin/bash -ue
samtools sort -@ 3 -o sorted_output.bam output.bam
