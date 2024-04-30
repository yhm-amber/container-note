
#' @description 
#' 
#' 借助 View 获取元信息
#' 是在 CREATE AS 还不能创建分区表的 HIVE 引擎版本上
#' 达到这一目的的不得已的办法。
#' 
#' @examples
#' 
#' crossing_view_partitioner_dbi (
#'   partition.names = c('date','type'), 
#'   partition.querys = c('c','a % 8'), 
#'   from.table = 'meaningless') -> queries
#' 
#' CON %>% DBI::dbExecute ("create table meaningless as select 1 as a, '2' as b, CAST ('2024-02-29 11:22:33' AS DATETIME) as c")
#' CON %>% DBI::dbExecute (queries$ddl.clearview)
#' CON %>% DBI::dbExecute (queries$ddl.to.crossingview)
#' CON %>% (queries$ddl.to.table.gener) -> queries$ddl.to.table
#' CON %>% DBI::dbExecute (queries$ddl.cleartable)
#' CON %>% DBI::dbExecute (queries$ddl.to.table)
#' CON %>% DBI::dbExecute (queries$query.crossingview.to.table)
#' CON %>% DBI::dbGetQuery ("select * from partitioned_meaningless where date = CAST ('2024-02-29 11:22:33' AS DATETIME) and type = 1")
#' 
crossing_view_partitioner_dbi = 
function (
		partition.names, 
		partition.querys, 
		from.table = NA_character_, 
		from.query = paste ("SELECT * FROM", from.table), 
		to.prefix = "partitioned_", 
		to.viewprefix = "viewcrossing_", 
		to.table = paste0 (to.prefix, from.table), 
		to.crossingview = paste0 (to.viewprefix, to.table)) 
{
	paste (partition.querys, "AS", partition.names) %>% 
		paste (collapse = "\n, ") %>% 
		{.} -> ql.partitions ;
	
	from.query %>% 
		paste0 ("FROM (",.,")") %>% 
		paste ("SELECT *\n,", ql.partitions, .) %>% 
		paste ("create view", to.crossingview, "as", .) %>% 
		{.} -> ddl.to.crossingview ;
	
	to.table %>% 
		paste ('drop table if exists', .) %>% 
		{.} -> ddl.cleartable ;
	
	to.crossingview %>% 
		paste ('drop view if exists', .) %>% 
		{.} -> ddl.clearview ;
	
	(\ (CON) to.crossingview %>% 
		paste ("SELECT * FROM", .) %>% 
		DBI::dbSendQuery (CON, .) %>% 
		dbires_cross (DBI::dbColumnInfo) %>% 
		list (
			a = .[! .$name %in% partition.name,], 
			b = .[.$name %in% partition.name,]) %>% 
		lapply (\ (df) df$type %>% 
			r2sql_typetr %>% 
			paste (df$name, .) %>% 
			paste (collapse = "\n, ") %>% 
			paste ("(",.,")")) %>% 
		{paste (
			sep = " \n", 
			"CREATE TABLE", 
			to.table, .$a, 
			"PARTITIONED BY", .$b)}) %>% 
		{.} -> ddl.to.table.gener ;
	
	partition.names %>% 
		paste (collapse = "\n, ") %>% 
		{paste (
			sep = " \n", 
			"INSERT OVERWRITE TABLE", 
			to.table, 
			"PARTITION", 
			paste ("(",.,")"), 
			"", 
			"select * EXCEPT", 
			paste ("(",.,")"), 
			"", 
			paste (",",.), 
			"FROM", 
			to.crossingview)} %>% 
		{.} -> query.crossingview.to.table ;
	
	
	
	NA_character_ %>% 
		base::list (
			ddl.clearview = ddl.clearview, 
			ddl.to.crossingview = ddl.to.crossingview, 
			ddl.to.table.gener = ddl.to.table.gener, 
			ddl.cleartable = ddl.cleartable, 
			ddl.to.table = ., 
			query.crossingview.to.table = query.crossingview.to.table, 
			to.table = to.table) %>% 
		{.} %>% 
		return ;
} ;

#' @examples 
#' 
#' 比如 `CON %>% DBI::dbSendQuery ('select * from abc') %>% dbires_cross(DBI::dbFetch)`
#' 相当于 `CON %>% DBI::dbGetQuery ('select * from abc')`
#' 
#' 另可用其它如 `CON %>% DBI::dbSendQuery ('select * from abc') %>% dbires_cross(DBI::dbColumnInfo)`
#' 
dbires_cross = 
function (res, DBI_FUN, ...) res %>% 
	{DBI_FUN (., ... = ...) -> a; DBI::dbClearResult(.); a} %>% 
	{.} ;

