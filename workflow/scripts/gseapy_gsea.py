import pandas as pd
import gseapy as gp
from gseapy.plot import gseaplot

gene_exp = pd.read_csv("geneexpGSE47961SARSshort.gct", sep="\t")

phenoA, phenoB, class_vector = gp.parser.gsea_cls_parser("geneexpGSE47961SARSshort.cls")
print("positively correlated: ", phenoA)
print("negtively correlated: ", phenoB)
print()

#sample header in gct needs to match cls labels
#https://gseapy.readthedocs.io/en/latest/run.html for choices
gsresult = gp.gsea(gene_exp, 'exampleicSARSgenepanels.gmt', class_vector,
permutation_type='gene_set',
permutation_num=1000,
outdir='GSEAGCTPy',
no_plot=False,
method='t_test', #does not work with t_test
processes=4, seed=7,
format='png')
gsresult.run()
print(gsresult.res2d.sort_index().head())

terms = gsresult.res2d.index
i = 0
for iter in terms:
gseaplot(gsresult.ranking, term=terms[i], **gsresult.results[terms[i]])
i = i + 1