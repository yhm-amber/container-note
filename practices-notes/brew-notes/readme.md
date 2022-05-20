ref: https://mirrors.ustc.edu.cn/help/brew.git.html  
ref: https://brew.sh/  

## 安装

### 配置选项

执行这些，并把这些也添加到 `/etc/profile.d/env-brew.sh` 中：

~~~ sh
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
~~~

如果不是频繁使用的话，可以试试这个：

~~~ sh
export HOMEBREW_BREW_GIT_REMOTE="https://ghproxy.com/https://github.com/Homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://ghproxy.com/https://github.com/Homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://ghproxy.com/https://github.com/Homebrew/homebrew-bundle.git"
~~~

**频繁使用 `brew` 命令的话请不要配置成这样的代理！！因为 `ghproxy` 是一个个人自费承担流量费用的公益项目，请不要对它过多负担。并且，这个项目的费用承担者，随时都有权利和资格停止对特定或所有的使用者提供服务。**

### 安装

~~~ sh
sudo -u admin -- /bin/bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
~~~

<details>
<summary>效果</summary>

</details>


