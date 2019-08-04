#' @title Reduce to one cell type call per cell
#' @description Every cell gets only one annotation; that is all levels of cell annotation are reduced to one.
#' @param cell_calling The cell annotation output from \code{\link{imaap_marker_drop}}
#' @return A single cell type calling for each cell in the dataset.
#' @export

imaap_one_call_per_cell <- function(cell_calling){
  require("zoo")
  require("dplyr")
  cell_annot <- cell_calling
  collapse_by <- list(rep(1:ncol(cell_annot)))
  # Intialize dataframe to store ressults
  compressed <- data.frame(row.names = row.names(cell_annot))
  for (i in 1: length(collapse_by)){
    sub_annot <- cell_annot[,unlist(collapse_by[i])]
    sub_annot <- data.frame(t(apply(sub_annot, 1, na.locf, na.rm=FALSE)))[,length(unlist(collapse_by[i])), drop = FALSE]
    compressed <- cbind(compressed,sub_annot)
  }

  if (ncol(cell_annot) == sum(lengths(collapse_by))){} else {
    leftover_columns <- seq(from = sum(lengths(collapse_by))+1, to = ncol(cell_annot))
    compressed <- cbind(compressed, cell_annot[,leftover_columns, drop = FALSE])}

  return(compressed)
}
