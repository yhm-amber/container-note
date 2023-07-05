ref: https://starship.rs/zh-cn/guide/  

## openeuler 22.03 LTS

### cargo

<pre>[root@openeuler ~]# dnf in cargo
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
[root@openeuler ~]# cargo install starship --locked
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#FF5555"><b>error</b></font><b>:</b> failed to fetch `https://github.com/rust-lang/crates.io-index`

Caused by:
  network failure seems to have happened
  if a proxy or similar is necessary `net.git-fetch-with-cli` may help here
  https://doc.rust-lang.org/cargo/reference/config.html#netgit-fetch-with-cli

Caused by:
  SSL error: received early EOF; class=Ssl (16); code=Eof (-20)
[root@openeuler ~]# ping github.com
PING github.com (192.30.255.112) 56(84) 字节的数据。
64 字节，来自 lb-192-30-255-112-sea.github.com (192.30.255.112): icmp_seq=1 ttl=42 时间=182 毫秒
64 字节，来自 lb-192-30-255-112-sea.github.com (192.30.255.112): icmp_seq=3 ttl=42 时间=180 毫秒
64 字节，来自 lb-192-30-255-112-sea.github.com (192.30.255.112): icmp_seq=4 ttl=42 时间=181 毫秒
64 字节，来自 lb-192-30-255-112-sea.github.com (192.30.255.112): icmp_seq=5 ttl=42 时间=181 毫秒
^C
--- github.com ping 统计 ---
已发送 6 个包， 已接收 4 个包, 33.3333% packet loss, time 5024ms
rtt min/avg/max/mdev = 180.295/180.914/181.891/0.600 ms
[root@openeuler ~]# cargo install starship --locked
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#FF5555"><b>error</b></font><b>:</b> failed to fetch `https://github.com/rust-lang/crates.io-index`

Caused by:
  network failure seems to have happened
  if a proxy or similar is necessary `net.git-fetch-with-cli` may help here
  https://doc.rust-lang.org/cargo/reference/config.html#netgit-fetch-with-cli

Caused by:
  SSL error: received early EOF; class=Ssl (16); code=Eof (-20)
