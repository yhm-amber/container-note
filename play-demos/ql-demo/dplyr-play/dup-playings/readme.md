
## Show Duped Rows

<sup>*from: [stachoverflow](https://stackoverflow.com/questions/6986657/find-duplicated-rows-based-on-2-columns-in-data-frame-in-r/78303407#78303407)*</sup>

The way of `df [df [, base::c ('key1', 'key2')] |> base::duplicated.data.frame () |> base::which ()]` could only show the surpluses part of the duplicates.

You can use this to filt rows which key(s) is appears more than once: 

~~~ r
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
function (df, ..., show.all = F) df %>% 
	dplyr::group_by (...) %>% 
	dplyr::mutate (
		.dup_count = dplyr::n (), 
		.dup_rownum = dplyr::row_number ()) %>% 
	(dplyr::ungroup) %>% 
	dplyr::mutate (
		.is_duplicated = .dup_rownum > 1, 
		.has_duplicated = .dup_count > 1) %>% 
	(\ (tb) if (show.all) tb else tb %>% 
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

Demo on *[webr](https://webr.r-wasm.org/latest)* and *[shinylive](https://shinylive.io/r/editor/#code=NobwRAdghgtgpmAXGAxgCzig1gWgCYCuADgE4D2A7gM4B0ASmADSpkQAuc7SYANgJYAjElBIBPAAQAKGFADmJPmzYkAlAB0IGgMQBycQAFo8cekxYA+oVKUq2vfrxwqKBUTZ9W4u14i6TGbHErfhQoDjxxcmpxAQksOFFJKhVxPggggDNvb304AA9YIh44Hz8AAzwM8QBSAD5q-zNLYiiqKXjRAEZGcQ6AJh6aIZUy7N97EjgMuEmIFCdSvRxxGTTEcWAoCCocADY+3c7dgBZdgE4AXUk0JSIqRAB6B6o2KGwyADcZjJ5KGhQyDAHgBHAhOdysKgPc4ADl2uwArAB2B4ZNJ4fDEEJhOAY1o4ARQKi4nCsHB9HAAngEGDbHBpfBhKA4DLCeD0iA4EjQg5HU5nLT7Q4nc7qcbiZbE4ooNjifLzNzrTZ045nBGdBGnTpXG5sO6PZ6vd5fEg-P4AoGg8EebYPVXqhEAZk6nQeeCKohIOClmDYOCgPB4OA+Ij4UAExR28rgbhZZC9bDQZGJlNYrzSJIZXxl8btao1Wq09oLhzFfkl8bYD3jjm5ImEEFkcCVWx2uxhSM6Z3bOtu9yeLzeWE+31+FH+gJBYJeNqhnT63ZFz0rpJItcZrxZbLgXJsBNEOBgBB47iKO6pNNt7c73Zhgo7XfbZb0GlM2Ga1miAF4fBkCHMIXSSRKkGIYeioJNxwDHhxB-AAxFJKhqeofDUNh3R4T1EEQeQyGIcxYikIYaBSOoGg0NCMKwxAj1eDgpAotg0JoKxzABf9ZR-KiSGwoCVB6RjmNYqIIBpWCgg9HjECicxRJgAQZikFRSJQxjgMk7D-1w4gVPIzR0I0miCDokpJEEtgaD4KgP2xcJxJY-CRLE2pxG6VCmIstAiRsvhQjsn8HKINi8PYcQXM6XT3LMtQpDYAQUj4KokkgmhoJSOK5R4YlxAysj3Mowy0RPRTJBoLzrOCXycTwSLzO47CfRlKRlncPBREathsNYOBzDIJKdDK7zKr83EdGU2r9PqxB6y2JsiOGZC9LQkAaAAX3EABuCjNHFAAROAYDIbbCWJbC8CZGhWVgUzGLoABJABhcSTubRAUAY-S0J0ABlToAEEaAABT+nQeh0P6ACEHqBkGwYAUTggBxGHQfytgfv+lGwch6HgdRnQEeRvH+Pc3acWeolXveszPvRvoAAYXRwendhwR16fEBnEHp+nufp1HzJ0BmmfppFmcdTneZ5vmBdpoXGc6Zmxfp45Jb5mWBLl4XFdF5mETV6WedltCvu1pXxYNqX+c1k26YV82VctmWScYgB5IhOHEwc2HuaT-0SqQIC-XYehgNIvwZ0OoDyL92bFE39JSHAXMqbakLyt8LCsVopHuh6ejJjgVDAVaLiAA)*.

