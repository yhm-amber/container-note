
[git]: https://git.savannah.gnu.org/git/datamash.git
[repo]: https://git.savannah.gnu.org/gitweb/?p=datamash.git
[site]: https://gnu.org/software/datamash

- [datamash.git/summary | Savannah Git Hosting][repo]
- [datamash | GNU Project - Free Software Foundation][site]

[git]: 

- `git://git.savannah.gnu.org/datamash.git`
- `https://git.savannah.gnu.org/git/datamash.git`
- `ssh: USER@git.savannah.gnu.org:/srv/git/datamash.git`

> GNU datamash is a command-line program
>  which performs basic numeric, textual
>  and statistical operations on input
>  textual data files. 
> 
> GNU datamash 是一个命令行程序，
> 它对输入的文本数据文件执行基本的数字、
> 文本和统计操作。
> 
> ~~~ help
> Examples:
> 
> calculate the sum and mean of values 1 to 10:
> 
>   $ seq 10 | datamash sum 1 mean 1
>   55 5.5
> 
> group text file by one column and calculate
> mean and sample standard deviation on another,
> with automatic sorting and header line processing:
> 
>   $ datamash --sort --headers groupby 2 mean 3 sstdev 3 < scores_h.txt
>   GroupBy(Major)  mean(Score) sstdev(Score)
>   Arts            68.94       10.42
>   ...
> 
> file validation for pipeline automation and troubleshooting:
> 
>   $ datamash check < snp147Common.txt && echo ok || echo fail
>   15189820 lines, 26 fields
>   ok
> 
>   $ datamash check < tmp2.txt && echo ok || echo fail
>   line 3816 (7 fields):
>     chrY  9544432 9552871 NR_001534 0 - 0.5
>   line 3817 (6 fields):
>     chrY  9544432 9552871 NR_003592 0 -
>   datamash: check failed: line 3817 has 6 fields (previous line had 7)
>   fail
> 
> ~~~
> 

install: 

~~~ sh
: Termux 
pkg in -- datamash

: Conda
conda install -y -- datamash

: Debian
apt in -y -- datamash

: CentOS
yum install -y -- datamash

: ...
~~~