[root@openeuler ~]# cargo install starship --locked
<font color="#55FF55"><b>    Updating</b></font> crates.io index
^C<font color="#55FFFF"><b>     Fetch</b></font> [===&gt;                     ]  16.73%, 8.89KiB/s                                       
[root@openeuler ~]# while ! cargo install starship --locked ;do echo :: $((++i));done
<font color="#55FFFF"><b>    Blocking</b></font> waiting for file lock on package cache
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#55FF55"><b>  Downloaded</b></font> starship v1.6.3
<font color="#55FF55"><b>  Downloaded</b></font> 1 crate (211.4 KB) in 7.14s
<font color="#55FF55"><b>  Installing</b></font> starship v1.6.3
<font color="#55FF55"><b>  Downloaded</b></font> clap_lex v0.1.1
<font color="#55FF55"><b>  Downloaded</b></font> clap_complete v3.1.2
<font color="#55FF55"><b>  Downloaded</b></font> path-slash v0.1.4
<font color="#55FF55"><b>  Downloaded</b></font> pkg-config v0.3.25
<font color="#55FF55"><b>  Downloaded</b></font> os_str_bytes v6.0.0
<font color="#55FF55"><b>  Downloaded</b></font> pest_meta v2.1.3
<font color="#55FF55"><b>  Downloaded</b></font> percent-encoding v2.1.0
<font color="#55FF55"><b>  Downloaded</b></font> pest_generator v2.1.3
<font color="#55FF55"><b>  Downloaded</b></font> polling v2.2.0
<font color="#55FF55"><b>  Downloaded</b></font> shadow-rs v0.11.0
<font color="#55FF55"><b>  Downloaded</b></font> semver v1.0.7
<font color="#55FF55"><b>  Downloaded</b></font> quote v1.0.17
<font color="#55FF55"><b>  Downloaded</b></font> pin-project-lite v0.2.8
<font color="#55FF55"><b>  Downloaded</b></font> pathdiff v0.2.1
<font color="#55FF55"><b>  Downloaded</b></font> concurrent-queue v1.2.2
<font color="#55FF55"><b>  Downloaded</b></font> clap_derive v3.1.7
<font color="#55FF55"><b>  Downloaded</b></font> const_format_proc_macros v0.2.22
<font color="#55FF55"><b>  Downloaded</b></font> clap v3.1.12
<font color="#55FF55"><b>  Downloaded</b></font> scopeguard v1.1.0
<font color="#55FF55"><b>  Downloaded</b></font> ppv-lite86 v0.2.16
<font color="#55FF55"><b>  Downloaded</b></font> rand_core v0.6.3
<font color="#55FF55"><b>  Downloaded</b></font> ryu v1.0.9
<font color="#55FF55"><b>  Downloaded</b></font> combine v4.6.3
<font color="#55FF55"><b>  Downloaded</b></font> ansi_term v0.12.1
<font color="#55FF55"><b>  Downloaded</b></font> rand v0.8.5
<font color="#55FF55"><b>  Downloaded</b></font> enumflags2_derive v0.7.4
<font color="#55FF55"><b>  Downloaded</b></font> const_format v0.2.22
<font color="#55FF55"><b>  Downloaded</b></font> regex v1.5.5
<font color="#55FF55"><b>  Downloaded</b></font> sys-info v0.9.1
<font color="#55FF55"><b>  Downloaded</b></font> zbus_names v2.1.0
<font color="#55FF55"><b>  Downloaded</b></font> serde_repr v0.1.7
<font color="#55FF55"><b>  Downloaded</b></font> which v4.2.5
<font color="#55FF55"><b>  Downloaded</b></font> utf8-width v0.1.6
<font color="#55FF55"><b>  Downloaded</b></font> os_info v3.2.0
<font color="#55FF55"><b>  Downloaded</b></font> starship-battery v0.7.9
<font color="#55FF55"><b>  Downloaded</b></font> quick-xml v0.22.0
<font color="#55FF55"><b>  Downloaded</b></font> uom v0.30.0
<font color="#55FF55"><b>  Downloaded</b></font> sha-1 v0.10.0
<font color="#55FF55"><b>  Downloaded</b></font> sha-1 v0.8.2
<font color="#55FF55"><b>  Downloaded</b></font> serde v1.0.136
<font color="#55FF55"><b>  Downloaded</b></font> tinyvec_macros v0.1.0
<font color="#55FF55"><b>  Downloaded</b></font> opaque-debug v0.2.3
<font color="#55FF55"><b>  Downloaded</b></font> async-lock v2.5.0
<font color="#55FF55"><b>  Downloaded</b></font> proc-macro-crate v1.1.3
<font color="#55FF55"><b>  Downloaded</b></font> serde_derive v1.0.136
<font color="#55FF55"><b>  Downloaded</b></font> strsim v0.10.0
<font color="#55FF55"><b>  Downloaded</b></font> sha1 v0.6.1
<font color="#55FF55"><b>  Downloaded</b></font> rand_chacha v0.3.1
<font color="#55FF55"><b>  Downloaded</b></font> rayon-core v1.9.2
<font color="#55FF55"><b>  Downloaded</b></font> url v2.2.2
<font color="#55FF55"><b>  Downloaded</b></font> termcolor v1.1.3
<font color="#55FF55"><b>  Downloaded</b></font> serde_json v1.0.79
<font color="#55FF55"><b>  Downloaded</b></font> ucd-trie v0.1.3
<font color="#55FF55"><b>  Downloaded</b></font> thiserror-impl v1.0.30
<font color="#55FF55"><b>  Downloaded</b></font> time v0.1.44
<font color="#55FF55"><b>  Downloaded</b></font> proc-macro-error-attr v1.0.4
<font color="#55FF55"><b>  Downloaded</b></font> thiserror v1.0.30
<font color="#55FF55"><b>  Downloaded</b></font> git2 v0.14.2
<font color="#55FF55"><b>  Downloaded</b></font> gethostname v0.2.3
<font color="#55FF55"><b>  Downloaded</b></font> unicase v2.6.0
<font color="#55FF55"><b>  Downloaded</b></font> static_assertions v1.1.0
<font color="#55FF55"><b>  Downloaded</b></font> shell-words v1.1.0
<font color="#55FF55"><b>  Downloaded</b></font> urlencoding v2.1.0
<font color="#55FF55"><b>  Downloaded</b></font> waker-fn v1.1.0
<font color="#55FF55"><b>  Downloaded</b></font> unicode-width v0.1.9
<font color="#55FF55"><b>  Downloaded</b></font> tinyvec v1.5.1
<font color="#55FF55"><b>  Downloaded</b></font> yaml-rust v0.4.5
<font color="#55FF55"><b>  Downloaded</b></font> version_check v0.9.4
<font color="#55FF55"><b>  Downloaded</b></font> unicode-bidi v0.3.7
<font color="#55FF55"><b>  Downloaded</b></font> textwrap v0.15.0
<font color="#55FF55"><b>  Downloaded</b></font> socket2 v0.4.4
<font color="#55FF55"><b>  Downloaded</b></font> proc-macro2 v1.0.36
<font color="#55FF55"><b>  Downloaded</b></font> terminal_size v0.1.17
<font color="#55FF55"><b>  Downloaded</b></font> slab v0.4.5
<font color="#55FF55"><b>  Downloaded</b></font> rust-ini v0.18.0
<font color="#55FF55"><b>  Downloaded</b></font> unicode-xid v0.2.2
<font color="#55FF55"><b>  Downloaded</b></font> typenum v1.15.0
<font color="#55FF55"><b>  Downloaded</b></font> sha1_smol v1.0.0
<font color="#55FF55"><b>  Downloaded</b></font> unicode-normalization v0.1.19
<font color="#55FF55"><b>  Downloaded</b></font> toml v0.5.9
<font color="#55FF55"><b>  Downloaded</b></font> regex-syntax v0.6.25
<font color="#55FF55"><b>  Downloaded</b></font> unicode-segmentation v1.9.0
<font color="#55FF55"><b>  Downloaded</b></font> pest v2.1.3
<font color="#55FF55"><b>  Downloaded</b></font> rayon v1.5.2
<font color="#55FF55"><b>  Downloaded</b></font> zvariant_derive v3.1.2
<font color="#55FF55"><b>  Downloaded</b></font> versions v4.1.0
<font color="#55FF55"><b>  Downloaded</b></font> toml_edit v0.14.2
<font color="#55FF55"><b>  Downloaded</b></font> process_control v3.4.0
<font color="#55FF55"><b>  Downloaded</b></font> syn v1.0.90
<font color="#55FF55"><b>  Downloaded</b></font> zvariant v3.1.2
<font color="#55FF55"><b>  Downloaded</b></font> zbus_macros v2.1.1
<font color="#55FF55"><b>  Downloaded</b></font> zbus v2.1.1
<font color="#55FF55"><b>  Downloaded</b></font> is_debug v1.0.1
<font color="#55FF55"><b>  Downloaded</b></font> byte-unit v4.0.14
<font color="#55FF55"><b>  Downloaded</b></font> async-recursion v0.3.2
<font color="#55FF55"><b>  Downloaded</b></font> cpufeatures v0.2.2
<font color="#55FF55"><b>  Downloaded</b></font> form_urlencoded v1.0.1
<font color="#55FF55"><b>  Downloaded</b></font> matches v0.1.9
<font color="#55FF55"><b>  Downloaded</b></font> digest v0.10.3
<font color="#55FF55"><b>  Downloaded</b></font> crypto-common v0.1.3
<font color="#55FF55"><b>  Downloaded</b></font> crossbeam-deque v0.8.1
<font color="#55FF55"><b>  Downloaded</b></font> block-buffer v0.10.2
<font color="#55FF55"><b>  Downloaded</b></font> either v1.6.1
<font color="#55FF55"><b>  Downloaded</b></font> lazycell v1.3.0
<font color="#55FF55"><b>  Downloaded</b></font> autocfg v1.1.0
<font color="#55FF55"><b>  Downloaded</b></font> cfg-if v1.0.0
<font color="#55FF55"><b>  Downloaded</b></font> byteorder v1.4.3
<font color="#55FF55"><b>  Downloaded</b></font> generic-array v0.14.5
<font color="#55FF55"><b>  Downloaded</b></font> num-integer v0.1.44
<font color="#55FF55"><b>  Downloaded</b></font> once_cell v1.10.0
<font color="#55FF55"><b>  Downloaded</b></font> bitflags v1.3.2
<font color="#55FF55"><b>  Downloaded</b></font> ahash v0.7.6
<font color="#55FF55"><b>  Downloaded</b></font> memchr v2.4.1
<font color="#55FF55"><b>  Downloaded</b></font> cc v1.0.73
<font color="#55FF55"><b>  Downloaded</b></font> aho-corasick v0.7.18
<font color="#55FF55"><b>  Downloaded</b></font> crossbeam-channel v0.5.4
<font color="#55FF55"><b>  Downloaded</b></font> hashbrown v0.11.2
<font color="#55FF55"><b>  Downloaded</b></font> open v2.1.1
<font color="#55FF55"><b>  Downloaded</b></font> fastrand v1.7.0
<font color="#55FF55"><b>  Downloaded</b></font> digest v0.8.1
<font color="#55FF55"><b>  Downloaded</b></font> futures-io v0.3.21
<font color="#55FF55"><b>  Downloaded</b></font> futures-task v0.3.21
<font color="#55FF55"><b>  Downloaded</b></font> futures-core v0.3.21
<font color="#55FF55"><b>  Downloaded</b></font> dunce v1.0.2
<font color="#55FF55"><b>  Downloaded</b></font> hex v0.4.3
<font color="#55FF55"><b>  Downloaded</b></font> generic-array v0.12.4
<font color="#55FF55"><b>  Downloaded</b></font> futures-sink v0.3.21
<font color="#55FF55"><b>  Downloaded</b></font> maplit v1.0.2
<font color="#55FF55"><b>  Downloaded</b></font> lazy_static v1.4.0
<font color="#55FF55"><b>  Downloaded</b></font> itoa v1.0.1
<font color="#55FF55"><b>  Downloaded</b></font> getrandom v0.2.6
<font color="#55FF55"><b>  Downloaded</b></font> memoffset v0.6.5
<font color="#55FF55"><b>  Downloaded</b></font> log v0.4.16
<font color="#55FF55"><b>  Downloaded</b></font> pin-utils v0.1.0
<font color="#55FF55"><b>  Downloaded</b></font> jobserver v0.1.24
<font color="#55FF55"><b>  Downloaded</b></font> linked-hash-map v0.5.4
<font color="#55FF55"><b>  Downloaded</b></font> async-trait v0.1.53
<font color="#55FF55"><b>  Downloaded</b></font> fake-simd v0.1.2
<font color="#55FF55"><b>  Downloaded</b></font> block-padding v0.1.5
<font color="#55FF55"><b>  Downloaded</b></font> atty v0.2.14
<font color="#55FF55"><b>  Downloaded</b></font> byte-tools v0.3.1
<font color="#55FF55"><b>  Downloaded</b></font> crossbeam-utils v0.8.8
<font color="#55FF55"><b>  Downloaded</b></font> heck v0.4.0
<font color="#55FF55"><b>  Downloaded</b></font> indexmap v1.8.1
<font color="#55FF55"><b>  Downloaded</b></font> num-traits v0.2.14
<font color="#55FF55"><b>  Downloaded</b></font> easy-parallel v3.2.0
<font color="#55FF55"><b>  Downloaded</b></font> dlv-list v0.3.0
<font color="#55FF55"><b>  Downloaded</b></font> dirs-sys-next v0.1.2
<font color="#55FF55"><b>  Downloaded</b></font> dirs-next v2.0.0
<font color="#55FF55"><b>  Downloaded</b></font> futures-lite v1.12.0
<font color="#55FF55"><b>  Downloaded</b></font> derivative v2.2.0
<font color="#55FF55"><b>  Downloaded</b></font> bytes v1.1.0
<font color="#55FF55"><b>  Downloaded</b></font> cache-padded v1.2.0
<font color="#55FF55"><b>  Downloaded</b></font> async-io v1.6.0
<font color="#55FF55"><b>  Downloaded</b></font> async-executor v1.4.1
<font color="#55FF55"><b>  Downloaded</b></font> async-task v4.2.0
<font color="#55FF55"><b>  Downloaded</b></font> chrono v0.4.19
<font color="#55FF55"><b>  Downloaded</b></font> minimal-lexical v0.2.1
<font color="#55FF55"><b>  Downloaded</b></font> pest_derive v2.1.0
<font color="#55FF55"><b>  Downloaded</b></font> crossbeam-epoch v0.9.8
<font color="#55FF55"><b>  Downloaded</b></font> itertools v0.10.3
<font color="#55FF55"><b>  Downloaded</b></font> notify-rust v4.5.8
<font color="#55FF55"><b>  Downloaded</b></font> parking v2.0.0
<font color="#55FF55"><b>  Downloaded</b></font> async-channel v1.6.1
<font color="#55FF55"><b>  Downloaded</b></font> nix v0.23.1
<font color="#55FF55"><b>  Downloaded</b></font> nom v7.1.1
<font color="#55FF55"><b>  Downloaded</b></font> ordered-stream v0.0.1
<font color="#55FF55"><b>  Downloaded</b></font> ordered-multimap v0.4.3
<font color="#55FF55"><b>  Downloaded</b></font> event-listener v2.5.2
<font color="#55FF55"><b>  Downloaded</b></font> num_cpus v1.13.1
<font color="#55FF55"><b>  Downloaded</b></font> block-buffer v0.7.3
<font color="#55FF55"><b>  Downloaded</b></font> hashbrown v0.12.0
<font color="#55FF55"><b>  Downloaded</b></font> enumflags2 v0.7.4
<font color="#55FF55"><b>  Downloaded</b></font> nix v0.24.1
<font color="#55FF55"><b>  Downloaded</b></font> futures-util v0.3.21
<font color="#55FF55"><b>  Downloaded</b></font> local_ipaddress v0.1.3
<font color="#55FF55"><b>  Downloaded</b></font> async-broadcast v0.3.4
<font color="#55FF55"><b>  Downloaded</b></font> proc-macro-error v1.0.4
<font color="#55FF55"><b>  Downloaded</b></font> idna v0.2.3
<font color="#55FF55"><b>  Downloaded</b></font> libc v0.2.121
<font color="#55FF55"><b>  Downloaded</b></font> libz-sys v1.1.5
<font color="#55FF55"><b>  Downloaded</b></font> libgit2-sys v0.13.2+1.4.2
<font color="#55FF55"><b>  Downloaded</b></font> 182 crates (11.0 MB) in 18.96s (largest was `libz-sys` at 1.5 MB)
<font color="#FF5555"><b>error</b></font><b>:</b> failed to compile `starship v1.6.3`, intermediate artifacts can be found at `/tmp/cargo-installVW5MeR`

