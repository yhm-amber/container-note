ref: https://mirrors.ustc.edu.cn/help/brew.git.html  
ref: https://brew.sh/  

## 安装

### 配置选项

执行这些，并把这些也添加到 `/etc/profile.d/env-brew.sh` 或 `~/.bash_profile` 中：

~~~ sh
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
~~~

不做替换的话应该是相当于这样：

~~~ sh
export HOMEBREW_BREW_GIT_REMOTE="https://github.com/Homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://github.com/Homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://github.com/Homebrew/homebrew-bundle.git"
~~~

### 安装

~~~ sh
/bin/bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
~~~

不支持使用 `root` 用户。

也不要 `sudo -u admin -- 命令` 这样子，这会导致环境变量应用不成功。

<details>

<summary>我的过程记录</summary>

<pre>[root@e2 ~]# echo &apos;
&gt; export HOMEBREW_BREW_GIT_REMOTE=&quot;https://ghproxy.com/https://github.com/Homebrew/brew&quot;
&gt; export HOMEBREW_CORE_GIT_REMOTE=&quot;^C
[root@e2 ~]# vi /etc/profile.d/env-brew.sh
[root@e2 ~]# cat /etc/profile.d/env-brew.sh
export HOMEBREW_BREW_GIT_REMOTE=&quot;https://mirrors.ustc.edu.cn/brew.git&quot;
export HOMEBREW_CORE_GIT_REMOTE=&quot;https://mirrors.ustc.edu.cn/homebrew-core.git&quot;
export HOMEBREW_BOTTLE_DOMAIN=&quot;https://mirrors.ustc.edu.cn/homebrew-bottles&quot;

export HOMEBREW_BREW_GIT_REMOTE=&quot;https://ghproxy.com/https://github.com/Homebrew/brew.git&quot;
export HOMEBREW_CORE_GIT_REMOTE=&quot;https://ghproxy.com/https://github.com/Homebrew/homebrew-core.git&quot;
export HOMEBREW_BOTTLE_DOMAIN=&quot;https://ghproxy.com/https://github.com/Homebrew/homebrew-bundle.git&quot;
[root@e2 ~]# . /etc/profile.d/env-brew.sh
[root@e2 ~]# 
[root@e2 ~]# /bin/bash -c &quot;$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)&quot;
You must install Git before installing Homebrew. See:
  <u style="text-decoration-style:single">https://docs.brew.sh/Installation</u>
[root@e2 ~]# dnf in git
Last metadata expiration check: 2:08:49 ago on 2022年05月20日 星期五 14时08分37秒.
Dependencies resolved.
====================================================================================================
 Package                     Architecture      Version                          Repository     Size
====================================================================================================
Installing:
 <font color="#55FF55"><b>git                        </b></font> x86_64            2.33.0-1.oe2203                  OS            6.0 M
Installing dependencies:
 <font color="#55FF55"><b>perl-Error                 </b></font> noarch            1:0.17029-2.oe2203               OS             31 k
 <font color="#55FF55"><b>perl-Git                   </b></font> noarch            2.33.0-1.oe2203                  OS             28 k
 <font color="#55FF55"><b>perl-TermReadKey           </b></font> x86_64            2.38-2.oe2203                    OS             25 k

Transaction Summary
====================================================================================================
Install  4 Packages

Total download size: 6.0 M
Installed size: 26 M
Is this ok [y/N]: y
Downloading Packages:
(1/4): perl-Error-0.17029-2.oe2203.noarch.rpm                        57 kB/s |  31 kB     00:00    
(2/4): perl-Git-2.33.0-1.oe2203.noarch.rpm                           44 kB/s |  28 kB     00:00    
(3/4): perl-TermReadKey-2.38-2.oe2203.x86_64.rpm                    208 kB/s |  25 kB     00:00    
(4/4): git-2.33.0-1.oe2203.x86_64.rpm                               2.4 MB/s | 6.0 MB     00:02    
----------------------------------------------------------------------------------------------------
Total                                                               2.4 MB/s | 6.0 MB     00:02     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                            1/1 
  Installing       : perl-TermReadKey-2.38-2.oe2203.x86_64                                      1/4 
  Installing       : perl-Error-1:0.17029-2.oe2203.noarch                                       2/4 
  Installing       : perl-Git-2.33.0-1.oe2203.noarch                                            3/4 
  Installing       : git-2.33.0-1.oe2203.x86_64                                                 4/4 
  Running scriptlet: git-2.33.0-1.oe2203.x86_64                                                 4/4 
  Verifying        : git-2.33.0-1.oe2203.x86_64                                                 1/4 
  Verifying        : perl-Error-1:0.17029-2.oe2203.noarch                                       2/4 
  Verifying        : perl-Git-2.33.0-1.oe2203.noarch                                            3/4 
  Verifying        : perl-TermReadKey-2.38-2.oe2203.x86_64                                      4/4 

Installed:
  git-2.33.0-1.oe2203.x86_64                    perl-Error-1:0.17029-2.oe2203.noarch               
  perl-Git-2.33.0-1.oe2203.noarch               perl-TermReadKey-2.38-2.oe2203.x86_64              

