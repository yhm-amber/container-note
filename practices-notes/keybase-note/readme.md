用前提醒：

- KBFS 是用起来很酷，但它也是一个又会消耗本地存储又得网络带宽足够才能工作的东西。
- 如果是存入大文件、网络又质量很差，你可能复制一半，它网络断了就报个错说系统资源不足，其实就是因为网不好所以你的 KBFS 文件系统就不提供服务了而已，但对于正常桌面软件来说这就会被视为硬件 IO 故障，工作就中断了，但是你复制了一半的大文件，就会落在你的 KBFS 里头，你还得等网好了才能清它，而且这个由于传输中断所以根本没法用的废了的文件还会被脑残的 KBFS 竭尽全力挤占你的网络带宽来把它加密并上传给 Keybase 的服务端 …… (更可怕的是你删除一个文件，没反应，你不停地在他们那个界面上点删除，等网络好一些了，你会发现不止这个坏文件被删除了，本不应该被删除的也很大的好不容易才传上去了的，也被删了 …… )
  
  —— 所以，这玩意真的只适合小文件。大文件也不是不行，就是对网络质量要求过大，稍微一个不稳定，重来还是次要的，断了不能续传的废文件还要占用带宽，你将会什么事都做不了还要消耗额外一笔本不用消耗的成本！

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
  



