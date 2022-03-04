#!/bin/bash

kmdiff count --file ampicilin.fof --run-dir ampicilin_dir --kmer-size 31 --hard-min 2 --threads 20
kmdiff diff --km-run ampicilin_dir -1 182 -2 52 --output-dir ampicilin_out --pop-correction --ploidy 1 --threads 20

