
[blog-4.1]: https://epage.github.io/blog/2023/01/clap-v4-1
[pic::logo.png]: https://raw.githubusercontent.com/clap-rs/clap/master/assets/clap.png

[docs]: http://docs.rs/clap
[repo]: https://github.com/clap-rs/clap.git

一个命令行参数解析器。

### 使用示例

在命令行工具的 `main.rs` 里这样：

~~~ rust
use clap::Parser;

/// Simple program to greet a person
#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args
{
   /// Name of the person to greet
   #[arg(short, long)]
   name: String,

   /// Number of times to greet
   #[arg(short, long, default_value_t = 1)]
   count: u8,
}

fn main()
{
   let args = Args::parse();

   for _ in 0..args.count
   {
       println!("Hello {}!", args.name)
   }
}
~~~

使用时就会这样：

~~~
$ demo --help
A simple to use, efficient, and full-featured Command Line Argument Parser

Usage: demo[EXE] [OPTIONS] --name <NAME>

Options:
  -n, --name <NAME>    Name of the person to greet
  -c, --count <COUNT>  Number of times to greet [default: 1]
  -h, --help           Print help
  -V, --version        Print version

$ demo --name Me
Hello Me!
~~~

看：它的帮助文档是根据每个选项模块上的注解和注释
自动生成的。因而，开发人员只需要写好对应的短的注释注解，
并对应地做好针对相应参数的功能即可。

Nushell 里面的自定义命令 (函数) 也是类似的思想。相比
起来， Rust 的 clap 看起来功能更全一点且足够便捷。

链接：

- [clap | Rust][docs]
- [clap-rs/clap | GitHub][repo]

[教程]: https://docs.rs/clap/latest/clap/_derive/_tutorial/index.html

更多见 [教程] 。
