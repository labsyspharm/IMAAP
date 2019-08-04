# IMAAP (Image Annotation and Analysis Package)
This work is supported by ... <br>
**Author:** Ajit Johnson Nirmal
# Installation
The package can be installed directly from GitHub with the following commands:
```R
if( !require(devtools) ) install.packages("devtools")
devtools::install_github( "ajitjohnson/IMAAP" )
```

Load the library
```R
library(IMAAP)
```
# Requirements
In order to infer the celltypes/states from the users data, the user needs to provide the data and a predefined mapping of channels/markers to cell types/states (the package calls this cheat_sheet). The package comes with a small example of 10,000 cells and its corresponding cheat_sheet.

In order to take a peak at the examples use the following commands in the R terimnal

```R
example_data[1:5,1:5]

        CD2 TCR CD4 CD3D CD7
1_2679  294 735  97  231  56
40_385   18 514  62    1  35
40_1108 101 563 353   15  59
58_776   75 675 189   12  15
20_1839 324 776 253  201 124

```
The users data need to follow the same format. Markers in columns and cells in rows. The data need to be in natural scale without any transofrmation.

```R
example_cheat_sheet

           Path         cell_type      X    X.1   X.2 X.3
1                    immune cells   CD45                 
2         other    CD45 Neg Tumor   /CD2  /CD43 /CD30    
3         other Endothelial cells   CD31                 
4  immune cells       Tumor cells   CD30                 
5  immune cells           T cells    CD2    CD5  CD43 CD7
6  immune cells           B cells   CD20                 
7  immune cells       Macrophages  /CD68 /CD163          
8  immune cells   Dendritic cells   CD21                 
9   Macrophages    M1 macrophages   CD68                 
10  Macrophages    M2 macrophages /CD163 /CD206 

```
The above is an example of the cheat sheet. Please follow the same format without editing the columnames. My recommendation would be to download the given cheat sheet (found with in the *data* folder), edit as necessary and load it, using the following command.

```R
cheat_sheet <- read.table(file = "cheat_sheet.txt", sep='\t', header = T, stringsAsFactors=FALSE)
```

# Annotation
## Run the algorithm to annotate cells
Once the data and cheat_sheet is ready, the algorithm can be run to annotate the cells.

```R
annotate_the_cells <-imaap_annotate_cells (data = example_data, cheat_sheet = example_cheat_sheet, SD = 3) 
```

To view the results, do the following

```R
results <- annotate_the_cells[3]
head(results)

40_385  Endothelial cells
40_1108    M2 macrophages
58_776     CD45 Neg Tumor
20_1839       Tumor cells
40_4088    M2 macrophages
2_3704        Tumor cells
42_2578   Likely_ T cells
76_2414    CD45 Neg Tumor
```






