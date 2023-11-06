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
		{ $function_body } 
	} ;
	
	// With input type annotations
	(|$first_arg:ident:$first_arg_type:ty $(, $arg:ident:$arg_type:ty )*| 
		$function_body:expr) => 
	{
		move |$first_arg:$first_arg_type| 
		$(move |$arg:$arg_type|)* 
		{ $function_body } 
	} ;
	
	// With input and return type annotations and a block as function body
	(|$first_arg:ident:$first_arg_type:ty $(, $arg:ident:$arg_type:ty )*| -> $ret_type:ty $function_body:block) => 
	{
		move |$first_arg:$first_arg_type| 
		$(move |$arg:$arg_type|)* -> $ret_type 
		{ $function_body } 
	} ;
);
~~~

use: 

~~~ rust
fn main () 
{
    assert_eq! (curry! (|a, b| a + b) (3) (4), 7);
    assert_eq! (curry! (|a: u8, b: u8| a + b) (3) (4), 7);
    assert_eq! (curry! (|a: u8, b: u8| -> u8 { a + b }) (3) (4), 7);
    assert_eq! (curry! (|a, b, c| a + b + c) (3) (4) (5), 12);
}
~~~

but can't play some more like: 

~~~ rust
let add = curry! (|a: u8, b: u8| -> u8 { a + b }) ;
assert_eq! (curry! (|f, a, b| f(a)(b)) (add) (3) (4), 7); /// error: cannot infer type
}
~~~

see: 
- [playground](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&code=macro_rules%21+curry+%0A%28%0A%09%2F%2F+Simplest+form%2C+without+any+type+annotations.%0A%09%28%7C%24first_arg%3Aident+%24%28%2C+%24arg%3Aident+%29*%7C+%0A%09%09%24function_body%3Aexpr%29+%3D%3E+%0A%09%7B%0A%09%09move+%7C%24first_arg%7C+%0A%09%09%24%28move+%7C%24arg%7C%29*+%0A%09%09%7B+%24function_body+%7D+%0A%09%7D+%3B%0A%09%0A%09%2F%2F+With+input+type+annotations%0A%09%28%7C%24first_arg%3Aident%3A%24first_arg_type%3Aty+%24%28%2C+%24arg%3Aident%3A%24arg_type%3Aty+%29*%7C+%0A%09%09%24function_body%3Aexpr%29+%3D%3E+%0A%09%7B%0A%09%09move+%7C%24first_arg%3A%24first_arg_type%7C+%0A%09%09%24%28move+%7C%24arg%3A%24arg_type%7C%29*+%0A%09%09%7B+%24function_body+%7D+%0A%09%7D+%3B%0A%09%0A%09%2F%2F+With+input+and+return+type+annotations+and+a+block+as+function+body%0A%09%28%7C%24first_arg%3Aident%3A%24first_arg_type%3Aty+%24%28%2C+%24arg%3Aident%3A%24arg_type%3Aty+%29*%7C+-%3E+%24ret_type%3Aty+%24function_body%3Ablock%29+%3D%3E+%0A%09%7B%0A%09%09move+%7C%24first_arg%3A%24first_arg_type%7C+%0A%09%09%24%28move+%7C%24arg%3A%24arg_type%7C%29*+-%3E+%24ret_type+%0A%09%09%7B+%24function_body+%7D+%0A%09%7D+%3B%0A%29%3B%0A%0Afn+main+%28%29+%0A%7B%0A++++assert_eq%21+%28curry%21+%28%7Ca%2C+b%7C+a+%2B+b%29+%283%29+%284%29%2C+7%29%3B%0A++++assert_eq%21+%28curry%21+%28%7Ca%3A+u8%2C+b%3A+u8%7C+a+%2B+b%29+%283%29+%284%29%2C+7%29%3B%0A++++assert_eq%21+%28curry%21+%28%7Ca%3A+u8%2C+b%3A+u8%7C+-%3E+u8+%7B+a+%2B+b+%7D%29+%283%29+%284%29%2C+7%29%3B%0A++++%0A++++assert_eq%21+%28curry%21+%28%7Ca%2C+b%2C+c%7C+a+%2B+b+%2B+c%29+%283%29+%284%29+%285%29%2C+12%29%3B%0A++++%0A++++let+add+%3D+curry%21+%28%7Ca%3A+u8%2C+b%3A+u8%7C+-%3E+u8+%7B+a+%2B+b+%7D%29+%3B%0A++++%2F%2F+assert_eq%21+%28curry%21+%28%7Cf%2C+a%2C+b%7C+f%28a%29%28b%29%29+%28add%29+%283%29+%284%29%2C+7%29%3B+%2F%2F%2F+error%3A+cannot+infer+type%0A%7D)
- [short with gist](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=36210d1fb36fb81b90a89c8a35829dd2)
- [gist](https://gist.github.com/rust-play/36210d1fb36fb81b90a89c8a35829dd2)