#' @examples 
#' 
#' `"character" %>% r2sql_typetr`
#' `"BIGINT" %>% r2sql_typetr (sql2r = T)`
#' `c("character","integer") %>% r2sql_typetr`
#' 
r2sql_typetr = 
(\ (r2sql.typemap) 
function (
		classes, 
		sql2r = F, 
		f = \ (sql2r) if (sql2r) base::names else base::'('
		) classes  %>% 
	base::`names<-` (.,.) %>% 
	base::vapply (FUN = \ (cls) r2sql.typemap %>% 
		{f (!sql2r) (.[f(sql2r) (.) %>% toupper == cls %>% toupper])} %>%
		{.[length (.)]}, FUN.VALUE = "character")
) (base::c (
	
	CHAR = "character" ,
	VARCHAR = "character" ,
	STRING = "character" ,
	
	TINYINT = "integer" ,
	SMALLINT = "integer" ,
	INT = "integer" ,
	INTEGER = "integer" ,
	BIGINT = "numeric" ,
	
	DECIMAL = "numeric" ,
	NUMERIC = "numeric" ,
	FLOAT = "numeric" ,
	DOUBLE = "numeric" ,
	
	DATE = "Date" ,
	TIMESTAMP = "POSIXct" ,
	DATETIME = "POSIXct" ,
	
	ARRAY = "array" ,
	STRUCT = "list" ,
	
	BOOLEAN = "logical")) %>% 
	
	{.} ;




#' @description 
#' 
#' 借助 View 获取元信息
#' 是在 CREATE AS 还不能创建分区表的 HIVE 引擎版本上
#' 达到这一目的的不得已的办法。
#' 
#' 这个是对应于你有自定义数据库操作符的版本。
#' 
#' @examples
#' 
#' crossing_view_partitioner_customoperator (
#'   partition.names = c('date','type'), 
#'   partition.querys = c('c','a % 8'), 
#'   from.table = 'meaningless') -> queries
#' 
#' YourDBOperators$sql.executor ("create table meaningless as select 1 as a, '2' as b, CAST ('2024-02-29 11:22:33' AS DATETIME) as c")
#' YourDBOperators$sql.executor (queries$ddl.clearview)
#' YourDBOperators$sql.executor (queries$ddl.to.crossingview)
#' YourDBOperators$table.descer %>% (queries$ddl.to.table.gener) -> queries$ddl.to.table
#' YourDBOperators$sql.executor (queries$ddl.cleartable)
#' YourDBOperators$sql.executor (queries$ddl.to.table)
#' YourDBOperators$sql.executor (queries$query.crossingview.to.table)
#' YourDBOperators$sql.executor ("select * from partitioned_meaningless date = CAST ('2024-02-29 11:22:33' AS DATETIME) and type = 1")
#' 
crossing_view_partitioner_customoperator = 
function (
		partition.names, 
		partition.querys, 
		from.table = NA_character_, 
		from.query = paste ("SELECT * FROM", from.table), 
		to.prefix = "partitioned_", 
		to.viewprefix = "viewcrossing_", 
		to.table = paste0 (to.prefix, from.table), 
		to.crossingview = paste0 (to.viewprefix, to.table)) 
{
	paste (partition.querys, "AS", partition.names) %>% 
		paste (collapse = "\n, ") %>% 
		{.} -> ql.partitions ;
	
	from.query %>% 
		paste0 ("FROM (",.,")") %>% 
		paste ("SELECT *\n,", ql.partitions, .) %>% 
		paste ("create view", to.crossingview, "as", .) %>% 
		{.} -> ddl.to.crossingview ;
	
	to.table %>% 
		paste ('drop table if exists', .) %>% 
		{.} -> ddl.cleartable ;
	
	to.crossingview %>% 
		paste ('drop view if exists', .) %>% 
		{.} -> ddl.clearview ;
	
	(\ (DESCER) (DESCER (to.crossingview) $ columns) %>% 
		list (
			a = .[! .$names %in% partition.names,], 
			b = .[.$names %in% partition.names,]) %>% 
		lapply (\ (df) df %>% 
			{paste (.$names, .$types)} %>% 
			paste (collapse = "\n, ") %>% 
			paste ("(",.,")")) %>% 
		{paste (
			sep = " \n", 
			"CREATE TABLE", 
			to.table, .$a, 
			"PARTITIONED BY", .$b)}) %>% 
		{.} -> ddl.to.table.gener ;
	
	partition.names %>% 
		paste (collapse = "\n, ") %>% 
		{paste (
			sep = " \n", 
			"INSERT OVERWRITE TABLE", 
			to.table, 
			"PARTITION", 
			paste ("(",.,")"), 
			"", 
			"select * EXCEPT", 
			paste ("(",.,")"), 
			"", 
			paste (",",.), 
			"FROM", 
			to.crossingview)} %>% 
		{.} -> query.crossingview.to.table ;
	
	
	
	NA_character_ %>% 
		base::list (
			ddl.clearview = ddl.clearview, 
			ddl.to.crossingview = ddl.to.crossingview, 
			ddl.to.table.gener = ddl.to.table.gener, 
			ddl.cleartable = ddl.cleartable, 
			ddl.to.table = ., 
			query.crossingview.to.table = query.crossingview.to.table, 
			to.table = to.table) %>% 
		{.} %>% 
		return ;
} ;
