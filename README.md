# signac-gene-activities
Running Signac gene activity scoring through docker. This is built from the signac vignette. It installs one additional package which is necessary for the vignette to work.

To run this code use the following command:
```
docker run -it -v [PATH TO YOUR OUTPUT FOLDER HERE]:/data/ atong01/signac-gene-activites:latest 
```

`library(Signac)` asks if you want to install miniconda, which you do not need for the vignette or to calculate gene activity scores. For this reason I ran the script interactively and answered no when asked. Otherwise the script does not require interactivity and can be safely pasted in

TODO: integrate running the script into the docker command to make this a single command script to get the gene activities matrix. 

We output the gene activites matrix in a form similar to other Cell Ranger output, in a folder `gene_activities_matrx` which contains `genes.tsv`, `barcodes.tsv` and `matrix.tsv`, we do this to maintain compatability with other loading software especially for R / Python tools.
