#!/bin/bash -ue
bedtools genomecov -ibam sorted_output.bam -d > output.gcbout
