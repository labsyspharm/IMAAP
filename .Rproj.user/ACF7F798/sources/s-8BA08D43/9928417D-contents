#' @title Fitting a gaussian mixture model to the users data and assigning cell type to each cell
#' @description Gaussian mixture model is fit to every marker in the dataset and a probaility score is given to the areas of uncertanity.
#' @param data Dataframe of data (natural scale) containing samples as rows and markers as columns.
#' @param SD Standard Deviation. Default is set to 3. This determines to what extend of the data distribution is considered as positive to marker expression. If your data distribution is clearly not bi-modal, it is suggested to be conservative in the selection of an SD value.
#' @return Probability scores for each marker and a deconvolved data matrix for calculating percent positivity of markers of interest.
#' @export

imaap_annotate_cells <- function(data, cheat_sheet, SD) {
  # Get the scores from the model
  s = imaap_model(data, SD)
  marker_prob = data.frame(s[1])
  colnames(marker_prob) = colnames(data)
  # Derive probablilities
  cell_prob <- imaap_prob (marker_prob,cheat_sheet)
  # Annotate cells
  cell_annotation <- imaap_annotation(cell_prob,cheat_sheet)
  # Annotate remainder cells
  modified_cell_annotation <- imaap_marker_drop (cell_prob, cell_annotation, cheat_sheet)
  # Plot the map for every "RunBy'
  peaks_low = data.frame(s[2])
  peaks_high = data.frame(s[3])
  my_plots = list()
  my_plots<- imaap_model_plot (data= data.frame(s[4]),peaks_low,peaks_high,SD)
  # save plot
  dir.create("Fitted distribution plots", showWarnings = FALSE)
  pdf(paste("./Fitted distribution plots/distibution plot",".pdf" ), width = 9.5, height = 12) # Open a new pdf file
  grid.arrange(grobs = my_plots, ncol = 4) # Write the grid.arrange in the file
  dev.off() # Close the file

  row.names(cell_annotation) = cell_annotation$cell_id
  cell_annotation = cell_annotation[, -c(1,2)]

  row.names(modified_cell_annotation) = modified_cell_annotation$cell_id
  modified_cell_annotation = modified_cell_annotation[, -c(1,2)]

  # Reduce to one call per cell
  cell_collapsed <- imaap_one_call_per_cell (cell_calling = modified_cell_annotation)
  cell_collapsed[,1] <- as.character(cell_collapsed[,1])

  cell_calling <- list(cell_annotation, modified_cell_annotation, cell_collapsed)
  return(cell_calling)
}





