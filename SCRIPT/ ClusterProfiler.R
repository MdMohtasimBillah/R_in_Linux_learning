# Load the packages relevant for the analysis
library(tidyverse)
library(RColorBrewer)
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install
BiocManager::install("clusterProfiler")
library(clusterProfiler)
BiocManager::install("org.Hs.eg.db")
library(org.Hs.eg.db)
library(DOSE)
library(enrichplot)
install.packages("ggupset")
library(ggupset)
BiocManager::install("AnnotationDbi")
library(AnnotationDbi)

# Prepare gene list
gene_list <- c("DNF4", "BRCA1", "TP53", "EGFR")

# Convert gene symbol to entrez id
gene_entrez <- bitr(gene_list, fromType = "SYMBOL", toType = "ENTREZID", OrgDb = "org.Hs.eg.db")


ego <- enrichGO(gene          = gene_entrez$ENTREZID,
                OrgDb         = org.Hs.eg.db,
                keyType       = "ENTREZID",
                ont           = "ALL",
                pAdjustMethod = "BH",
                qvalueCutoff  = 0.05)
head(ego,10)


# load data table
similar_gene <- read.table("Data/table_similar.txt")

gene_id <- similar_gene |> 
  select(1) |> 
  write.csv("Output/gene_id.csv", row.names = F )

library(clusterProfiler)
library(org.Hs.eg.db)
library(DOSE)
library(enrichplot)
library(AnnotationDbi)
gene_id <- read.csv("Output/gene_id.csv", skip=1) # if you want to skip the first row then use it

names(gene_id) <- "Gene_Symbol"
names(gene_id)
gene_id  

ncol(gene_id)
nrow(gene_id)

bitr(gene_id, fromType = "Symbol", toType = "ENTREZID", OrgDb = "org.Hs.eg.db")

