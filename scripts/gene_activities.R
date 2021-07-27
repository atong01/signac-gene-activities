library(Signac)
library(Seurat)
library(GenomeInfoDb)
library(EnsDb.Hsapiens.v75)
library(ggplot2)
library(patchwork)
library(Matrix)

set.seed(1234)

counts <- Read10X_h5(filename = "/data/filtered_peak_bc_matrix.h5")

metadata <- read.csv(
  file = "/data/singlecell.csv",
  header = TRUE,
  row.names = 1
)

chrom_assay <- CreateChromatinAssay(
  counts = counts,
  sep = c(":", "-"),
  genome = 'hg19',
  fragments = '/data/fragments.tsv.gz',
  min.cells = 10,
  min.features = 200
)

pbmc <- CreateSeuratObject(
  counts = chrom_assay,
  assay = "peaks",
  meta.data = metadata
)

annotations <- GetGRangesFromEnsDb(ensdb = EnsDb.Hsapiens.v75)

seqlevelsStyle(annotations) <- 'UCSC'
genome(annotations) <- "hg19"

Annotation(pbmc) <- annotations

pbmc <- RunTFIDF(pbmc)
pbmc <- FindTopFeatures(pbmc, min.cutoff = 'q0')
pbmc <- RunSVD(pbmc)

gene.activities <- GeneActivity(pbmc)

dir.create("/data/gene_activities_matrix")
writeMM(gene.activities, "/data/gene_activities_matrix/matrix.mtx")
write.table(rownames(gene.activities), file = "/data/gene_activities_matrix/genes.tsv", sep = "\t", row.names=FALSE, quote=FALSE, col.names = FALSE)
write.table(colnames(gene.activities), file = "/data/gene_activities_matrix/barcodes.tsv", sep = "\t", row.names=FALSE, quote=FALSE, col.names = FALSE)

