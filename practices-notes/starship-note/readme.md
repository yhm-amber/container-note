ref: https://starship.rs/zh-cn/guide/  

## cargo

<pre>[root@e3 ~]# dnf in cargo
Last metadata expiration check: 2:36:04 ago on 2022年05月20日 星期五 18时48分33秒.
Dependencies resolved.
====================================================================================================
 Package                   Architecture     Version                      Repository            Size
====================================================================================================
Installing:
 <font color="#55FF55"><b>cargo                    </b></font> x86_64           1.57.0-1.oe2203              everything           3.8 M
Installing dependencies:
 <font color="#55FF55"><b>llvm-libs                </b></font> x86_64           12.0.1-2.oe2203              OS                    23 M
 <font color="#55FF55"><b>rust                     </b></font> x86_64           1.57.0-1.oe2203              everything            24 M
 <font color="#55FF55"><b>rust-std-static          </b></font> x86_64           1.57.0-1.oe2203              everything            41 M

Transaction Summary
====================================================================================================
Install  4 Packages

Total download size: 91 M
Installed size: 378 M
Is this ok [y/N]: y
Downloading Packages:
(1/4): cargo-1.57.0-1.oe2203.x86_64.rpm                             257 kB/s | 3.8 MB     00:15    
(2/4): rust-1.57.0-1.oe2203.x86_64.rpm                              1.4 MB/s |  24 MB     00:16    
(3/4): llvm-libs-12.0.1-2.oe2203.x86_64.rpm                         1.1 MB/s |  23 MB     00:20    
(4/4): rust-std-static-1.57.0-1.oe2203.x86_64.rpm                   6.4 MB/s |  41 MB     00:06    
----------------------------------------------------------------------------------------------------
Total                                                               4.2 MB/s |  91 MB     00:21     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                            1/1 
  Installing       : rust-std-static-1.57.0-1.oe2203.x86_64                                     1/4 
  Installing       : llvm-libs-12.0.1-2.oe2203.x86_64                                           2/4 
  Installing       : rust-1.57.0-1.oe2203.x86_64                                                3/4 
  Installing       : cargo-1.57.0-1.oe2203.x86_64                                               4/4 
  Running scriptlet: cargo-1.57.0-1.oe2203.x86_64                                               4/4 
  Verifying        : llvm-libs-12.0.1-2.oe2203.x86_64                                           1/4 
  Verifying        : cargo-1.57.0-1.oe2203.x86_64                                               2/4 
  Verifying        : rust-1.57.0-1.oe2203.x86_64                                                3/4 
  Verifying        : rust-std-static-1.57.0-1.oe2203.x86_64                                     4/4 

Installed:
  cargo-1.57.0-1.oe2203.x86_64                llvm-libs-12.0.1-2.oe2203.x86_64                     
  rust-1.57.0-1.oe2203.x86_64                 rust-std-static-1.57.0-1.oe2203.x86_64               

Complete!
[root@e3 ~]# cargo install starship --locked
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#FF5555"><b>error</b></font><b>:</b> failed to fetch `https://github.com/rust-lang/crates.io-index`

Caused by:
  network failure seems to have happened
  if a proxy or similar is necessary `net.git-fetch-with-cli` may help here
  https://doc.rust-lang.org/cargo/reference/config.html#netgit-fetch-with-cli

Caused by:
  SSL error: received early EOF; class=Ssl (16); code=Eof (-20)
[root@e3 ~]# ping github.com
PING github.com (192.30.255.112) 56(84) 字节的数据。
64 字节，来自 lb-192-30-255-112-sea.github.com (192.30.255.112): icmp_seq=1 ttl=42 时间=182 毫秒
64 字节，来自 lb-192-30-255-112-sea.github.com (192.30.255.112): icmp_seq=3 ttl=42 时间=180 毫秒
64 字节，来自 lb-192-30-255-112-sea.github.com (192.30.255.112): icmp_seq=4 ttl=42 时间=181 毫秒
64 字节，来自 lb-192-30-255-112-sea.github.com (192.30.255.112): icmp_seq=5 ttl=42 时间=181 毫秒
^C
--- github.com ping 统计 ---
已发送 6 个包， 已接收 4 个包, 33.3333% packet loss, time 5024ms
rtt min/avg/max/mdev = 180.295/180.914/181.891/0.600 ms
[root@e3 ~]# cargo install starship --locked
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#FF5555"><b>error</b></font><b>:</b> failed to fetch `https://github.com/rust-lang/crates.io-index`

Caused by:
  network failure seems to have happened
  if a proxy or similar is necessary `net.git-fetch-with-cli` may help here
  https://doc.rust-lang.org/cargo/reference/config.html#netgit-fetch-with-cli

Caused by:
  SSL error: received early EOF; class=Ssl (16); code=Eof (-20)
[root@e3 ~]# cargo install starship --locked
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#55FFFF"><b>       Fetch</b></font> [===&gt;                     ]  16.73%, 8.89KiB/s    </pre>
