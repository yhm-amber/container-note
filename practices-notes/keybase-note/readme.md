
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