Caused by:
  package `starship v1.6.3` cannot be built because it requires rustc 1.59 or newer, while the currently active rustc version is 1.57.0
:: 1
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#55FF55"><b>  Installing</b></font> starship v1.6.3
<font color="#FF5555"><b>error</b></font><b>:</b> failed to compile `starship v1.6.3`, intermediate artifacts can be found at `/tmp/cargo-install32amm3`

Caused by:
  package `starship v1.6.3` cannot be built because it requires rustc 1.59 or newer, while the currently active rustc version is 1.57.0
:: 2
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#55FF55"><b>  Installing</b></font> starship v1.6.3
<font color="#FF5555"><b>error</b></font><b>:</b> failed to compile `starship v1.6.3`, intermediate artifacts can be found at `/tmp/cargo-installA3LINs`

Caused by:
  package `process_control v3.4.0` cannot be built because it requires rustc 1.58.0 or newer, while the currently active rustc version is 1.57.0
:: 3
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#55FF55"><b>  Installing</b></font> starship v1.6.3
<font color="#FF5555"><b>error</b></font><b>:</b> failed to compile `starship v1.6.3`, intermediate artifacts can be found at `/tmp/cargo-installunoD1x`

Caused by:
  package `starship v1.6.3` cannot be built because it requires rustc 1.59 or newer, while the currently active rustc version is 1.57.0
