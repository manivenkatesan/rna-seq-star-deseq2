import pandas as pd
import gseapy as gp
import numpy as np
from gseapy.plot import gseaplot
# import yaml
# from snakemake.utils import validate

gene_exp = pd.read_csv("results/deseq2/normcounts.symbol.tsv", sep="\t")
samples = pd.read_csv("config/samples.tsv", sep="\t")
samples2 = samples.sort_values(by=['sample_name'], ascending=True) #order samples dataframe based on sample_name
samples_class = samples2.iloc[:,1]

#samples_class = ["A","B","A","B","A","B"]

phenoA, phenoB, class_vector = gp.parser.gsea_cls_parser(samples_class)

#print("positively correlated: ", phenoA)
#print("negtively correlated: ", phenoB)

# #sample header in gct needs to match cls labels
# #https://gseapy.readthedocs.io/en/latest/run.html for choices
gs_res = gp.gsea(data=gene_exp, 
                gene_sets='/DATA/m.venkatesan/rna-seq-star-deseq2/resources/genesets/h.all.v2022.1.Hs.symbols.gmt', 
                cls=class_vector,
                permutation_type='gene_set',  # set permutation_type to phenotype if samples >=15
                permutation_num=1000,
                outdir=snakemake.output[0],
                no_plot=False, 
                format='png',
                method='log2_ratio_of_classes', 
                threads=4, seed= 7)
print(gs_res.res2d.sort_index().head())