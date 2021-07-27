# Single Command Docker container to convert ATAC-seq peaks to gene activity scores

Running Signac gene activity scoring through docker. This is built from the signac vignette. It installs one additional package which is necessary for the vignette to work. I had many difficulties installing the dependencies for building gene activity scores, using this command only requires docker (and sufficient memory).

To run this code use the following command:
```
docker run -it -v [PATH TO DATA]:/data/ -e RETICULATE_MINICONDA_ENABLED=FALSE atong01/signac-gene-activities:latest Rscript gene_activities.R
```

`[PATH TO DATA]` should be a writable path to a folder containing: `fragments.tsv.gz`, `filtered_peak_bc_matrix.h5`, and `singlecell.csv`.

setting the environment variable `RETICULATE_MINICONDA_ENABLED=FALSE` disables the prompt for install when loading `Signac` this auto accepts in a script which messes up package versioning. In particular Seurat. https://github.com/rstudio/reticulate/issues/608

You may need to reconfigure the script depending on your specific use case. We provide another script `10X_gene_activities.R` that worked for a 10X multiome datasets.

We output the gene activities matrix in a form similar to other Cell Ranger output, in a folder `gene_activities_matrx` which contains `genes.tsv`, `barcodes.tsv` and `matrix.tsv`, we do this to maintain compatability with other loading software especially for R / Python tools. This will appear in the [PATH TO DATA].

TODO: integrate running the script into the docker command to make this a single command script to get the gene activities matrix. 

TODO: accommodate read only data, i.e. separate write folder

TODO: accommodate missing metadata in `singlecell.csv`

TODO: add quality control plots