:: 4
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#55FF55"><b>  Installing</b></font> starship v1.6.3
<font color="#FF5555"><b>error</b></font><b>:</b> failed to compile `starship v1.6.3`, intermediate artifacts can be found at `/tmp/cargo-installuzdrTZ`

Caused by:
  package `starship v1.6.3` cannot be built because it requires rustc 1.59 or newer, while the currently active rustc version is 1.57.0
:: 5
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#55FF55"><b>  Installing</b></font> starship v1.6.3
<font color="#FF5555"><b>error</b></font><b>:</b> failed to compile `starship v1.6.3`, intermediate artifacts can be found at `/tmp/cargo-installX5X0u8`

Caused by:
  package `starship v1.6.3` cannot be built because it requires rustc 1.59 or newer, while the currently active rustc version is 1.57.0
:: 6
<font color="#55FF55"><b>    Updating</b></font> crates.io index
<font color="#55FF55"><b>  Installing</b></font> starship v1.6.3
<font color="#FF5555"><b>error</b></font><b>:</b> failed to compile `starship v1.6.3`, intermediate artifacts can be found at `/tmp/cargo-installWmKqKL`

Caused by:
  package `starship v1.6.3` cannot be built because it requires rustc 1.59 or newer, while the currently active rustc version is 1.57.0
:: 7
<font color="#55FF55"><b>    Updating</b></font> crates.io index
^C
[root@openeuler ~]# </pre>
