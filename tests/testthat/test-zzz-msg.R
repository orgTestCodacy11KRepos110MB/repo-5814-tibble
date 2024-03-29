skip("All of them")

test_that("abort_enframe_value_null()", {
  expect_equal(
    abort_enframe_value_null(),
    "The `value` argument to `enframe()` cannot be NULL."
  )
})

test_that("abort_enframe_has_dim()", {
  expect_equal(
    abort_enframe_has_dim(Titanic),
    "`x` must not have more than one dimension. `length(dim(x))` must be zero or one, not 4."
  )
})

test_that("abort_1d_array_column()", {
  expect_equal(
    abort_1d_array_column(),
    "1d arrays are not supported in a tibble column."
  )
})

test_that("abort_unsupported_index()", {
  expect_equal(
    abort_unsupported_index(raw()),
    "Can't subset with `[` using an object of class raw."
  )
})

test_that("abort_na_column_index()", {
  expect_equal(
    abort_na_column_index(),
    "Can't use numeric NA as column index with `[`."
  )
})

test_that("abort_nonint_column_index()", {
  expect_equal(
    abort_nonint_column_index(2:3, 3:4 + 0.5),
    bullets(
      "Must use integers to index columns with `[`:",
      paste0("Position ", 2:3, " equals ", 3:4 + 0.5)
    )
  )
})

test_that("abort_small_column_index()", {
  expect_equal(
    abort_small_column_index(3, 2, -4),
    bullets(
      "Negative column indexes in `[` must match number of columns:",
      "`.data` has 3 columns",
      "Position 2 equals -4"
    )
  )
})

test_that("abort_large_column_index()", {
  expect_equal(
    abort_large_column_index(3, 2, 5),
    bullets(
      "Positive column indexes in `[` must match number of columns:",
      "`.data` has 3 columns",
      "Position 2 equals 5"
    )
  )
})

test_that("abort_mismatch_column_flag()", {
  expect_equal(
    abort_mismatch_column_flag(5, 3),
    bullets(
      "Length of logical index vector for `[` must equal number of columns (or 1):",
      "`.data` has 5 columns",
      "Index vector has length 3"
    )
  )
})

test_that("abort_na_column_flag()", {
  expect_equal(
    abort_na_column_flag(),
    "Can't use logical NA when selecting columns with `[`."
  )
})

test_that("abort_unknown_names()", {
  expect_equal(
    abort_unknown_names("a"),
    "Can't find column `a` in `.data`."
  )
  expect_equal(
    abort_unknown_names(c("b", "c")),
    "Can't find columns `b`, `c` in `.data`."
  )
  expect_equal(
    unell(abort_unknown_names(LETTERS)),
    "Can't find columns `A`, `B`, `C`, `D`, `E`, ... (and 21 more) in `.data`."
  )
})

test_that("abort_existing_names()", {
  expect_equal(
    abort_existing_names("a"),
    "Column `a` already exists in `.data`."
  )
  expect_equal(
    abort_existing_names(c("b", "c")),
    "Columns `b`, `c` already exist in `.data`."
  )
  expect_equal(
    unell(abort_existing_names(LETTERS)),
    "Columns `A`, `B`, `C`, `D`, `E`, ... (and 21 more) already exist in `.data`."
  )
})

test_that("abort_add_rows_to_grouped_df()", {
  expect_equal(
    abort_add_rows_to_grouped_df(),
    "Can't add rows to grouped data frames"
  )
})

test_that("abort_inconsistent_new_rows()", {
  expect_equal(
    abort_inconsistent_new_rows("a"),
    bullets(
      "New rows in `add_row()` must use columns that already exist:",
      "Can't find column `a` in `.data`."
    )
  )

  expect_equal(
    abort_inconsistent_new_rows(letters[2:3]),
    bullets(
      "New rows in `add_row()` must use columns that already exist:",
      "Can't find columns `b`, `c` in `.data`."
    )
  )

  expect_equal(
    unell(abort_inconsistent_new_rows(LETTERS)),
    bullets(
      "New rows in `add_row()` must use columns that already exist:",
      "Can't find columns `A`, `B`, `C`, `D`, `E`, ... (and 21 more) in `.data`."
    )
  )
})

test_that("abort_names_must_not_be_null()", {
  expect_equal(
    abort_names_must_be_non_null(repair_hint = TRUE),
    "The `names` must not be `NULL`.\nUse .name_repair to specify repair."
  )
  expect_equal(
    abort_names_must_be_non_null(repair_hint = FALSE),
    "The `names` must not be `NULL`."
  )
})

