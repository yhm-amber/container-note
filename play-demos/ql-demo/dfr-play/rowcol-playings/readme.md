
## list to df demo


How to trans a list like `list(c("","a","b","c"),c("tom",'Q','W','E'),c("jerry",'A','S','D'))`: 

~~~~
[[1]]
[1] ""  "a" "b" "c"

[[2]]
[1] "tom" "Q"   "W"   "E"  

[[3]]
[1] "jerry" "A"     "S"     "D"    

~~~~

To a data frame like `data.frame(a=c('Q','A'),b=c('W','S'),c=c('E','D'),row.names=c("tom","jerry"))`: 

~~~~
      a b c
tom   Q W E
jerry A S D
~~~~

--------

### Define 

~~~ r
rowlst2df = 
\ (a) base::Reduce (
	
	f = \ (df, x) 
		{df [x %>% utils::head (1),] <- 
			x %>% utils::tail (-1); df}
	
	init = a %>% 
		utils::head (1) %>% 
		(base::unlist) %>% 
		utils::tail (-1) %>% 
		base::`names<-`(.,.) %>% 
		(base::as.list) %>% 
		(base::as.data.frame) %>% 
		{.[F,]}, 
	
	x = a %>% utils::tail (-1)) ;

# one use case
oscommand = 
\ (command) command %>% 
	base::system (intern = T) %>% 
	base::'names<-' (.,.) %>% 
	base::strsplit ("\\s+") %>% 
	rowlst2df ;
~~~

### Use

simple trans: 

~~~ r
list(c("","a","b","c"),c("tom",'Q','W','E'),c("jerry",'A','S','D')) %>% rowlst2df %>% identical (
	data.frame(a=c('Q','A'),b=c('W','S'),c=c('E','D'),row.names = c("tom","jerry")))
~~~

let the result of `free -b` show as df: 

~~~ r
"free -b" %>% 
	base::system (intern = T) %>% 
	base::'names<-' (.,.) %>% 
	base::strsplit ("\\s+") %>% 
	rowlst2df

"free -b" %>% oscommand
"free" %>% oscommand
~~~

### Inspirations

Inspired by this chunk

~~~ r
"free -b" %>% 
	base::system (intern = T) %>% 
	base::'names<-' (.,.) %>% 
	base::strsplit ("\\s+") %>% 
	(\ (a) base::Reduce (
		init = a %>% 
			utils::head (1) %>% 
			(base::unlist) %>% 
			utils::tail (-1) %>% 
			base::`names<-`(.,.) %>% 
			(base::as.list) %>% 
			(base::as.data.frame) %>% 
			{.[F,]}, 
		x = a %>% utils::tail (-1), 
		f = \ (df, x) 
			{df [x %>% utils::head (1),] <- 
				x %>% utils::tail (-1); df}))
	{.} ;
~~~

Codes also at [*shinylive demo*](https://shinylive.io/r/editor/#code=NobwRAdghgtgpmAXGAJnGB7AdAJTAGjAGMMIAXOcpMAYgHIACAAQBsBLIygZzgagHMADiwC0AZiwAGADoR6DWbPYAjAE5RVATwYAKGANVsyZVQEoA3IrmM0AMzYQ4s+bNUYA7iy5kATClsMALwKENLSulCmDMpQPIiIOHAoAK6cuopkGQHBYbr++AwAHlEZ0mQg-gzAhQwApAB8tQzJZGxe8QAWcFAougCMpvgAugwAPCIhZVNkNQ1NLW1c8WRQbboiA+YM-gC+BaWhrRBGQXx1jZOZZAvtiF09-VFzl2U6MXGIyRDs3k8XpddWrcVmsdBs-k0Ae84PEAAbQeBccawnRYfBYCEvMhvWIwxCxLA-MiYgE4j4ElBQFZYWzqeAkw5lEBYYAAMWGexehxqwSg53mQKWiBBLHWAyillC1maXAETmlVnkXDYMGEvBMUAgXCUbG8OiIOmkYCN+CNUBNRuUFuIRsGBqNZAwMBNdAAinR8HQAOoeugAUTodsNYAAVnBVFoXQBBX0AZV9ABFA5i3J5vH4As82GhyBwoKLDYdKdTabA4DooIEDW7fTHBsoqzpvXHA-giI3-YnW6msAi4FxTvawI7nQQjWGI5pbaYJQwaFU+iMACo4ACqfsVjBYcDIDDIXQYqn7yRYu4wAVhtLgvBEylhDC4HQ8fAH-kUYCvN6tYH5l2h8S4TRvHQXQHAoVQIFOJcGTKf9EDoPskRERhUXRGCyDg7xVC4YQTmDMIwi4ABqW1fwyVMvF8SpJWcGw4HsRxaJCDAuBIGB9AgXoclCcJ9SdDiUCiNiBLIw5MKAigYFA8hw0g4JoNE2DcXiBCyyQlC0QxRSMOUxAsJw9hd3wgjiNI55yI8SiMwYGjpWSWV+HlFxQg-I8vyNX8WOEzVeho1zrw854vP4nybKsWQwB2IYgA)

