[src/gh]: https://github.com/AlienKevin/curry-macro.git "(Rust) Have fun currying using Rust's native closure syntax"

[🦀 src][src/gh]

It's just a: 

~~~ rust
macro_rules! curry 
(
	/* Simplest form, without any type annotations. */
	/* assert_eq! (4, curry! (|a, b, c, d| a + b - c - d) (3) (4) (1) (2)); */
	( | $head:ident 
	    $(, $tail:ident )* | 
		$body:expr ) => 
	{
		  move |$head| 
		$(move |$tail|)* 
		{ $body } 
	} ;
	
	/* With input type annotations and a expr/block as function body */
	/* assert_eq! (4, curry! (|a: u8, b: u8, c: u8, d: u8| a + b - c - d) (3) (4) (1) (2)); */
	( | $head:ident:$tipo:ty 
	    $(, $tail:ident:$tipos:ty )* | 
		$body:expr ) => 
	{
		  move |$head:$tipo| 
		$(move |$tail:$tipos|)* 
		{ $body } 
	} ;
	
	/* With input and return type annotations and a block as function body */
	/* assert_eq! (4, curry! (|a: u8, b: u8, c: u8, d: u8| -> u8 { a + b - c - d }) (3) (4) (1) (2)); */
	( | $head:ident:$tipo:ty 
	    $(, $tail:ident:$tipos:ty )* | 
		-> $rendre:ty $body:block ) => 
	{
		  move |$head:$tipo| 
		$(move |$tail:$tipos|)* 
		-> $rendre { $body } 
	} ;
) ;
~~~

use: 

~~~ rust

fn main () 
{
	assert_eq! (4, curry! (|a, b, c, d| a + b - c - d) (3) (4) (1) (2));
	assert_eq! (4, curry! (|a: u8, b: u8, c: u8, d: u8| a + b - c - d) (3) (4) (1) (2));
	assert_eq! (4, curry! (|a: u8, b: u8, c: u8, d: u8| { let x = a + b - c - d ; x }) (3) (4) (1) (2));
	assert_eq! (4, curry! (|a: u8, b: u8, c: u8, d: u8| -> u8 { a + b - c - d }) (3) (4) (1) (2));
}
~~~

but have some trouble with other closure args: 

~~~ rust

fn main () 
{
	// let add = curry! (|a: u8, b: u8| -> u8 { a + b }) ;
	// assert_eq! (7, curry! (|f, a, b| f(a)(b)) (add) (3) (4)); //// error: cannot infer type
	
	let idiot: fn(u8) -> u8 = |a: u8| -> u8 {a} ;
	// assert_eq! (7, curry! (|a, b, c| c(a) + c(b)) (3) (4) (idiot)); //// error: cannot infer type
	assert_eq! (7, curry! (|a: u8, b: u8, c: fn(u8) -> u8| c(a) + c(b)) (3) (4) (idiot)); //// won't error ...
}
~~~

