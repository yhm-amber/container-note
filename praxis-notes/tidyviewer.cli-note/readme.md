[src/gh]: https://github.com/alexhallam/tv.git
[pkg/crates.io]: https://crates.io/crates/tidy-viewer

> 📺(tv) Tidy Viewer is a cross-platform CLI
>  csv pretty printer that uses column styling
>  to maximize viewer enjoyment.
> 
> 📺(tv) Tidy Viewer 漂亮地显示 csv 的
> 跨平台命令行工具，它用列的样式让展示看起来舒服。
> 

[🥥 src][src/gh] | [🥚 pkg][pkg/crates.io]

~~~ sh
: install : by cargo
cargo install tidy-viewer && sudo cp /home/$USER/.cargo/bin/tidy-viewer /usr/local/bin/. && echo "alias tv='tidy-viewer'" >> ~/.bashrc && source ~/.bashrc

: install : on debian （ need the <VERSION> ！）
wget -- https://github.com/alexhallam/tv/releases/download/<VERSION>/tidy-viewer_<VERSION>_amd64.deb && sudo dpkg -i tidy-viewer_<VERSION>_amd64.deb && echo "alias tv='tidy-viewer'" >> ~/.bashrc && source ~/.bashrc

: install : by aur （ Kindly maintained by @yigitsever ）
paru -S tidy-viewer

: install : by homebrew
brew install -- tidy-viewer

: install : by snap
sudo snap install --edge -- tidy-viewer
~~~

use: 

~~~ sh
: Diamonds :

: Diamonds : Download the diamonds data
wget -- https://raw.githubusercontent.com/tidyverse/ggplot2/master/data-raw/diamonds.csv

: Diamonds : pipe to tv
cat diamonds.csv | tv

: Starwars :

: Starwars : Download the starwars data
wget -- https://raw.githubusercontent.com/tidyverse/dplyr/master/data-raw/starwars.csv

: Starwars : Pass as argument
tv starwars.csv

: Pigeon Racing :

wget -- https://raw.githubusercontent.com/joanby/python-ml-course/master/datasets/pigeon-race/pigeon-racing.csv
cat pigeon-racing.csv | tv

: Titanic :

wget -- https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv

: Titanic : send to pager with color : less
tv titanic.csv -ea | less -R

: Titanic : send to pager with color : bat
tv titanic.csv -a -n 1000 | bat -p
~~~

> `column` Comes standard with Linux.
>  To get similar functionality run
>  `column file.csv -ts,`
> 
> Though `column` is similar I do think
>  there are some reasons `tv` is a better
>  tool.
> 

tools work with: 

- https://github.com/alexhallam/tv#tools-to-pair-with-tv
