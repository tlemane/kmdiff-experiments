#!/bin/bash

BIN_DIR="../../kmdiff_bin"
T=20

${BIN_DIR}/kmdiff count --file ampicilin.fof --run-dir kcount --kmer-size 31 --hard-min 2 --threads 20 --nb-partitions 200

${BIN_DIR}/kmdiff diff --km-run kcount -1 40 -2 40 --output-dir output --pop-correction --ploidy 2 --threads 20

