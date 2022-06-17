#!/bin/bash

BIN_DIR="../../hawk_bin"
COUNT_DIR="./hawk_output"

noInd=$(cat ${COUNT_DIR}/sorted_files.txt | wc -l);

noPC=2
noThread=20

cp gwas_info.txt ${COUNT_DIR}
cp parfile.txt ${COUNT_DIR}

cd ${COUNT_DIR}

/usr/bin/time -f %E,%M ${BIN_DIR}/preProcess

cat case_total_kmers.txt control_total_kmers.txt > gwas_eigenstratX.total
cat case.ind control.ind > gwas_eigenstratX.ind

caseCount=$(cat case_sorted_files.txt | wc -l);
controlCount=$(cat control_sorted_files.txt | wc -l);

${BIN_DIR}/hawk ${caseCount} ${controlCount} > hawk_out.txt

${BIN_DIR}/smartpca -p parfile.txt > log_eigen.txt

${BIN_DIR}/evec2pca.perl 10 gwas_eigenstrat.evec gwas_eigenstratX.ind gwas_eigenstrat.pca

tail -${noInd} gwas_eigenstrat.pca > pcs.evec

/usr/bin/time -f %E,%M sort -g  -k 4 -t $'\t' case_out_w_bonf.kmerDiff > case_out_w_bonf_sorted.kmerDiff
mv case_out_w_bonf_sorted.kmerDiff case_out_w_bonf_top.kmerDiff

/usr/bin/time -f %E,%M sort -g  -k 4 -t $'\t' control_out_w_bonf.kmerDiff > control_out_w_bonf_sorted.kmerDiff
mv control_out_w_bonf_sorted.kmerDiff control_out_w_bonf_top.kmerDiff

/usr/bin/time -f %E,%M ${BIN_DIR}/log_reg_case -t $noThread -p $noPC > pvals_case_top.txt 2> log_reg_case_LOG
/usr/bin/time -f %E,%M ${BIN_DIR}/log_reg_control -t $noThread -p $noPC > pvals_control_top.txt 2> log_reg_control_LOG

paste pvals_case_top.txt case_out_w_bonf_top.kmerDiff  > pvals_case_top_merged.txt
sort -g -k 1 -t $'\t' pvals_case_top_merged.txt > pvals_case_top_merged_sorted.txt

paste pvals_control_top.txt control_out_w_bonf_top.kmerDiff  > pvals_control_top_merged.txt
sort -g -k 1 -t $'\t' pvals_control_top_merged.txt > pvals_control_top_merged_sorted.txt

${BIN_DIR}/convertToFasta_bf_correction


