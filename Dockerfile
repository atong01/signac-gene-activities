FROM timoast/signac:latest  

RUN R --slave --no-restore --no-save -e "BiocManager::install(c('BSgenome.Hsapiens.UCSC.hg19', 'EnsDb.Hsapiens.v75', 'BSgenome.Hsapiens.UCSC.hg38', 'EnsDb.Hsapiens.v86'), update=FALSE, ask=FALSE)"

RUN R --slave --no-restore --no-save -e "install.packages('remotes')"

RUN R --slave --no-restore --no-save -e "remotes::install_github('mojaveazure/seurat-disk')"

COPY gene_activities.R /gene_activities.R
COPY 10X_gene_activities.R /10X_gene_activities.R
