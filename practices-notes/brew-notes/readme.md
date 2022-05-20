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

### 安装

~~~ sh
sudo -u admin -- /bin/bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
~~~

<details>
<summary>效果</summary>

</details>