see: 
- [playground](https://play.rust-lang.org/?code=macro_rules%21+curry+%0A%28%0A%09%2F*+Simplest+form%2C+without+any+type+annotations.+*%2F%0A%09%2F*+assert_eq%21+%284%2C+curry%21+%28%7Ca%2C+b%2C+c%2C+d%7C+a+%2B+b+-+c+-+d%29+%283%29+%284%29+%281%29+%282%29%29%3B+*%2F%0A%09%28+%7C+%24head%3Aident+%0A%09++++%24%28%2C+%24tail%3Aident+%29*+%7C+%0A%09%09%24body%3Aexpr+%29+%3D%3E+%0A%09%7B%0A%09%09++move+%7C%24head%7C+%0A%09%09%24%28move+%7C%24tail%7C%29*+%0A%09%09%7B+%24body+%7D+%0A%09%7D+%3B%0A%09%0A%09%2F*+With+input+type+annotations+and+a+expr%2Fblock+as+function+body+*%2F%0A%09%2F*+assert_eq%21+%284%2C+curry%21+%28%7Ca%3A+u8%2C+b%3A+u8%2C+c%3A+u8%2C+d%3A+u8%7C+a+%2B+b+-+c+-+d%29+%283%29+%284%29+%281%29+%282%29%29%3B+*%2F%0A%09%28+%7C+%24head%3Aident%3A%24tipo%3Aty+%0A%09++++%24%28%2C+%24tail%3Aident%3A%24tipos%3Aty+%29*+%7C+%0A%09%09%24body%3Aexpr+%29+%3D%3E+%0A%09%7B%0A%09%09++move+%7C%24head%3A%24tipo%7C+%0A%09%09%24%28move+%7C%24tail%3A%24tipos%7C%29*+%0A%09%09%7B+%24body+%7D+%0A%09%7D+%3B%0A%09%0A%09%2F*+With+input+and+return+type+annotations+and+a+block+as+function+body+*%2F%0A%09%2F*+assert_eq%21+%284%2C+curry%21+%28%7Ca%3A+u8%2C+b%3A+u8%2C+c%3A+u8%2C+d%3A+u8%7C+-%3E+u8+%7B+a+%2B+b+-+c+-+d+%7D%29+%283%29+%284%29+%281%29+%282%29%29%3B+*%2F%0A%09%28+%7C+%24head%3Aident%3A%24tipo%3Aty+%0A%09++++%24%28%2C+%24tail%3Aident%3A%24tipos%3Aty+%29*+%7C+%0A%09%09-%3E+%24rendre%3Aty+%24body%3Ablock+%29+%3D%3E+%0A%09%7B%0A%09%09++move+%7C%24head%3A%24tipo%7C+%0A%09%09%24%28move+%7C%24tail%3A%24tipos%7C%29*+%0A%09%09-%3E+%24rendre+%7B+%24body+%7D+%0A%09%7D+%3B%0A%29+%3B%0A%0Afn+main+%28%29+%0A%7B%0A%09assert_eq%21+%284%2C+curry%21+%28%7Ca%2C+b%2C+c%2C+d%7C+a+%2B+b+-+c+-+d%29+%283%29+%284%29+%281%29+%282%29%29%3B%0A%09assert_eq%21+%284%2C+curry%21+%28%7Ca%3A+u8%2C+b%3A+u8%2C+c%3A+u8%2C+d%3A+u8%7C+a+%2B+b+-+c+-+d%29+%283%29+%284%29+%281%29+%282%29%29%3B%0A%09assert_eq%21+%284%2C+curry%21+%28%7Ca%3A+u8%2C+b%3A+u8%2C+c%3A+u8%2C+d%3A+u8%7C+%7B+let+x+%3D+a+%2B+b+-+c+-+d+%3B+x+%7D%29+%283%29+%284%29+%281%29+%282%29%29%3B%0A%09assert_eq%21+%284%2C+curry%21+%28%7Ca%3A+u8%2C+b%3A+u8%2C+c%3A+u8%2C+d%3A+u8%7C+-%3E+u8+%7B+a+%2B+b+-+c+-+d+%7D%29+%283%29+%284%29+%281%29+%282%29%29%3B%0A%09%0A%09%2F%2F+let+add+%3D+curry%21+%28%7Ca%3A+u8%2C+b%3A+u8%7C+-%3E+u8+%7B+a+%2B+b+%7D%29+%3B%0A%09%2F%2F+assert_eq%21+%287%2C+curry%21+%28%7Cf%2C+a%2C+b%7C+f%28a%29%28b%29%29+%28add%29+%283%29+%284%29%29%3B+%2F%2F%2F%2F+error%3A+cannot+infer+type%0A%09%0A%09let+idiot%3A+fn%28u8%29+-%3E+u8+%3D+%7Ca%3A+u8%7C+-%3E+u8+%7Ba%7D+%3B%0A%09%2F%2F+assert_eq%21+%287%2C+curry%21+%28%7Ca%2C+b%2C+c%7C+c%28a%29+%2B+c%28b%29%29+%283%29+%284%29+%28idiot%29%29%3B+%2F%2F%2F%2F+error%3A+cannot+infer+type%0A%09assert_eq%21+%287%2C+curry%21+%28%7Ca%3A+u8%2C+b%3A+u8%2C+c%3A+fn%28u8%29+-%3E+u8%7C+c%28a%29+%2B+c%28b%29%29+%283%29+%284%29+%28idiot%29%29%3B+%2F%2F%2F%2F+won%27t+error+...%0A%7D%0A)
- [short with gist](https://play.rust-lang.org/?gist=a1e90212b5f1a0d048b8be4fbbb5948b)
- [gist](https://gist.github.com/rust-play/a1e90212b5f1a0d048b8be4fbbb5948b)

and a issue: 
- [How to write the type annotation while I want to make a struct with a currying closure field ?](https://github.com/AlienKevin/curry-macro/issues/1)