Complete!
[root@e2 ~]# /bin/bash -c &quot;$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)&quot;
<font color="#5555FF"><b>==&gt;</b></font><b> Checking for `sudo` access (which may request your password)...</b>
Don&apos;t run this as root!
[root@e2 ~]# sudo -u admin -- /bin/bash -c &quot;$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)&quot;
<font color="#5555FF"><b>==&gt;</b></font><b> Checking for `sudo` access (which may request your password)...</b>
<font color="#5555FF"><b>==&gt;</b></font><b> Select a Homebrew installation directory:</b>
- <b>Enter your password</b> to install to <u style="text-decoration-style:single">/home/linuxbrew/.linuxbrew</u> (<b>recommended</b>)
- <b>Press Control-D</b> to install to <u style="text-decoration-style:single">/home/admin/.linuxbrew</u>
- <b>Press Control-C</b> to cancel installation
[sudo] admin 的密码：
<font color="#5555FF"><b>==&gt;</b></font><b> This script will install:</b>
/home/linuxbrew/.linuxbrew/bin/brew
/home/linuxbrew/.linuxbrew/share/doc/homebrew
/home/linuxbrew/.linuxbrew/share/man/man1/brew.1
/home/linuxbrew/.linuxbrew/share/zsh/site-functions/_brew
/home/linuxbrew/.linuxbrew/etc/bash_completion.d/brew
/home/linuxbrew/.linuxbrew/Homebrew
<font color="#5555FF"><b>==&gt;</b></font><b> The following new directories will be created:</b>
/home/linuxbrew/.linuxbrew/bin
/home/linuxbrew/.linuxbrew/etc
/home/linuxbrew/.linuxbrew/include
/home/linuxbrew/.linuxbrew/lib
/home/linuxbrew/.linuxbrew/sbin
/home/linuxbrew/.linuxbrew/share
/home/linuxbrew/.linuxbrew/var
/home/linuxbrew/.linuxbrew/opt
/home/linuxbrew/.linuxbrew/share/zsh
/home/linuxbrew/.linuxbrew/share/zsh/site-functions
/home/linuxbrew/.linuxbrew/var/homebrew
/home/linuxbrew/.linuxbrew/var/homebrew/linked
/home/linuxbrew/.linuxbrew/Cellar
/home/linuxbrew/.linuxbrew/Caskroom
/home/linuxbrew/.linuxbrew/Frameworks

Press <b>RETURN</b>/<b>ENTER</b> to continue or any other key to abort:
<font color="#5555FF"><b>==&gt;</b></font><b> /usr/bin/sudo /usr/bin/install -d -o admin -g admin -m 0755 /home/linuxbrew/.linuxbrew</b>
<font color="#5555FF"><b>==&gt;</b></font><b> /usr/bin/sudo /bin/mkdir -p /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/etc /home/linuxbrew/.linuxbrew/include /home/linuxbrew/.linuxbrew/lib /home/linuxbrew/.linuxbrew/sbin /home/linuxbrew/.linuxbrew/share /home/linuxbrew/.linuxbrew/var /home/linuxbrew/.linuxbrew/opt /home/linuxbrew/.linuxbrew/share/zsh /home/linuxbrew/.linuxbrew/share/zsh/site-functions /home/linuxbrew/.linuxbrew/var/homebrew /home/linuxbrew/.linuxbrew/var/homebrew/linked /home/linuxbrew/.linuxbrew/Cellar /home/linuxbrew/.linuxbrew/Caskroom /home/linuxbrew/.linuxbrew/Frameworks</b>
<font color="#5555FF"><b>==&gt;</b></font><b> /usr/bin/sudo /bin/chmod ug=rwx /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/etc /home/linuxbrew/.linuxbrew/include /home/linuxbrew/.linuxbrew/lib /home/linuxbrew/.linuxbrew/sbin /home/linuxbrew/.linuxbrew/share /home/linuxbrew/.linuxbrew/var /home/linuxbrew/.linuxbrew/opt /home/linuxbrew/.linuxbrew/share/zsh /home/linuxbrew/.linuxbrew/share/zsh/site-functions /home/linuxbrew/.linuxbrew/var/homebrew /home/linuxbrew/.linuxbrew/var/homebrew/linked /home/linuxbrew/.linuxbrew/Cellar /home/linuxbrew/.linuxbrew/Caskroom /home/linuxbrew/.linuxbrew/Frameworks</b>
<font color="#5555FF"><b>==&gt;</b></font><b> /usr/bin/sudo /bin/chmod go-w /home/linuxbrew/.linuxbrew/share/zsh /home/linuxbrew/.linuxbrew/share/zsh/site-functions</b>
<font color="#5555FF"><b>==&gt;</b></font><b> /usr/bin/sudo /bin/chown admin /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/etc /home/linuxbrew/.linuxbrew/include /home/linuxbrew/.linuxbrew/lib /home/linuxbrew/.linuxbrew/sbin /home/linuxbrew/.linuxbrew/share /home/linuxbrew/.linuxbrew/var /home/linuxbrew/.linuxbrew/opt /home/linuxbrew/.linuxbrew/share/zsh /home/linuxbrew/.linuxbrew/share/zsh/site-functions /home/linuxbrew/.linuxbrew/var/homebrew /home/linuxbrew/.linuxbrew/var/homebrew/linked /home/linuxbrew/.linuxbrew/Cellar /home/linuxbrew/.linuxbrew/Caskroom /home/linuxbrew/.linuxbrew/Frameworks</b>
<font color="#5555FF"><b>==&gt;</b></font><b> /usr/bin/sudo /bin/chgrp admin /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/etc /home/linuxbrew/.linuxbrew/include /home/linuxbrew/.linuxbrew/lib /home/linuxbrew/.linuxbrew/sbin /home/linuxbrew/.linuxbrew/share /home/linuxbrew/.linuxbrew/var /home/linuxbrew/.linuxbrew/opt /home/linuxbrew/.linuxbrew/share/zsh /home/linuxbrew/.linuxbrew/share/zsh/site-functions /home/linuxbrew/.linuxbrew/var/homebrew /home/linuxbrew/.linuxbrew/var/homebrew/linked /home/linuxbrew/.linuxbrew/Cellar /home/linuxbrew/.linuxbrew/Caskroom /home/linuxbrew/.linuxbrew/Frameworks</b>
<font color="#5555FF"><b>==&gt;</b></font><b> /usr/bin/sudo /bin/mkdir -p /home/linuxbrew/.linuxbrew/Homebrew</b>
<font color="#5555FF"><b>==&gt;</b></font><b> /usr/bin/sudo /bin/chown -R admin:admin /home/linuxbrew/.linuxbrew/Homebrew</b>
<font color="#5555FF"><b>==&gt;</b></font><b> Downloading and installing Homebrew...</b>
fatal: 无法访问 &apos;https://github.com/Homebrew/brew/&apos;：HTTP/2 stream 1 was not closed cleanly before end of the underlying stream
Failed during: git fetch --force origin
[root@e2 ~]# cat /etc/profile.d/env-brew.sh | sudo -u admin -- tee -a -- /home/admin/.bash_profile
export HOMEBREW_BREW_GIT_REMOTE=&quot;https://mirrors.ustc.edu.cn/brew.git&quot;
export HOMEBREW_CORE_GIT_REMOTE=&quot;https://mirrors.ustc.edu.cn/homebrew-core.git&quot;
export HOMEBREW_BOTTLE_DOMAIN=&quot;https://mirrors.ustc.edu.cn/homebrew-bottles&quot;

