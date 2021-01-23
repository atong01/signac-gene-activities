FROM timoast/signac:latest  

RUN R --slave --no-restore --no-save -e "BiocManager::install(c('BSgenome.Hsapiens.UCSC.hg19', 'EnsDb.Hsapiens.v75'))"

COPY gene_activities.R /gene_activities.R
