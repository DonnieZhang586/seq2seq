#!/usr/bin/env bash

# NMT model using filtered WMT14 data, available on http://www-lium.univ-lemans.fr/~schwenk/nnmt-shared-task/

raw_data=raw_data/WMT14
data_dir=data/WMT14

rm -rf ${data_dir}
mkdir -p ${data_dir}

scripts/prepare-data.py ${raw_data}/WMT14.fr-en fr en ${data_dir} --no-tokenize \
--dev-corpus ${raw_data}/ntst1213.fr-en \
--test-corpus ${raw_data}/ntst14.fr-en \
--vocab-size 30000 --shuffle --seed 1234
# --unescape-special-chars --normalize-punk

#cur_dir=`pwd`
#cd ${data_dir}
#
#ln -s train.en train.char.en
#ln -s train.fr train.char.fr
#ln -s dev.en dev.char.en
#ln -s dev.fr dev.char.fr
#ln -s test.en test.char.en
#ln -s test.fr test.char.fr
#
#cd ${cur_dir}
#
#scripts/prepare-data.py ${data_dir}/train.char en fr ${data_dir} --mode vocab --character-level \
#--vocab-prefix vocab.char --vocab-size 200

scripts/prepare-data.py ${raw_data}/WMT14.fr-en fr en ${data_dir} --no-tokenize \
--output train.subwords --dev-prefix dev.subwords --test-prefix test.subwords --vocab-prefix vocab.subwords \
--dev-corpus ${raw_data}/ntst1213.fr-en \
--test-corpus ${raw_data}/ntst14.fr-en \
--vocab-size 30000 --subwords --shuffle --seed 1234