test_that("abort_names_must_have_length()", {
  expect_equal(
    abort_names_must_have_length(length = 5, n = 3),
    "The `names` must have length 3, not 5."
  )
})

test_that("abort_column_must_be_named()", {
  expect_equal(
    abort_column_must_be_named(1, repair_hint = TRUE),
    "Column 1 must be named.\nUse .name_repair to specify repair."
  )
  expect_equal(
    abort_column_must_be_named(2:3, repair_hint = TRUE),
    "Columns 2, 3 must be named.\nUse .name_repair to specify repair."
  )
  expect_equal(
    unell(abort_column_must_be_named(seq_along(letters), repair_hint = TRUE)),
    "Columns 1, 2, 3, 4, 5, ... (and 21 more) must be named.\nUse .name_repair to specify repair."
  )
  expect_equal(
    abort_column_must_be_named(4:6, repair_hint = FALSE),
    "Columns 4, 5, 6 must be named."
  )
})

test_that("abort_column_names_must_be_unique()", {
  expect_equal(
    abort_column_names_must_be_unique("a", repair_hint = FALSE),
    "Column name `a` must not be duplicated."
  )
  expect_equal(
    abort_column_names_must_be_unique(letters[2:3], repair_hint = TRUE),
    "Column names `b`, `c` must not be duplicated.\nUse .name_repair to specify repair."
  )
  expect_equal(
    unell(abort_column_names_must_be_unique(LETTERS, repair_hint = TRUE)),
    "Column names `A`, `B`, `C`, `D`, `E`, ... (and 21 more) must not be duplicated.\nUse .name_repair to specify repair."
  )
})

test_that("abort_column_names_must_be_syntactic()", {
  expect_equal(
    abort_column_names_must_be_syntactic("a", repair_hint = FALSE),
    "Column name `a` must be syntactic."
  )
  expect_equal(
    abort_column_names_must_be_syntactic(letters[2:3], repair_hint = TRUE),
    "Column names `b`, `c` must be syntactic.\nUse .name_repair to specify repair."
  )
  expect_equal(
    unell(abort_column_names_must_be_syntactic(LETTERS, repair_hint = TRUE)),
    "Column names `A`, `B`, `C`, `D`, `E`, ... (and 21 more) must be syntactic.\nUse .name_repair to specify repair."
  )
})

test_that("abort_column_scalar_type()", {
  expect_equal(
    abort_column_scalar_type("a", "environment"),
    bullets(
      "All columns in a tibble must be 1d or 2d objects:",
      "Column `a` is environment"
    )
  )

  expect_equal(
    abort_column_scalar_type(letters[2:3], c("name", "NULL")),
    bullets(
      "All columns in a tibble must be 1d or 2d objects:",
      "Column `b` is name",
      "Column `c` is NULL"
    )
  )

  expect_equal(
    abort_column_scalar_type(LETTERS, letters),
    bullets(
      "All columns in a tibble must be 1d or 2d objects:",
      paste0("Column `", LETTERS, "` is ", letters)
    )
  )
})

test_that("abort_time_column_must_be_posixct()", {
  expect_equal(
    abort_time_column_must_be_posixct("a"),
    "Column `a` is a date/time and must be stored as POSIXct, not POSIXlt."
  )
  expect_equal(
    abort_time_column_must_be_posixct(letters[2:3]),
    "Columns `b`, `c` are dates/times and must be stored as POSIXct, not POSIXlt."
  )
  expect_equal(
    unell(abort_time_column_must_be_posixct(LETTERS)),
    "Columns `A`, `B`, `C`, `D`, `E`, ... (and 21 more) are dates/times and must be stored as POSIXct, not POSIXlt."
  )
})

test_that("abort_inconsistent_cols()", {
  expect_equal(
    abort_inconsistent_cols(
      10,
      letters[1:3],
      c(4, 4, 3),
      "`uvw` argument"
    ),
    bullets(
      "Tibble columns must have consistent lengths, only values of length one are recycled:",
      "Length 10: Requested with `uvw` argument",
      "Length 3: Column `c`",
      "Length 4: Columns `a`, `b`"
    )
  )

  expect_equal(
    abort_inconsistent_cols(
      10,
      letters[1:3],
      c(2, 2, 3),
      "`xyz` argument"
    ),
    bullets(
      "Tibble columns must have consistent lengths, only values of length one are recycled:",
      "Length 10: Requested with `xyz` argument",
      "Length 2: Columns `a`, `b`",
      "Length 3: Column `c`"
    )
  )

  expect_equal(
    abort_inconsistent_cols(
      NULL,
      letters[1:3],
      c(2, 2, 3),
      "`xyz` argument"
    ),
    bullets(
      "Tibble columns must have consistent lengths, only values of length one are recycled:",
      "Length 2: Columns `a`, `b`",
      "Length 3: Column `c`"
    )
  )
})

