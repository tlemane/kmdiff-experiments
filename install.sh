#!/bin/bash

mkdir kmdiff_bin

cd thirdparty/kmdiff
git submodule init --update
bash install.sh -t 0 -c 4 -j 8 -s 1

cp thirdparty/kmdiff/bin/* kmdiff_bin

cd -

mkdir hawk_bin

cd thirdparty/HAWK
make
cd supplements
tar -zxvf jellyfish-2.2.10-HAWK.tar.gz
cd jellyfish-2.2.10
./configure
make

cd ../../../..

cp thirdparty/HAWK/supplements/jellyfish-2.2.10/bin/jellyfish hawk_bin
cp thirdparty/HAWK/preProcess hawk_bin
cp thirdparty/HAWK/hawk hawk_bin
cp thirdparty/HAWK/convertToFasta_bf_correction hawk_bin
cp thirdparty/HAWK/convertToFasta_bh_correction hawk_bin
cp thirdparty/HAWK/bonf_fasta hawk_bin
cp thirdparty/HAWK/log_reg_case hawk_bin
cp thirdparty/HAWK/log_reg_control hawk_bin