export HOMEBREW_BREW_GIT_REMOTE=&quot;https://ghproxy.com/https://github.com/Homebrew/brew.git&quot;
export HOMEBREW_CORE_GIT_REMOTE=&quot;https://ghproxy.com/https://github.com/Homebrew/homebrew-core.git&quot;
export HOMEBREW_BOTTLE_DOMAIN=&quot;https://ghproxy.com/https://github.com/Homebrew/homebrew-bundle.git&quot;
[root@e2 ~]# sudo -u admin -- /bin/bash -c &quot;$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)&quot;
<font color="#5555FF"><b>==&gt;</b></font><b> Checking for `sudo` access (which may request your password)...</b>
<font color="#5555FF"><b>==&gt;</b></font><b> This script will install:</b>
/home/linuxbrew/.linuxbrew/bin/brew
/home/linuxbrew/.linuxbrew/share/doc/homebrew
/home/linuxbrew/.linuxbrew/share/man/man1/brew.1
/home/linuxbrew/.linuxbrew/share/zsh/site-functions/_brew
/home/linuxbrew/.linuxbrew/etc/bash_completion.d/brew
/home/linuxbrew/.linuxbrew/Homebrew

Press <b>RETURN</b>/<b>ENTER</b> to continue or any other key to abort:
[sudo] admin 的密码：
<font color="#5555FF"><b>==&gt;</b></font><b> /usr/bin/sudo /bin/chown -R admin:admin /home/linuxbrew/.linuxbrew/Homebrew</b>
<font color="#5555FF"><b>==&gt;</b></font><b> Downloading and installing Homebrew...</b>
remote: Enumerating objects: 208008, done.
remote: Counting objects: 100% (91/91), done.
remote: Compressing objects: 100% (77/77), done.
remote: Total 208008 (delta 16), reused 78 (delta 9), pack-reused 207917
接收对象中: 100% (208008/208008), 57.67 MiB | 17.00 KiB/s, 完成.
处理 delta 中: 100% (152981/152981), 完成.
来自 https://github.com/Homebrew/brew
 * [新分支]              dependabot/bundler/Library/Homebrew/rubocop-1.28.2 -&gt; origin/dependabot/bundler/Library/Homebrew/rubocop-1.28.2
 * [新分支]              master     -&gt; origin/master
 * [新标签]              0.1        -&gt; 0.1
 * [新标签]              0.2        -&gt; 0.2
 * [新标签]              0.3        -&gt; 0.3
 * [新标签]              0.4        -&gt; 0.4
 * [新标签]              0.5        -&gt; 0.5
 * [新标签]              0.6        -&gt; 0.6
 * [新标签]              0.7        -&gt; 0.7
 * [新标签]              0.7.1      -&gt; 0.7.1
 * [新标签]              0.8        -&gt; 0.8
 * [新标签]              0.8.1      -&gt; 0.8.1
 * [新标签]              0.9        -&gt; 0.9
 * [新标签]              0.9.1      -&gt; 0.9.1
 * [新标签]              0.9.2      -&gt; 0.9.2
 * [新标签]              0.9.3      -&gt; 0.9.3
 * [新标签]              0.9.4      -&gt; 0.9.4
 * [新标签]              0.9.5      -&gt; 0.9.5
 * [新标签]              0.9.8      -&gt; 0.9.8
 * [新标签]              0.9.9      -&gt; 0.9.9
 * [新标签]              1.0.0      -&gt; 1.0.0
 * [新标签]              1.0.1      -&gt; 1.0.1
 * [新标签]              1.0.2      -&gt; 1.0.2
 * [新标签]              1.0.3      -&gt; 1.0.3
 * [新标签]              1.0.4      -&gt; 1.0.4
 * [新标签]              1.0.5      -&gt; 1.0.5
 * [新标签]              1.0.6      -&gt; 1.0.6
 * [新标签]              1.0.7      -&gt; 1.0.7
 * [新标签]              1.0.8      -&gt; 1.0.8
 * [新标签]              1.0.9      -&gt; 1.0.9
 * [新标签]              1.1.0      -&gt; 1.1.0
 * [新标签]              1.1.1      -&gt; 1.1.1
 * [新标签]              1.1.10     -&gt; 1.1.10
 * [新标签]              1.1.11     -&gt; 1.1.11
 * [新标签]              1.1.12     -&gt; 1.1.12
 * [新标签]              1.1.13     -&gt; 1.1.13
 * [新标签]              1.1.2      -&gt; 1.1.2
 * [新标签]              1.1.3      -&gt; 1.1.3
 * [新标签]              1.1.4      -&gt; 1.1.4
 * [新标签]              1.1.5      -&gt; 1.1.5
 * [新标签]              1.1.6      -&gt; 1.1.6
 * [新标签]              1.1.7      -&gt; 1.1.7
 * [新标签]              1.1.8      -&gt; 1.1.8
 * [新标签]              1.1.9      -&gt; 1.1.9
 * [新标签]              1.2.0      -&gt; 1.2.0
 * [新标签]              1.2.1      -&gt; 1.2.1
 * [新标签]              1.2.2      -&gt; 1.2.2
 * [新标签]              1.2.3      -&gt; 1.2.3
 * [新标签]              1.2.4      -&gt; 1.2.4
 * [新标签]              1.2.5      -&gt; 1.2.5
 * [新标签]              1.2.6      -&gt; 1.2.6
 * [新标签]              1.3.0      -&gt; 1.3.0
 * [新标签]              1.3.1      -&gt; 1.3.1
 * [新标签]              1.3.2      -&gt; 1.3.2
 * [新标签]              1.3.3      -&gt; 1.3.3
 * [新标签]              1.3.4      -&gt; 1.3.4
 * [新标签]              1.3.5      -&gt; 1.3.5
 * [新标签]              1.3.6      -&gt; 1.3.6
 * [新标签]              1.3.7      -&gt; 1.3.7
 * [新标签]              1.3.8      -&gt; 1.3.8
 * [新标签]              1.3.9      -&gt; 1.3.9
 * [新标签]              1.4.0      -&gt; 1.4.0
 * [新标签]              1.4.1      -&gt; 1.4.1
 * [新标签]              1.4.2      -&gt; 1.4.2
 * [新标签]              1.4.3      -&gt; 1.4.3
 * [新标签]              1.5.0      -&gt; 1.5.0
 * [新标签]              1.5.1      -&gt; 1.5.1
 * [新标签]              1.5.10     -&gt; 1.5.10
 * [新标签]              1.5.11     -&gt; 1.5.11
 * [新标签]              1.5.12     -&gt; 1.5.12
 * [新标签]              1.5.13     -&gt; 1.5.13
 * [新标签]              1.5.14     -&gt; 1.5.14
 * [新标签]              1.5.2      -&gt; 1.5.2
 * [新标签]              1.5.3      -&gt; 1.5.3
 * [新标签]              1.5.4      -&gt; 1.5.4
 * [新标签]              1.5.5      -&gt; 1.5.5
 * [新标签]              1.5.6      -&gt; 1.5.6
 * [新标签]              1.5.7      -&gt; 1.5.7
 * [新标签]              1.5.8      -&gt; 1.5.8
 * [新标签]              1.5.9      -&gt; 1.5.9
 * [新标签]              1.6.0      -&gt; 1.6.0
 * [新标签]              1.6.1      -&gt; 1.6.1
 * [新标签]              1.6.10     -&gt; 1.6.10
 * [新标签]              1.6.11     -&gt; 1.6.11
 * [新标签]              1.6.12     -&gt; 1.6.12
 * [新标签]              1.6.13     -&gt; 1.6.13
 * [新标签]              1.6.14     -&gt; 1.6.14
 * [新标签]              1.6.15     -&gt; 1.6.15
 * [新标签]              1.6.16     -&gt; 1.6.16
 * [新标签]              1.6.17     -&gt; 1.6.17
 * [新标签]              1.6.2      -&gt; 1.6.2
 * [新标签]              1.6.3      -&gt; 1.6.3
 * [新标签]              1.6.4      -&gt; 1.6.4
 * [新标签]              1.6.5      -&gt; 1.6.5
 * [新标签]              1.6.6      -&gt; 1.6.6
 * [新标签]              1.6.7      -&gt; 1.6.7
 * [新标签]              1.6.8      -&gt; 1.6.8
 * [新标签]              1.6.9      -&gt; 1.6.9
 * [新标签]              1.7.0      -&gt; 1.7.0
 * [新标签]              1.7.1      -&gt; 1.7.1
 * [新标签]              1.7.2      -&gt; 1.7.2
 * [新标签]              1.7.3      -&gt; 1.7.3
 * [新标签]              1.7.4      -&gt; 1.7.4
 * [新标签]              1.7.5      -&gt; 1.7.5
 * [新标签]              1.7.6      -&gt; 1.7.6
 * [新标签]              1.7.7      -&gt; 1.7.7
 * [新标签]              1.8.0      -&gt; 1.8.0
 * [新标签]              1.8.1      -&gt; 1.8.1
 * [新标签]              1.8.2      -&gt; 1.8.2
 * [新标签]              1.8.3      -&gt; 1.8.3
 * [新标签]              1.8.4      -&gt; 1.8.4
 * [新标签]              1.8.5      -&gt; 1.8.5
 * [新标签]              1.8.6      -&gt; 1.8.6
 * [新标签]              1.9.0      -&gt; 1.9.0
 * [新标签]              1.9.1      -&gt; 1.9.1
 * [新标签]              1.9.2      -&gt; 1.9.2
 * [新标签]              1.9.3      -&gt; 1.9.3
 * [新标签]              2.0.0      -&gt; 2.0.0
 * [新标签]              2.0.1      -&gt; 2.0.1
 * [新标签]              2.0.2      -&gt; 2.0.2
 * [新标签]              2.0.3      -&gt; 2.0.3
 * [新标签]              2.0.4      -&gt; 2.0.4
 * [新标签]              2.0.5      -&gt; 2.0.5
 * [新标签]              2.0.6      -&gt; 2.0.6
 * [新标签]              2.1.0      -&gt; 2.1.0
 * [新标签]              2.1.1      -&gt; 2.1.1
 * [新标签]              2.1.10     -&gt; 2.1.10
 * [新标签]              2.1.11     -&gt; 2.1.11
 * [新标签]              2.1.12     -&gt; 2.1.12
 * [新标签]              2.1.13     -&gt; 2.1.13
 * [新标签]              2.1.14     -&gt; 2.1.14
 * [新标签]              2.1.15     -&gt; 2.1.15
 * [新标签]              2.1.16     -&gt; 2.1.16
 * [新标签]              2.1.2      -&gt; 2.1.2
 * [新标签]              2.1.3      -&gt; 2.1.3
 * [新标签]              2.1.4      -&gt; 2.1.4
 * [新标签]              2.1.5      -&gt; 2.1.5
 * [新标签]              2.1.6      -&gt; 2.1.6
 * [新标签]              2.1.7      -&gt; 2.1.7
 * [新标签]              2.1.8      -&gt; 2.1.8
 * [新标签]              2.1.9      -&gt; 2.1.9
 * [新标签]              2.2.0      -&gt; 2.2.0
 * [新标签]              2.2.1      -&gt; 2.2.1
 * [新标签]              2.2.10     -&gt; 2.2.10
 * [新标签]              2.2.11     -&gt; 2.2.11
 * [新标签]              2.2.12     -&gt; 2.2.12
 * [新标签]              2.2.13     -&gt; 2.2.13
 * [新标签]              2.2.14     -&gt; 2.2.14
 * [新标签]              2.2.15     -&gt; 2.2.15
 * [新标签]              2.2.16     -&gt; 2.2.16
 * [新标签]              2.2.17     -&gt; 2.2.17
 * [新标签]              2.2.2      -&gt; 2.2.2
 * [新标签]              2.2.3      -&gt; 2.2.3
 * [新标签]              2.2.4      -&gt; 2.2.4
 * [新标签]              2.2.5      -&gt; 2.2.5
 * [新标签]              2.2.6      -&gt; 2.2.6
 * [新标签]              2.2.7      -&gt; 2.2.7
 * [新标签]              2.2.8      -&gt; 2.2.8
 * [新标签]              2.2.9      -&gt; 2.2.9
 * [新标签]              2.3.0      -&gt; 2.3.0
 * [新标签]              2.4.0      -&gt; 2.4.0
 * [新标签]              2.4.1      -&gt; 2.4.1
 * [新标签]              2.4.10     -&gt; 2.4.10
 * [新标签]              2.4.11     -&gt; 2.4.11
 * [新标签]              2.4.12     -&gt; 2.4.12
 * [新标签]              2.4.13     -&gt; 2.4.13
 * [新标签]              2.4.14     -&gt; 2.4.14
 * [新标签]              2.4.15     -&gt; 2.4.15
 * [新标签]              2.4.16     -&gt; 2.4.16
 * [新标签]              2.4.2      -&gt; 2.4.2
 * [新标签]              2.4.3      -&gt; 2.4.3
 * [新标签]              2.4.4      -&gt; 2.4.4
 * [新标签]              2.4.5      -&gt; 2.4.5
 * [新标签]              2.4.6      -&gt; 2.4.6
 * [新标签]              2.4.7      -&gt; 2.4.7
 * [新标签]              2.4.8      -&gt; 2.4.8
 * [新标签]              2.4.9      -&gt; 2.4.9
 * [新标签]              2.5.0      -&gt; 2.5.0
 * [新标签]              2.5.1      -&gt; 2.5.1
 * [新标签]              2.5.10     -&gt; 2.5.10
 * [新标签]              2.5.11     -&gt; 2.5.11
 * [新标签]              2.5.12     -&gt; 2.5.12
 * [新标签]              2.5.2      -&gt; 2.5.2
 * [新标签]              2.5.3      -&gt; 2.5.3
 * [新标签]              2.5.4      -&gt; 2.5.4
 * [新标签]              2.5.5      -&gt; 2.5.5
 * [新标签]              2.5.6      -&gt; 2.5.6
 * [新标签]              2.5.7      -&gt; 2.5.7
 * [新标签]              2.5.8      -&gt; 2.5.8
 * [新标签]              2.5.9      -&gt; 2.5.9
 * [新标签]              2.6.0      -&gt; 2.6.0
 * [新标签]              2.6.1      -&gt; 2.6.1
 * [新标签]              2.6.2      -&gt; 2.6.2
 * [新标签]              2.7.0      -&gt; 2.7.0
 * [新标签]              2.7.1      -&gt; 2.7.1
 * [新标签]              2.7.2      -&gt; 2.7.2
 * [新标签]              2.7.3      -&gt; 2.7.3
 * [新标签]              2.7.4      -&gt; 2.7.4
 * [新标签]              2.7.5      -&gt; 2.7.5
 * [新标签]              2.7.6      -&gt; 2.7.6
 * [新标签]              2.7.7      -&gt; 2.7.7
 * [新标签]              3.0.0      -&gt; 3.0.0
 * [新标签]              3.0.1      -&gt; 3.0.1
 * [新标签]              3.0.10     -&gt; 3.0.10
 * [新标签]              3.0.11     -&gt; 3.0.11
 * [新标签]              3.0.2      -&gt; 3.0.2
 * [新标签]              3.0.3      -&gt; 3.0.3
 * [新标签]              3.0.4      -&gt; 3.0.4
 * [新标签]              3.0.5      -&gt; 3.0.5
 * [新标签]              3.0.6      -&gt; 3.0.6
 * [新标签]              3.0.7      -&gt; 3.0.7
 * [新标签]              3.0.8      -&gt; 3.0.8
 * [新标签]              3.0.9      -&gt; 3.0.9
 * [新标签]              3.1.0      -&gt; 3.1.0
 * [新标签]              3.1.1      -&gt; 3.1.1
 * [新标签]              3.1.10     -&gt; 3.1.10
 * [新标签]              3.1.11     -&gt; 3.1.11
 * [新标签]              3.1.12     -&gt; 3.1.12
 * [新标签]              3.1.2      -&gt; 3.1.2
 * [新标签]              3.1.3      -&gt; 3.1.3
 * [新标签]              3.1.4      -&gt; 3.1.4
 * [新标签]              3.1.5      -&gt; 3.1.5
 * [新标签]              3.1.6      -&gt; 3.1.6
 * [新标签]              3.1.7      -&gt; 3.1.7
 * [新标签]              3.1.8      -&gt; 3.1.8
 * [新标签]              3.1.9      -&gt; 3.1.9
 * [新标签]              3.2.0      -&gt; 3.2.0
 * [新标签]              3.2.1      -&gt; 3.2.1
 * [新标签]              3.2.10     -&gt; 3.2.10
 * [新标签]              3.2.11     -&gt; 3.2.11
 * [新标签]              3.2.12     -&gt; 3.2.12
 * [新标签]              3.2.13     -&gt; 3.2.13
 * [新标签]              3.2.14     -&gt; 3.2.14
 * [新标签]              3.2.15     -&gt; 3.2.15
 * [新标签]              3.2.16     -&gt; 3.2.16
 * [新标签]              3.2.17     -&gt; 3.2.17
 * [新标签]              3.2.2      -&gt; 3.2.2
 * [新标签]              3.2.3      -&gt; 3.2.3
 * [新标签]              3.2.4      -&gt; 3.2.4
 * [新标签]              3.2.5      -&gt; 3.2.5
 * [新标签]              3.2.6      -&gt; 3.2.6
 * [新标签]              3.2.7      -&gt; 3.2.7
 * [新标签]              3.2.8      -&gt; 3.2.8
 * [新标签]              3.2.9      -&gt; 3.2.9
 * [新标签]              3.3.0      -&gt; 3.3.0
 * [新标签]              3.3.1      -&gt; 3.3.1
 * [新标签]              3.3.10     -&gt; 3.3.10
 * [新标签]              3.3.11     -&gt; 3.3.11
 * [新标签]              3.3.12     -&gt; 3.3.12
 * [新标签]              3.3.13     -&gt; 3.3.13
 * [新标签]              3.3.14     -&gt; 3.3.14
 * [新标签]              3.3.15     -&gt; 3.3.15
 * [新标签]              3.3.16     -&gt; 3.3.16
 * [新标签]              3.3.2      -&gt; 3.3.2
 * [新标签]              3.3.3      -&gt; 3.3.3
 * [新标签]              3.3.4      -&gt; 3.3.4
 * [新标签]              3.3.5      -&gt; 3.3.5
 * [新标签]              3.3.6      -&gt; 3.3.6
 * [新标签]              3.3.7      -&gt; 3.3.7
 * [新标签]              3.3.8      -&gt; 3.3.8
 * [新标签]              3.3.9      -&gt; 3.3.9
 * [新标签]              3.4.0      -&gt; 3.4.0
 * [新标签]              3.4.1      -&gt; 3.4.1
 * [新标签]              3.4.10     -&gt; 3.4.10
 * [新标签]              3.4.11     -&gt; 3.4.11
 * [新标签]              3.4.2      -&gt; 3.4.2
 * [新标签]              3.4.3      -&gt; 3.4.3
 * [新标签]              3.4.4      -&gt; 3.4.4
 * [新标签]              3.4.5      -&gt; 3.4.5
 * [新标签]              3.4.6      -&gt; 3.4.6
 * [新标签]              3.4.7      -&gt; 3.4.7
 * [新标签]              3.4.8      -&gt; 3.4.8
 * [新标签]              3.4.9      -&gt; 3.4.9
