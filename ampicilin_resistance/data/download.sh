#!/bin/bash

dir=$1
thread=$2
tmp=$3

[[ ! -d ${tmp} ]] && mkdir ${tmp}

while IFS= read -r sra
do
  parallel-fastq-dump -s ${sra} -t ${thread} -O ${dir} -T ${tmp} --split-e --gzip
done < "${dir}/sra.txt"


