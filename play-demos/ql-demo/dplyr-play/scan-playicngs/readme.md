### 取得累计值字段

~~~ R
scanover =
function (f)
function (accfield, row_number)
row_number |>
  lapply(seq) |>
  lapply(\ (n) accfield[n]) |>
  lapply(f) |>
  unlist() ;
~~~

例

~~~ r
# 当前环境中按照内存占用大小排序

data.table::data.table(name = ls(all.names = T)) |> 
  dtplyr::lazy_dt(immutable = F) |> 
  dplyr::mutate(size.expr = parse(text = glue::glue("utils::object.size({name})"))) |> 
  dplyr::mutate(size = Vectorize(eval)(size.expr)) |> 
  dplyr::mutate(size.expr = as.character(size.expr)) |> 
  dplyr::arrange(-size) |> 
  data.table::as.data.table() -> env.vars

# 增加累计计数字段
scanover = \ (f) \ (accfield, row_number) row_number |> lapply(seq) |> lapply(\ (n) accfield[n]) |> lapply(f) |> unlist()
sumover = scanover(sum) # 二者等价
dtplyr::lazy_dt(env.vars) |> 
  dplyr::arrange(+size) |> 
  dplyr::mutate(size_acc = scanover(sum)(size, dplyr::row_number())) |> 
  dplyr::arrange(-size) |> 
  data.table::as.data.table() -> env.vars

#' 用于：删除到剩余总占用小于指定值为止
dtplyr::lazy_dt(env.vars) |> 
  dplyr::mutate(rm.flag = size_acc > (2^3)^(2^3)*2^6) |> 
  dplyr::mutate(rm.expr = parse(text = glue::glue("rm({name})"))) |> 
  data.table::as.data.table() -> rm.vars

#' 用于：简单地删除大小大于指定值的占用
dtplyr::lazy_dt(env.vars) |> 
  dplyr::mutate(rm.flag = size > (2^6)^(2^2)) |> 
  dplyr::mutate(rm.expr = parse(text = glue::glue("rm({name})"))) |> 
  data.table::as.data.table() -> rm.vars

#' 执行删除
rm.vars[rm.flag == T,.(name)]$name |> rm (list = _)
gc()
~~~