HEAD 现在位于 54b45c2c8 Merge pull request #13304 from Homebrew/dependabot/bundler/Library/Homebrew/rubocop-rspec-2.11.1
<font color="#5555FF"><b>==&gt;</b></font><b> Tapping homebrew/core</b>
fatal: 无法访问 &apos;https://github.com/Homebrew/homebrew-core/&apos;：HTTP/2 stream 1 was not closed cleanly before end of the underlying stream
Failed during: git fetch --force origin refs/heads/master:refs/remotes/origin/master
[root@e2 ~]# su admin


Welcome to 5.10.0-60.27.0.57.oe2203.x86_64

System information as of time: 	2022年 05月 20日 星期五 18:36:15 CST

System load: 	<span style="background-color:#000000"><font color="#AA5500">0.00</font></span>
Processes: 	316
Memory used: 	.8%
Swap used: 	0.0%
Usage On: 	8%
IP address: 	10.101.100.72
IP address: 	192.168.122.1
IP address: 	10.96.0.10
IP address: 	10.96.0.1
Users online: 	2
To run a command as administrator(user &quot;root&quot;),use &quot;sudo &lt;command&gt;&quot;.
[admin@e2 root]$ export HOMEBREW_BREW_GIT_REMOTE=&quot;https://mirrors.ustc.edu.cn/brew.git&quot;
[admin@e2 root]$ export HOMEBREW_CORE_GIT_REMOTE=&quot;https://mirrors.ustc.edu.cn/homebrew-core.git&quot;
[admin@e2 root]$ export HOMEBREW_BOTTLE_DOMAIN=&quot;https://mirrors.ustc.edu.cn/homebrew-bottles&quot;
[admin@e2 root]$ 
[admin@e2 root]$ /bin/bash -c &quot;$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)&quot;
<font color="#5555FF"><b>==&gt;</b></font><b> Checking for `sudo` access (which may request your password)...</b>
<font color="#5555FF"><b>==&gt;</b></font><b> This script will install:</b>
/home/linuxbrew/.linuxbrew/bin/brew
/home/linuxbrew/.linuxbrew/share/doc/homebrew
/home/linuxbrew/.linuxbrew/share/man/man1/brew.1
/home/linuxbrew/.linuxbrew/share/zsh/site-functions/_brew
/home/linuxbrew/.linuxbrew/etc/bash_completion.d/brew
/home/linuxbrew/.linuxbrew/Homebrew
<font color="#5555FF"><b>==&gt;</b></font><b> HOMEBREW_BREW_GIT_REMOTE is set to a non-default URL:</b>
<u style="text-decoration-style:single">https://mirrors.ustc.edu.cn/brew.git</u> will be used as the Homebrew/brew Git remote.
<font color="#5555FF"><b>==&gt;</b></font><b> HOMEBREW_CORE_GIT_REMOTE is set to a non-default URL:</b>
<u style="text-decoration-style:single">https://mirrors.ustc.edu.cn/homebrew-core.git</u> will be used as the Homebrew/homebrew-core Git remote.

