[quiz]: https://www.thewitcher.com//school-quiz
[store/gog]: https://www.gog.com/zh/game/the_witcher_3_wild_hunt_game_of_the_year_edition

[🐣 school quiz][quiz] | [🦪 store][store/gog]

## 开发模式

### 开启

在游戏目录找到 `./bin/config/base/general.ini` 文件。

原始内容：

~~~ ini
[General]
ConfigVersion=5
~~~

更改 `ConfigVersion` 值为 `1` 并添加 `DBGConsoleOn=true` ：

~~~ ini
[General]

; ConfigVersion=5

ConfigVersion=1
DBGConsoleOn=true
~~~

然后游戏中用 <kbd>`</kbd> 键可呼出控制台。

### 控台指令

#### 添加物品

##### `additem`

指定物品和数量添加

例：

几个特殊套装

~~~~ lua
additem("Dol Blathanna Armor")
additem("Dol Blathanna Gloves")
additem("Dol Blathanna Pants")
additem("Dol Blathanna Boots")
additem("Dol Blathanna longsword")
additem("White Widow of Dol Blathanna")

additem("White Tiger Armor")
additem("White Tiger Gloves")
additem("White Tiger Pants")
additem("White Tiger Boots")
additem("Steel Vixen")
additem("Silver Vixen")

additem("Netflix Armor 2")
additem("Netflix Pants 2")
additem("Netflix Boots 2")
additem("Netflix Gloves 2")
additem("Netflix steel sword 2")
additem("Netflix silver sword 2")
~~~~

染色

~~~~ lua
additem("Dye Default", 100)
additem("Dye Red", 100)
additem("Dye Orange", 100)
additem("Dye Yellow", 100)
additem("Dye Green", 100)
additem("Dye Turquoise", 100)
additem("Dye Blue", 100)
additem("Dye Purple", 100)
additem("Dye Pink", 100)
additem("Dye Gray", 100)
additem("Dye Black", 100)
additem("Dye White", 100)
additem("Dye Brown", 100)
~~~~

##### `adddrinks`

##### `addbolts`

##### `addherbs`

##### `addmutagens`

##### `learnallschematics`

##### `addmoney`

加钱： `addmoney(4096)` （增加 4096 货币）

#### 人物状态

##### `resurrect`

死亡复活： `resurrect()`

##### `Cat`

猫眼药剂效果：
- 打开： `Cat(1)`
- 关闭： `Cat(0)`

##### `spawnBoatAndMount`

生成一条船并且坐在上面： `spawnBoatAndMount()`

##### `addskillpoints`

增加技能点： `addskillpoints(64)` （增加 64 点技能点）



