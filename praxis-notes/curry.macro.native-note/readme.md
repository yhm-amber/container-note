[src/gh]: https://github.com/AlienKevin/curry-macro.git "(Rust) Have fun currying using Rust's native closure syntax"

[🦀 src][src/gh]

It's just a: 

~~~ rust
macro_rules! curry 
(
	// Simplest form, without any type annotations.
	(|$first_arg:ident $(, $arg:ident )*| 
		$function_body:expr) => 
	{
		move |$first_arg| 
		$(move |$arg|)* 
		{ $function_body } ;
	} ;
	
	// With input type annotations
	(|$first_arg:ident:$first_arg_type:ty $(, $arg:ident:$arg_type:ty )*| 
		$function_body:expr) => 
	{
		move |$first_arg:$first_arg_type| 
		$(move |$arg:$arg_type|)* 
		{ $function_body } ;
	} ;
	
	// With input and return type annotations and a block as function body
	(|$first_arg:ident:$first_arg_type:ty $(, $arg:ident:$arg_type:ty )*| -> $ret_type:ty $function_body:block) => 
	{
		move |$first_arg:$first_arg_type| 
		$(move |$arg:$arg_type|)* -> $ret_type 
		{ $function_body } ;
	} ;
);
~~~