Press <b>RETURN</b>/<b>ENTER</b> to continue or any other key to abort:
[sudo] admin 的密码：
<font color="#5555FF"><b>==&gt;</b></font><b> /usr/bin/sudo /bin/chown -R admin:admin /home/linuxbrew/.linuxbrew/Homebrew</b>
<font color="#5555FF"><b>==&gt;</b></font><b> Downloading and installing Homebrew...</b>
remote: Enumerating objects: 3560, done.
remote: Counting objects: 100% (3560/3560), done.
remote: Total 7531 (delta 3560), reused 3560 (delta 3560), pack-reused 3971
接收对象中: 100% (7531/7531), 1.61 MiB | 8.65 MiB/s, 完成.
处理 delta 中: 100% (5798/5798), 完成 737 个本地对象.
来自 https://mirrors.ustc.edu.cn/brew
 * [新标签]              1.1.0.1                           -&gt; 1.1.0.1
 * [新标签]              1.1.2.1                           -&gt; 1.1.2.1
 * [新标签]              1.2.7                             -&gt; 1.2.7
 * [新标签]              1.2.8                             -&gt; 1.2.8
 * [新标签]              backup/activesupport-23-38-09     -&gt; backup/activesupport-23-38-09
 * [新标签]              backup/brew-cask-style-14-54-55   -&gt; backup/brew-cask-style-14-54-55
 * [新标签]              backup/create-cache-00-29-47      -&gt; backup/create-cache-00-29-47
 * [新标签]              backup/days-03-02-52              -&gt; backup/days-03-02-52
 * [新标签]              backup/days-03-02-59              -&gt; backup/days-03-02-59
 * [新标签]              backup/days-19-30-23              -&gt; backup/days-19-30-23
 * [新标签]              backup/gpg-verification-01-53-16  -&gt; backup/gpg-verification-01-53-16
 * [新标签]              backup/remove-popen-read-19-56-50 -&gt; backup/remove-popen-read-19-56-50
 * [新标签]              backup/remove-popen-read-20-00-21 -&gt; backup/remove-popen-read-20-00-21
