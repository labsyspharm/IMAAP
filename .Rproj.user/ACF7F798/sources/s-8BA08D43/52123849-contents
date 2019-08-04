#' @title Cell type annotation
#' @description Based on the probability calculated for each celltype, a cell-type annotation is assigned to each cell.
#' @param cell_prob Probabilty of the expression of cell types calculated function- \code{\link{imaap_prob}}
#' @param cheat_sheet A CSV file listing the the markers that are used to define a cell type. It needs to follow the defined template.
#' @return Returns a cell type annotation for each cell at each level
#' @export

imaap_annotation <- function(cell_prob,cheat_sheet){
  # Split the dataframe
  if (any(grepl("Likely_", colnames(cell_prob)))){cell_prob = cell_prob[,-grep("Likely_", colnames(cell_prob))]} else {cell_prob = cell_prob}
  # Convert into factor
  cheat_sheet$Path <- factor(cheat_sheet$Path, levels = unique(cheat_sheet$Path))
  # Intialise dataframes
  cell_annotation = data.frame("cell_id" = row.names(cell_prob), "cell_order"= seq(from = 1, to = nrow(cell_prob)))
  sub_type_all = data.frame("cell_id" = row.names(cell_prob))

  #Loop
  print("Annotating cell types")
  for (i in 1: nlevels(cheat_sheet$Path)){
    row_id = list()

    # Define Cells (Rows)
    if(nchar(levels(cheat_sheet$Path)[i]) < 1){
      cells_of_interest = row.names(cell_prob)
    } else if (length(levels(cheat_sheet$Path)) == 1){
      cells_of_interest = row.names(cell_prob)
    } else if(levels(cheat_sheet$Path)[i] %in% colnames(sub_type_all)){
      # } else if(levels(meta$Path)[i] %in% unique(cell_annotation[,paste("Level", i-1)])){
      #cells_of_interest = row.names(subset(prob, marker == levels(meta$Path)[i]))
      for (j in 1: nrow(cell_annotation)){if (levels(cheat_sheet$Path)[i] %in% cell_annotation[j,]){row_id = unlist(c(row_id, as.character(cell_annotation$cell_id[j])))}}
      cells_of_interest = row_id
    } else if(levels(cheat_sheet$Path)[i] %in% unique(cell_annotation[,paste("Level", i-1)])){
      #cells_of_interest = row.names(subset(prob, marker == levels(cheat_sheet$Path)[i]))
      for (j in 1: nrow(cell_annotation)){if (levels(cheat_sheet$Path)[i] %in% cell_annotation[j,]){row_id = unlist(c(row_id, as.character(cell_annotation$cell_id[j])))}}
      cells_of_interest = row_id
    } else{print(paste(levels(cheat_sheet$Path)[i], "not found"))}

    # Define cell_types (Columns)
    scores_of_interest = subset(cheat_sheet, Path %in% levels(cheat_sheet$Path)[i])$cell_type
    # Create the dataframe of intrested cells and their cell types
    sub_type = cell_prob[cells_of_interest, scores_of_interest, drop = FALSE]
    sub_type[sub_type < 0] <- 0
    sub_type_all <- merge(sub_type_all, sub_type, by.x = "cell_id", by.y="row.names", all = TRUE)

    # Calculate Probability scores
    prob <- replace(sub_type/rowSums(sub_type), is.na(sub_type/rowSums(sub_type)), 0)
    prob$other <- 1- rowSums(prob)
    prob$marker <- colnames(prob)[apply(prob,1,which.max)]
    prob1 <- prob[,c("marker"),drop = FALSE]
    colnames(prob1) <- paste("Level", i)
    cell_annotation = merge(cell_annotation, prob1, by.x = "cell_id", by.y="row.names", all = TRUE)
    cell_annotation <- cell_annotation[order(cell_annotation$cell_order),]
  }
  return(cell_annotation)
}