test_that("abort_inconsistent_new_cols()", {
  expect_equal(
    abort_inconsistent_new_cols(10, data.frame(a = 1:2)),
    bullets(
      "New columns in `add_column()` must be consistent with `.data`:",
      "`.data` has 10 rows",
      "New column contributes 2 rows"
    )
  )

  expect_equal(
    abort_inconsistent_new_cols(1, data.frame(a = 1:3, b = 2:4)),
    bullets(
      "New columns in `add_column()` must be consistent with `.data`:",
      "`.data` has 1 row",
      "New columns contribute 3 rows"
    )
  )
})

test_that("abort_duplicate_new_cols()", {
  expect_equal(
    abort_duplicate_new_cols("a"),
    bullets(
      "Can't add duplicate columns with `add_column()`:",
      "Column `a` already exists in `.data`."
    )
  )

  expect_equal(
    abort_duplicate_new_cols(letters[2:3]),
    bullets(
      "Can't add duplicate columns with `add_column()`:",
      "Columns `b`, `c` already exist in `.data`."
    )
  )

  expect_equal(
    unell(abort_duplicate_new_cols(LETTERS)),
    bullets(
      "Can't add duplicate columns with `add_column()`:",
      "Columns `A`, `B`, `C`, `D`, `E`, ... (and 21 more) already exist in `.data`."
    )
  )
})

test_that("abort_both_before_after()", {
  expect_equal(
    abort_both_before_after(),
    "Can't specify both `.before` and `.after`."
  )
})

test_that("abort_already_has_rownames()", {
  expect_equal(
    abort_already_has_rownames(),
    "`df` must be a data frame without row names in `column_to_rownames()`."
  )
})

test_that("abort_already_has_rownames()", {
  expect_equal(
    abort_as_tibble_needs_rownames(),
    "Object passed to `as_tibble()` must have row names if the `rownames` argument is set."
  )
})

test_that("abort_glimpse_infinite_width()", {
  expect_equal(
    abort_glimpse_infinite_width(),
    "`glimpse()` requires a finite value for the `width` argument."
  )
})

test_that("abort_tribble_needs_columns()", {
  expect_equal(
    abort_tribble_needs_columns(),
    "`tribble()` needs to specify at least one column using the `~name` syntax."
  )
})

test_that("abort_tribble_lhs_column_syntax()", {
  expect_equal(
    abort_tribble_lhs_column_syntax(quote(lhs)),
    bullets(
      "All column specifications in `tribble()` must use the `~name` syntax.",
      "Found `lhs` on the left-hand side of `~`."
    )
  )
})

test_that("abort_tribble_rhs_column_syntax()", {
  expect_equal(
    abort_tribble_rhs_column_syntax(quote(a + b)),
    bullets(
      'All column specifications in `tribble()` must use the `~name` or `~"name"` syntax.',
      "Found `a + b` on the right-hand side of `~`."
    )
  )
})

test_that("abort_tribble_non_rectangular()", {
  expect_equal(
    abort_tribble_non_rectangular(5, 17),
    bullets(
      "`tribble()` must be used with rectangular data:",
      "Found 5 columns.",
      "Found 17 cells.",
      "17 is not an integer multiple of 5."
    )
  )
})

test_that("abort_frame_matrix_list()", {
  expect_equal(
    abort_frame_matrix_list(2:4),
    bullets(
      "All values in `frame_matrix()` must be atomic:",
      "Found list-valued elements at positions 2, 3, 4."
    )
  )
})

test_that("abort_name_repair_arg()", {
  expect_equal(
    abort_name_repair_arg(),
    "The `.name_repair` argument must be a string or a function that specifies the name repair strategy."
  )
})

test_that("abort_new_tibble_must_be_list()", {
  expect_equal(
    abort_new_tibble_must_be_list(),
    "Must pass a list as `x` argument to `new_tibble()`."
  )
})

test_that("abort_new_tibble_needs_nrow()", {
  expect_equal(
    abort_new_tibble_needs_nrow(),
    "Must pass a scalar integer as `nrow` argument to `new_tibble()`."
  )
})