HEAD 现在位于 54b45c2c8 Merge pull request #13304 from Homebrew/dependabot/bundler/Library/Homebrew/rubocop-rspec-2.11.1
HOMEBREW_BREW_GIT_REMOTE set: using https://mirrors.ustc.edu.cn/brew.git for Homebrew/brew Git remote.
HOMEBREW_CORE_GIT_REMOTE set: using https://mirrors.ustc.edu.cn/homebrew-core.git for Homebrew/core Git remote.
remote: Enumerating objects: 1195853, done.
remote: Total 1195853 (delta 0), reused 0 (delta 0), pack-reused 1195853
Receiving objects: 100% (1195853/1195853), 525.26 MiB | 20.83 MiB/s, done.
Resolving deltas: 100% (835968/835968), done.
From https://mirrors.ustc.edu.cn/homebrew-core
 * [new branch]      master     -&gt; origin/master
fatal: Could not resolve HEAD to a revision
<font color="#0000AA">==&gt;</font> <b>Downloading https://mirrors.ustc.edu.cn/homebrew-bottles/bottles-portable-ruby/portable-ruby-2.6.8.x86_64_linux.bottle.tar.gz</b>
######################################################################## 100.0%
<font color="#0000AA">==&gt;</font> <b>Pouring portable-ruby-2.6.8.x86_64_linux.bottle.tar.gz</b>
<font color="#FF5555"><b>Warning</b></font>: /home/linuxbrew/.linuxbrew/bin is not in your PATH.
  Instructions on how to configure your shell for Homebrew
  can be found in the &apos;Next steps&apos; section below.
