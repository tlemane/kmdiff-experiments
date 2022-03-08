#!/bin/bash

#modified from countKmer2_jf2.sh

CORES=20
MEM=4G
KMER_SIZE=31

DATA_CONTROLS="../data/controls"
DATA_CASES="../data/cases"

DIR="./hawk_output"
mkdir ${DIR}
HAWK_DIR="../../hawk_bin"
JELLY_DIR="../../hawk_bin"

DS=(${DATA_CASES} ${DATA_CONTROLS})
for D in ${DS[@]}
do
  ID="${D}/sra.txt"
  while IFS= read -r sample
  do
    OUTPREFIX=${DIR}/${sample}

    mkdir ${OUTPREFIX}_kmers

    ${JELLY_DIR}/jellyfish count -C -o ${OUTPREFIX}_kmers/tmp -m ${KMER_SIZE} -t ${CORES} -s ${MEM} \
      <(zcat ${D}/${sample}_1.fastq.gz ${D}/${sample}_2.fastq.gz)

    COUNT=$(ls ${OUTPREFIX}_kmers/tmp* | wc -l)

    if [ ${COUNT} -eq 1 ]
    then
      mv ${OUTPREFIX}_kmers/tmp ${OUTPREFIX}_kmers_jellyfish
    else
      ${JELLY_DIR}/jellyfish merge -o ${OUTPREFIX}_kmers_jellyfish ${OUTPREFIX}_kmers/tmp*
    fi

    rm -rf ${OUTPREFIX}_kmers

    COUNT=$(ls ${OUTPREFIX}_kmers_jellyfish | wc -l)

    if [ ${COUNT} -eq 1 ]
    then
      ${JELLY_DIR}/jellyfish histo -f -o ${OUTPREFIX}.kmers.hist.csv_tmp -t ${CORES} ${OUTPREFIX}_kmers_jellyfish

      tail -n +2 ${OUTPREFIX}.kmers.hist.csv_tmp > ${OUTPREFIX}.kmers.hist.csv
      rm ${OUTPREFIX}.kmers.hist.csv_tmp
      awk '{print $2"\t"$1}' ${OUTPREFIX}.kmers.hist.csv > ${OUTPREFIX}_tmp
      mv ${OUTPREFIX}_tmp ${OUTPREFIX}.kmers.hist.csv

      awk -f ${HAWK_DIR}/countTotalKmer.awk ${OUTPREFIX}.kmers.hist.csv >> ${DIR}/total_kmer_counts.txt

      CUTOFF=1
      echo ${CUTOFF} > ${OUTPREFIX}_cutoff.csv

      ${JELLY_DIR}/jellyfish dump -c -L `expr ${CUTOFF} + 1` ${OUTPREFIX}_kmers_jellyfish > ${OUTPREFIX}_kmers.txt

      sort --parallel=${CORES} -n -k 1 ${OUTPREFIX}_kmers.txt > ${OUTPREFIX}_kmers_sorted.txt

      rm ${OUTPREFIX}_kmers_jellyfish
      rm ${OUTPREFIX}_kmers.txt

      echo $(realpath "${OUTPREFIX}_kmers_sorted.txt") >> ${DIR}/sorted_files.txt
    fi
  done < ${ID}
done
