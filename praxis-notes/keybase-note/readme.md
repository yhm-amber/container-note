用前提醒：

- KBFS 是用起来很酷，但它也是一个又会消耗本地存储又得网络带宽足够才能工作的东西。
- 如果是存入大文件、网络又质量很差，你可能复制一半，它网络断了就报个错说系统资源不足 —— 也就是本机会当作这个目录已经不存在了，此时在 KBFS 里已经有了一个同样大小的文件，但它是不可用的因为真正的复制并没走完进度。而最要命的事情在于，这个不正确的文件会在不知道什么时候你的网络好一些了的时候，就被当作正常文件一样向服务器上传（如果上传前还要加密则更要命），你会为一个你并不想上传的文件支付大量宽带流量、而且你明知如此也无法作出任何改变因为现在网络不好那个路径就不存在你就甚至无法把错误的文件删除，而这一切只是因为两件事：你向 `K:` 复制了一个大文件、并且复制途中网络断了 —— 如此轻易，一个潜在的难以挽回的巨大损失就出现了。 (更可怕的是，你删除一个文件，没反应，你不停地在他们那个界面上点删除，等网络好一些了，你会发现不止这个坏文件被删除了，本不应该被删除的也很大的好不容易才传上去了的，也被删了 …… )
  
  —— 所以，这玩意真的只适合小文件。大文件也不是不行，就是对网络质量要求过大，稍微一个不稳定，重来还是次要的，断了不能续传的废文件还要占用带宽，你将会什么事都做不了还要消耗额外一笔本不用消耗的成本！
  
  —— 除非，你有一个专门支持本地路径之间复制时能断点续传的工具。或者，它若要实现在 KBFS 上就是，文件大小要有两个大小：一个是应有大小、一个是当前大小，而且文件的元数据还要加四个属性：来源文件校验和、是否完成校验、完成校验日期、完成校验后是否存在新的追加。现在显然还没有这些，所以 KBFS 是并不完善的。
  


-----

[repo]: https://github.com/keybase/client.git
[site]: https://keybase.io
[tor]: http://keybase5wmilwokqirssclfnsqrjdsi7jdir5wy7y7iu3tanwmtp6oid.onion
[book]: https://book.keybase.io
[docs]: https://book.keybase.io/docs
[docs-kbfs]: https://book.keybase.io/docs/files
[docs-kbfs-spec]: https://book.keybase.io/docs/crypto/kbfs


Keybase: 

- [keybase/client | GitHub][repo]
- [Keybase][site] ([tor])
- [Keybase Book - Encryption for everything that matters][book]
- [Keybase Docs | Keybase Book][docs]

KBFS: 

- [*Introducing the Keybase Filesystem*][docs-kbfs]
- [*Crypto spec: the Keybase filesystem (KBFS)*][docs-kbfs-spec]


------

注意事项：

- 进入 KBFS 内的数据会占用用户目录的空间。以块 (加密) 的形式。
- 如果你用的是 Windows 或者没有将用户目录单独分区，那 250G 的数据将也会占用你的系统分区的空间 (应该是存在一个回收机制但我没找到对细节的说明) 。
- 可以尝试使用软链接的方式将相应目录的实际存放更改为数据盘。

软链接：

- Windows
  
  使用 Powershell ([参考](https://excitedspider.github.io/PowerShell%E5%88%9B%E5%BB%BA%E8%BD%AF%E7%A1%AC%E9%93%BE%E6%8E%A5)) ：
  
  ~~~ powershell
  cd ~\AppData\Local ; mv Keybase E:\ # 或者用某款图形界面做这件事
  cd ~\AppData\Local ; New-Item -Path Keybase -Type SymbolicLink -Value 'E:\Keybase'
  ~~~
  
- GNU/Linux
  
  (暂略)
  



