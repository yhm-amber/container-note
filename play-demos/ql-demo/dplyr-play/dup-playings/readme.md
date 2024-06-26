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
