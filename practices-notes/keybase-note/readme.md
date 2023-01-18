

------

注意事项：

- 进入 KBFS 内的数据会占用用户目录的空间。
- 如果你用的是 Windows 或者没有将用户目录单独分区，那 250G 的数据将也会占用你的系统分区的空间。
- 可以尝试使用软链接的方式将相应目录的实际存放更改为数据盘。

软链接：

- Windows
  
  使用 Powershell ([参考](https://excitedspider.github.io/PowerShell%E5%88%9B%E5%BB%BA%E8%BD%AF%E7%A1%AC%E9%93%BE%E6%8E%A5)) ：
  
  ~~~ powershell
  cd 
  ~~~
