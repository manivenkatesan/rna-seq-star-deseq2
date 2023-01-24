rule prerank_file_preparation:
    input:
        counts="results/diffexp/{contrast}.diffexp.symbol.tsv", 
    output:
        ranked="results/gseapy/{contrast}.diffexpr.rnk",
    log:
        "logs/gseapy/{contrast}.prerank_file_preparation.log",
    params: 
    conda:
        "../envs/rbase.yaml" 
    threads: 24
    script:
        "../scripts/gseapy_prerank.R" 

#Hallmark gene sets: h.all.v2022.1.Hs.symbols 
rule gseapy_prerank_hallmark:
    input:
        ranked2=rules.prerank_file_preparation.output.ranked
    output:
        prerank_res=directory("results/gseapy/{contrast}.gseapy_preranked_hallmark")
    log:
        "logs/gseapy/{contrast}.gseapy_preranked_hallmark.log",
    params: 
    conda:
        "../envs/gseapy.yaml" 
    threads: 24
    shell:
        """
            gseapy prerank -r {input.ranked2} -g {config[gsea][hallmark_curated_geneset]} -o {output}
        """

#C1 curated gene sets: c1.all.v2022.1.Hs.symbols 
rule gseapy_prerank_c1curated:
    input:
        ranked2=rules.prerank_file_preparation.output.ranked
    output:
        prerank_res=directory("results/gseapy/{contrast}.gseapy_preranked_c1curated")
    log:
        "logs/gseapy/{contrast}.gseapy_preranked_c1curated.log",
    params: 
    conda:
        "../envs/gseapy.yaml" 
    threads: 24
    shell:
        """
            gseapy prerank -r {input.ranked2} -g {config[gsea][c1_curated_geneset]} -o {output}
        """

#C2 curated gene sets: c2.all.v2022.1.Hs.symbols
rule gseapy_prerank_c2curated:
    input:
        ranked2=rules.prerank_file_preparation.output.ranked
    output:
        prerank_res=directory("results/gseapy/{contrast}.gseapy_preranked_c2curated")
    log:
        "logs/gseapy/{contrast}.gseapy_preranked_c2curated.log",
    params: 
    conda:
        "../envs/gseapy.yaml" 
    threads: 24
    shell:
        """
            gseapy prerank -r {input.ranked2} -g {config[gsea][c2_curated_geneset]} -o {output}
        """
