#!/bin/bash

sra_id="sra_test.txt"
tmp="./tmp"
thread=8

[[ ! -d ${tmp} ]] && mkdir ${tmp}

DATA=("./controls ./cases")
for D in ${DATA[@]}
do
  while IFS= read -r sra
  do
    parallel-fastq-dump -s ${sra} -t ${thread} -O ${D} -T ${tmp} --split-e --gzip
  done < "${D}/${sra_id}"
done

rm -rf tmp