<font color="#5555FF"><b>==&gt;</b></font><b> Installation successful!</b>

<font color="#5555FF"><b>==&gt;</b></font><b> Homebrew has enabled anonymous aggregate formulae and cask analytics.</b>
<b>Read the analytics documentation (and how to opt-out) here:</b>
<b>  </b><u style="text-decoration-style:single"><b>https://docs.brew.sh/Analytics</b></u>
No analytics data has been sent yet (nor will any be during this <b>install</b> run).

<font color="#5555FF"><b>==&gt;</b></font><b> Homebrew is run entirely by unpaid volunteers. Please consider donating:</b>
  <u style="text-decoration-style:single">https://github.com/Homebrew/brew#donations</u>

<font color="#5555FF"><b>==&gt;</b></font><b> Next steps:</b>
- Run these two commands in your terminal to add Homebrew to your <b>PATH</b>:
    echo &apos;eval &quot;$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)&quot;&apos; &gt;&gt; /home/admin/.bash_profile
    eval &quot;$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)&quot;
- Run these commands in your terminal to add the non-default Git remotes for Homebrew/brew and Homebrew/homebrew-core:
    echo &apos;export HOMEBREW_BREW_GIT_REMOTE=&quot;https://mirrors.ustc.edu.cn/brew.git&quot;&apos; &gt;&gt; /home/admin/.bash_profile
    echo &apos;export HOMEBREW_CORE_GIT_REMOTE=&quot;https://mirrors.ustc.edu.cn/homebrew-core.git&quot;&apos; &gt;&gt; /home/admin/.bash_profile
    export HOMEBREW_BREW_GIT_REMOTE=&quot;https://mirrors.ustc.edu.cn/brew.git&quot;
    export HOMEBREW_CORE_GIT_REMOTE=&quot;https://mirrors.ustc.edu.cn/homebrew-core.git&quot;
