#!/usr/bin/env nextflow

params.results = "$baseDir/results"
params.read = "$baseDir/data"
params.cpus = 3
params.index = "$baseDir/data/FN433596"

readChannel = Channel.fromFilePairs("${params.read}/*{1,2}.fastq.gz")

process mapping {
  conda "bioconda::bowtie2"

  input:
    set id, file(reads) from readChannel

  output:
    set id, file("*.sam") into mappingChannel

    script:
    """
      bowtie2 -q -1 ${reads[0]} -2 ${reads[1]} -x ${params.index} -S output.sam -p ${params.cpus}
    """
}

process samtools_view {
  conda "bioconda::samtools"

  input:
    set id, file(reads) from mappingChannel

  output:
    set id, file("*.bam") into bamChannel

    script:
    """
      samtools view -S -@ ${params.cpus} -b -o output.bam ${reads}
    """
}

process samtools_sort {
  conda "bioconda::samtools"

  input:
    set id, file(reads) from bamChannel

  output:
    set id, file("*.bam") into sortbamChannel

    script:
    """
      samtools sort -@ ${params.cpus} -o sorted_output.bam ${reads}
    """
}

process bedtools {
  conda "bioconda::bedtools"

  input:
    set id, file(reads) from sortbamChannel

  output:
    set id, file("*.gcbout") into coverageChannel

    script:
    """
      bedtools genomecov -ibam ${reads} -d > output.gcbout
    """
}

process coverageStats {
  conda "python=3.6 numpy"

  input:
    set id, file(reads) from coverageChannel

  output:
    stdout cov_result

    script:
    """
      bed2coverage ${reads}
    """
}

cov_result.subscribe {println it}
