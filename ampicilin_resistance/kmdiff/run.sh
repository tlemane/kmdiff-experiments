#!/bin/bash

BIN_DIR="../../kmdiff_bin"
T=20

${BIN_DIR}/kmdiff count --file ampicilin.fof --run-dir ampicilin_dir --kmer-size 31 --hard-min 2 --threads ${T} --nb-partitions 20
${BIN_DIR}/kmdiff diff --km-run ampicilin_dir -1 189 -2 52 --output-dir ampicilin_out --pop-correction --ploidy 1 --threads ${T}