- Install Homebrew&apos;s dependencies if you have sudo access:
    sudo yum groupinstall &apos;Development Tools&apos;
  For more information, see:
    <u style="text-decoration-style:single">https://docs.brew.sh/Homebrew-on-Linux</u>
- We recommend that you install GCC:
    brew install gcc
- Run <b>brew help</b> to get started
- Further documentation:
    <u style="text-decoration-style:single">https://docs.brew.sh</u>

[admin@e2 root]$ </pre>

</details>

其中如果成功换源的话，会多出这样的提示：

<pre><font color="#5555FF"><b>==&gt;</b></font><b> HOMEBREW_BREW_GIT_REMOTE is set to a non-default URL:</b>
<u style="text-decoration-style:single">https://mirrors.ustc.edu.cn/brew.git</u> will be used as the Homebrew/brew Git remote.
<font color="#5555FF"><b>==&gt;</b></font><b> HOMEBREW_CORE_GIT_REMOTE is set to a non-default URL:</b>
<u style="text-decoration-style:single">https://mirrors.ustc.edu.cn/homebrew-core.git</u> will be used as the Homebrew/homebrew-core Git remote.</pre>

### 初始化

根据安装好后的提示，要执行这个，才能分别在现在和以后都能用 `brew` 命令：

~~~ sh
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/admin/.bash_profile
~~~


