library(Signac)
library(Seurat)
library(Matrix)
library(EnsDb.Hsapiens.v86)
library(BSgenome.Hsapiens.UCSC.hg38)

set.seed(1234)

# load the RNA and ATAC data
counts <- Read10X_h5(filename = "/data/raw_feature_bc_matrix.h5")
fragpath <- '/data/atac_fragments.tsv.gz'

# get gene annotations for hg38
annotation <- GetGRangesFromEnsDb(ensdb = EnsDb.Hsapiens.v86)
seqlevelsStyle(annotation) <- "UCSC"
genome(annotation) <- "hg38"

# create ATAC assay and add it to the object
chrom_assay <- CreateChromatinAssay(
  counts = counts$Peaks,
  sep = c(":", "-"),
  fragments = fragpath,
  annotation = annotation
)

# create a Seurat object containing the RNA adata
pbmc <- CreateSeuratObject(
  counts = chrom_assay,
  assay = "peaks"
)

Annotation(pbmc) <- annotation

pbmc <- RunTFIDF(pbmc)
pbmc <- FindTopFeatures(pbmc, min.cutoff = 'q0')
pbmc <- RunSVD(pbmc)

gene.activities <- GeneActivity(pbmc)

dir.create("/data/gene_activities_matrix")
writeMM(gene.activities, "/data/gene_activities_matrix/matrix.mtx")
write.table(rownames(gene.activities), file = "/data/gene_activities_matrix/genes.tsv", sep = "\t", row.names=FALSE, quote=FALSE, col.names = FALSE)
write.table(colnames(gene.activities), file = "/data/gene_activities_matrix/barcodes.tsv", sep = "\t", row.names=FALSE, quote=FALSE, col.names = FALSE)


