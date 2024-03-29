# For RSDA package
tbl_subset_col <- function(x, j, j_arg) {
  if (is.null(j)) return(x)

  j <- vectbl_as_col_location(j, length(x), names(x), j_arg = j_arg, assign = FALSE)

  if (anyNA(j)) {
    abort_na_column_index(which(is.na(j)))
  }

  xo <- .subset(x, j)
  if (anyDuplicated(j)) {
    xo <- set_repaired_names(xo, repair_hint = FALSE, .name_repair = "minimal")
  }

  attr(xo, "row.names") <- .set_row_names(fast_nrow(x))
  class(xo) <- tibble_class
  xo
}
