#import TSV file into data frame if you want to test using R
#countData <- read.table('/DATA/m.venkatesan/A-vs-B.diffexp.symbol.tsv', header=TRUE, check.names=FALSE)
library("data.table")

countData <- read.table(snakemake@input[["counts"]], header=TRUE, check.names=FALSE)
#The GSEA manual mentions the list should be sorted in descending numerical order
#However, in my case with the particular contrast order "A-vs-B" it should be sorted in ascending order to account for B showing a the positive phenotype
countData <- countData[order(countData$log2FoldChange),] 

countData.unique <- countData[!duplicated(countData$gene),] #remove duplicated rownames
row.names(countData.unique) <- countData.unique$gene #assign rownames
RNK = data.table(Gene_Name = row.names(countData.unique), log2FoldChange = countData.unique$log2FoldChange)
RNK = subset(RNK, log2FoldChange != "NA") #keep all rows without "NA" values
write.table(RNK, snakemake@output[[1]], quote=F, sep="\t", row.names = FALSE, col.names = FALSE)