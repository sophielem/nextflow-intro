#!/bin/bash -ue
samtools view -S -@ 3 -b -o output.bam input.sam
