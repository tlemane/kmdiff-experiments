#!/bin/bash

mkdir kmdiff_bin

cd thirdparty/kmdiff
git submodule update --init

bash install.sh -t 0 -c 4 -j 8 -s 1

cd -

cp thirdparty/kmdiff/kmdiff_build/bin/* kmdiff_bin


mkdir hawk_bin

cd thirdparty/HAWK
make
cd supplements
tar -zxvf jellyfish-2.2.10-HAWK.tar.gz
tar -zxvf EIG6.0.1-Hawk.tar.gz
cd jellyfish-2.2.10
./configure
make

cd ../EIG6.0.1-Hawk/src
make
make install

cd ..


cd ../../../..

cp thirdparty/HAWK/supplements/jellyfish-2.2.10/bin/jellyfish hawk_bin
cp thirdparty/HAWK/supplements/EIG6.0.1-Hawk/bin/smartpca hawk_bin
cp thirdparty/HAWK/supplements/EIG6.0.1-Hawk/bin/evec2pca.perl hawk_bin
cp thirdparty/HAWK/countTotalKmer.awk hawk_bin
cp thirdparty/HAWK/preProcess hawk_bin
cp thirdparty/HAWK/hawk hawk_bin
cp thirdparty/HAWK/convertToFasta_bf_correction hawk_bin
cp thirdparty/HAWK/convertToFasta_bh_correction hawk_bin
cp thirdparty/HAWK/bonf_fasta hawk_bin
cp thirdparty/HAWK/log_reg_case hawk_bin
cp thirdparty/HAWK/log_reg_control hawk_bin

