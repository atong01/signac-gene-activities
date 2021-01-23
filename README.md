# Single Command Docker container to convert ATAC-seq peaks to gene activity scores

Running Signac gene activity scoring through docker. This is built from the signac vignette. It installs one additional package which is necessary for the vignette to work. I had many difficulties installing the dependencies for building gene activity scores, using this command only requires docker (and sufficient memory).

To run this code use the following command:
```
docker run -it -v [PATH TO DATA]:/data/ atong01/signac-gene-activites:latest Rscript gene_activities.R
```

`[PATH TO DATA]` should be a writable path to a folder containing: `fragments.tsv.gz`, `filtered_peak_bc_matrix.h5`, and `singlecell.csv`.

We output the gene activites matrix in a form similar to other Cell Ranger output, in a folder `gene_activities_matrx` which contains `genes.tsv`, `barcodes.tsv` and `matrix.tsv`, we do this to maintain compatability with other loading software especially for R / Python tools. This will appear in the [PATH TO DATA].

TODO: integrate running the script into the docker command to make this a single command script to get the gene activities matrix. 

TODO: accommodate read only data, i.e. separate write folder

TODO: accommodate missing metadata in `singlecell.csv`

TODO: add quality control plots
