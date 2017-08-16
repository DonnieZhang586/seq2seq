# seq2seq
Attention-based sequence to sequence learning

## Dependencies

* [TensorFlow 1.2 for Python 3](https://www.tensorflow.org/get_started/os_setup.html)
* YAML and Matplotlib modules for Python 3: `sudo apt-get install python3-yaml python3-matplotlib`


## How to use


Train a model (CONFIG is a YAML configuration file, such as `config/default.yaml`):

    ./seq2seq.sh CONFIG --train -v 


Translate text using an existing model:

    ./seq2seq.sh CONFIG --decode FILE_TO_TRANSLATE --output OUTPUT_FILE
or for interactive decoding:

    ./seq2seq.sh CONFIG --decode


Example model:

    config/WMT14/download.sh    # download WMT14 data into raw_data/WMT14
    config/WMT14/prepare.sh     # preprocess the data, and copy the files to data/WMT14
    ./seq2seq.sh config/WMT14/baseline.yaml --train -v   # train a baseline model on this data

You should get similar results to those (our model was trained on a single Titan X I for about 4 days):

|  BLEU   |         |         |  Loss   |         |  Steps  |  Time  |
|---------|---------|---------|---------|---------| ------- |--------|
|  Dev    |  Test   | +beam   |  Dev    |  Train  |         |        |
|  25.04  |  28.64  |  29.22  |  46.15  |  40.71  |   240k  |   60h  |
|  25.25  |  28.67  |  29.28  |  45.70  |  39.77  |   330k  |   80h  |

## Features
* **YAML configuration files**
* **Beam-search decoder**
* **Ensemble decoding**
* **Multiple encoders**
* **Hierarchical encoder**
* **Bidirectional encoder**
* **Local attention model**
* **Convolutional attention model**
* **Detailed logging**
* **Periodic BLEU evaluation**
* **Periodic checkpoints**
* **Multi-task training:** train on several tasks at once (e.g. French->English and German->English MT)
* **Subwords training and decoding**
* **Input binary features instead of text**
* **Pre-processing script:** we provide a fully-featured Python script for data pre-processing (vocabulary creation, lowercasing, tokenizing, splitting, etc.)
* **Dynamic RNNs:** we use symbolic loops instead of statically unrolled RNNs. This means that we don't mean to manually configure bucket sizes, and that model creation is much faster.

## Credits

* This project is based on [TensorFlow's reference implementation](https://www.tensorflow.org/tutorials/seq2seq)
* We include some of the pre-processing scripts from [Moses](http://www.statmt.org/moses/)
* The scripts for subword units come from [github.com/rsennrich/subword-nmt](https://github.com/rsennrich/subword-nmt)
