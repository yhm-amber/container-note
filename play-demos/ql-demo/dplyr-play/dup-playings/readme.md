
## Show Duped Rows

<sup>*duplicate from: [stachoverflow answer](https://stackoverflow.com/questions/6986657/find-duplicated-rows-based-on-2-columns-in-data-frame-in-r/78303407#78303407)*</sup>

The way of `df [df [, base::c ('key1', 'key2')] |> base::duplicated.data.frame () |> base::which ()]` could only show the surpluses part of the duplicates.

You can use this to filt rows which key(s) is appears more than once: 

~~~ r
library (magrittr)

#' @name check_duprows
#' @description 
#' 
#' check duplicated rows by key(s) in df
#' 
#' @example 
#' `df %>% check_duprows (key1, key2, ...)`
#' 
#' @references 
#' - main: [ans-62616469](https://stackoverflow.com/questions/6986657/find-duplicated-rows-based-on-2-columns-in-data-frame-in-r/62616469#62616469)
#' - select except: [ans-49515461](https://stackoverflow.com/questions/49515311/dplyr-select-all-variables-except-for-those-contained-in-vector/49515461#49515461)
#' - sort/order/arrange: [ans-6871968](https://stackoverflow.com/questions/1296646/sort-order-data-frame-rows-by-multiple-columns/6871968#6871968)
#' 
check_duprows = 
function (df, ..., .show_all = F) df %>% 
	dplyr::group_by (...) %>% 
	dplyr::mutate (
		.dup_count = dplyr::n (), 
		.dup_rownum = dplyr::row_number ()) %>% 
	(dplyr::ungroup) %>% 
	dplyr::mutate (
		.is_duplicated = .dup_rownum > 1, 
		.has_duplicated = .dup_count > 1) %>% 
	(\ (tb) if (.show_all) tb else tb %>% 
		dplyr::filter (.has_duplicated) %>% 
		dplyr::select (- tidyselect::one_of ('.has_duplicated'))) %>% 
	dplyr::arrange (...) %>% 
	{.} ;
~~~

Then just use like: 

~~~ r
df %>% check_duprows (key1, key2, ...)
~~~

Such as: 

~~~ r
base::data.frame (
	
	RIC = base::c (
		'S1A.PA', 'ABC.PA', 'EFG.PA', 
		'S1A.PA', 'ABC.PA', 'EFG.PA'), 
	Date = base::c (
		'2011-06-30 20:00:00', 
		'2011-07-03 20:00:00', 
		'2011-07-04 20:00:00', 
		'2011-07-05 20:00:00', 
		'2011-07-03 20:00:00', 
		'2011-07-04 20:00:00'), 
	Open = stats::runif (n=6, min=20, max=30)
	
	) -> df

df %>% check_duprows (RIC, Date)
~~~
And you can also define a uniquer by this function:  

~~~ R
unique_duprows = 
function (df, ...) df %>% 
	check_duprows(..., .show_all = T) %>% 
	dplyr::filter(!.is_duplicated) %>% 
	dplyr::select(- tidyselect::one_of (
		'.has_duplicated', 
		'.is_duplicated', 
		'.dup_count', 
		'.dup_rownum')) %>% 
	{.} ;

df %>% dplyr::arrange (Open) %>% unique_duprows (RIC, Date)
~~~

*It's just like a `distinct` finction !!*

Demo on *[webr](https://webr.r-wasm.org/latest)* and *[shinylive](https://shinylive.io/r/editor/#code=NobwRAdghgtgpmAXGAxgCzig1gWgCYCuADgE4D2A7gM4B0ASmADSpkQAuc7SYANgJYAjElBIBPAAQAKGFADmJPmzYkAlAB0IGgMQBycQAFo8cekxYA+oVKUq2vfrxwqKBUTZ9W4u14i6TGbHErfhQoDjxxcmpxAQksOFFJKhVxPggggDNvb304AA9YIh44Hz8AAzwM8QBSAD5q-zNLYiiqKXjRAEZGcQ6AJh6aIZUy7N97EjgMuEmIFCdSvRxxGTTEcWAoCCocADY+3c7dgBZdgE4AXUk0JSIqRAB6B6o2KGwyADcZjJ5KGhQyDAHgBHAhOdysKgPc4ADl2uwArAB2B4ZNJ4fDEEJhOAY1o4ARQKi4nCsHB9HAAngEGDbHBpfBhKA4DLCeD0iA4EjQg5HU5nLT7Q4nc7qcbiZbE4ooNjifLzNzrTZ045nBGdBGnTpXG5sO6PZ6vd5fEg-P4AoGg8EebYPVXqhEAZk6nQeeCKohIOClmDYOCgPB4OA+Ij4UAExR28rgbhZZC9bDQZGJlNYrzSJIZXxl8btao1Wq09oLhzFfkl8bYD3jjm5ImEEFkcCVWx2uxhSM6Z3bOtu9yeLzeWE+31+FH+gJBYJeNqhnT63ZFz0rpJItcZrxZbLgXJsBNEOBgBB47iKO6pNNt7c73Zhgo7XfbZb0GlM2Ga1miAF4fBkCHMIXSSRKkGIZBioJMKHMAMeHEH8ADEUkqGp6h8NQ2HdHhPUQRB5DIYhzFiKQhhoFI6gaDR0Mw7DECPV4OCkSi2HQmgrHMAF-1lH9qJIHCgJUHomJYtioggGk4KCD1eMQKJzDEmABBmKQVDI1CmOAqScP-PDiFUijNAwzTaIIeiSkkIS2BoPgqA-bFwgk1iCNE8TanEbo0OYyy0CJWy+FCeyf0coh2Pw9hxFczo9I88y1CkNgBBSPgqkkGgIMoaDAxSeK5R4YlxGy8iPKooy0RPJSUu8mzgj8nE8CiiyeJwn0ZSkZZ3DwURmrYHDWDgcwyGSnQaEq3z-NxHQVPqgzGsQestibYjhhQ-T0JAGgAF9xAAbkozQ9r8AAROAYDIXbCWJHC8CZGhWVgMyhIMugAEkAGEJPO5tEBQRiDPQnQAGVOgAQRoAAFIGdB6HQgYAIResGIahgBReCAHEEchoq2AB4GMah2H4fBzGdBR9GiYEjyDpxd6iU+77zN+7G+gABhdHBmd2HBHWZ8QWcQZnmf55nMYsnQWbZ5mkXZx1ecFgWhZFxmxdZzp2al5njlloWFcEpXxdVyX2YRLX5YFxX0L+-W1elk25eF3WLaZlXrY122FYppiAHkiE4CTBzYe4ZP-JKpAgL9dh6GA0i-FnI6gPIv25sULYMlIcFcypduQwq3wsKxWikZ6Xp6KmOGT-a9AAWXjOBduDq0PwLn8ND-ACbSkEDxBIpCqkKpjc8bmwUrAru0qgmCJIAFSm4qsOk0qOBISQAEIrKqrEavCGfDLnpq4GlNhJDavgOq6nqID6gafsdoaRuqsa8HNzyhus0baqfv6gpCziP+xr-nJgBNbea1No7T2tnVCM05qNjMt7TgUV65gkHtESQRcS44nLrtMA60LhAA)*.

