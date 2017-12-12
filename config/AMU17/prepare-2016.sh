#!/usr/bin/env bash

raw_data=raw_data/APE17
data_dir=data/AMU17

mkdir -p ${data_dir}

function preprocess {
cat $1 | scripts/escape-special-chars.perl | scripts/truecase.perl --model $2 | scripts/apply_bpe.py --codes $3> $4
}

cat ${raw_data}/{4M,500K}.src > ${data_dir}/train.raw.src
cat ${raw_data}/{4M,500K}.mt > ${data_dir}/train.raw.mt
cat ${raw_data}/{4M,500K}.pe > ${data_dir}/train.raw.pe

for i in {1..20}; do
    cat ${raw_data}/train.mt >> ${data_dir}/train.raw.mt
    cat ${raw_data}/train.pe >> ${data_dir}/train.raw.pe
    cat ${raw_data}/train.src >> ${data_dir}/train.raw.src
done

preprocess ${raw_data}/dev.src ${data_dir}/true.en ${data_dir}/en.bpe ${data_dir}/dev.src
preprocess ${raw_data}/dev.mt ${data_dir}/true.de ${data_dir}/de.bpe ${data_dir}/dev.mt
preprocess ${raw_data}/dev.pe ${data_dir}/true.de ${data_dir}/de.bpe ${data_dir}/dev.pe
cp ${raw_data}/dev.pe ${data_dir}/dev.raw.pe

preprocess ${raw_data}/test.2016.src ${data_dir}/true.en ${data_dir}/en.bpe ${data_dir}/test.src
preprocess ${raw_data}/test.2016.mt ${data_dir}/true.de ${data_dir}/de.bpe ${data_dir}/test.mt
cp ${raw_data}/test.2016.pe ${data_dir}/test.pe

preprocess ${raw_data}/test.2017.src ${data_dir}/true.en ${data_dir}/en.bpe ${data_dir}/test.2017.src
preprocess ${raw_data}/test.2017.mt ${data_dir}/true.de ${data_dir}/de.bpe ${data_dir}/test.2017.mt
cp ${raw_data}/test.2017.pe ${data_dir}/test.2017.pe

preprocess ${data_dir}/train.raw.src ${data_dir}/true.en ${data_dir}/en.bpe ${data_dir}/train.src
preprocess ${data_dir}/train.raw.mt ${data_dir}/true.de ${data_dir}/de.bpe ${data_dir}/train.mt
preprocess ${data_dir}/train.raw.pe ${data_dir}/true.de ${data_dir}/de.bpe ${data_dir}/train.pe

rm ${data_dir}/train.raw.*

scripts/prepare-data.py ${data_dir}/train src mt pe ${data_dir} --mode vocab --vocab-size 0
