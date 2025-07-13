
nvl_50416 = arrow::open_dataset("E:/repos/nvl_50416.parquet") |> dplyr::collect() |> data.table::setDT()
nvl_50416[, seq := link |> fs::path_file() |> as.integer()]
# 校验有没有缺失
nvl_50416$seq |> identical(seq(nrow(nvl_50416)))

nvl_50416[, seqq := seq |> stringr::str_pad(width = 4, pad = '0')]
nvl_50416[, path := .SD |> glue::glue_data("{seqq} {title}/readme")]
nvl_50416[, file_content := paste0(title, '\n\n~~~~~~~~~\n\n', content, '\n\n')]

'E:/repos/nv50416' |> magrittr::'%T>%'(fs::dir_create()) |> withr::with_dir({
	# nvl_50416[, .rec := {
	# 	fs::path_dir(path) |> fs::dir_create()
	# 	{file_content |> readr::write_file(path)} |> tryCatch(error = base::identity) -> x
	# 	x |> dplyr::coalesce(NA)
	# }]

	seq(nrow(nvl_50416)) |> purrr::map(~ {
		nvl_50416[.x, file_content] |> readr::write_file(
			nvl_50416[.x, path] |> magrittr::'%T>%'({fs::dir_create(fs::path_dir(.))}))
	})
})

