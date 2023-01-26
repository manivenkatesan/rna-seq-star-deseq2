# Snakemake workflow: rna-seq-star-deseq2

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4737358.svg)](https://doi.org/10.5281/zenodo.4737358)
[![Snakemake](https://img.shields.io/badge/snakemake-≥6.1.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/snakemake-workflows/rna-seq-star-deseq2/workflows/Tests/badge.svg?branch=master)](https://github.com/snakemake-workflows/rna-seq-star-deseq2/actions?query=branch%3Amaster+workflow%3ATests)

This workflow performs a differential gene expression analysis with STAR and Deseq2.

## Usage

The usage of this workflow is described in the [Snakemake Workflow Catalog](https://snakemake.github.io/snakemake-workflow-catalog/?usage=snakemake-workflows%2Frna-seq-star-deseq2).

If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this (original) repository and its DOI (see above).

Create the virtual environment in which to run the workflow:

`conda config --set channel_priority flexible`

`conda create -n snakemake7.19.1 snakemake=7.19.1 mamba=1.1.0`

Running the workflow gives an error:

> EXITING: FATAL INPUT ERROR: duplicate parameter "outSAMtype" in input "Command-Line"

> SOLUTION: keep only one definition of input parameters in each input source

To resolve this issue edit workflow/rules/align.smk:

Delete: `, config["params"]["star"] `AND `{}`

collections.abc There was a change in Python 3.10 and the `Mapping` class has been moved to the [collections.abc](https://docs.python.org/3/library/collections.abc.html#collections.abc.Mapping) module. If you use Python version 3.10+, change your imports from the following:

In file or wherever the traceback error points towards (for me it was here): `.snakemake/conda/a615f0c5239e1fe3f0c98c4a736f16c9/lib/python3.11/site-packages/multiqc/utils/config.py`

Change `import collections`to `import collections.abc`

Change `collections.Mapping` to `collections.abc.Mapping`

Run snakemake:

`snakemake --cores all --use-conda`

Download the datasets into `resources/raw_datasets` . 

Make sure to double check that rule `gseapy_gsea` and script `gseapy_gsea.py` are 

correctly linking samples and conditions in the comparisons!
