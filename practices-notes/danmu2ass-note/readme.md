
[repo]: https://github.com/gwy15/danmu2ass.git
[crates-lib.rs]: https://lib.rs/crates/danmu2ass
[docker]: https://hub.docker.com/r/gwy15/danmu2ass


用于将哔哩哔哩的 *弹幕* 转为 *ass* 字幕文件。

links: 

- [gwy15/danmu2ass | GitHub][repo]
- [danmu2ass | Rust utility // Lib.rs][crates-lib.rs]
- [gwy15/danmu2ass | DockerHub][docker]

命令行说明：

~~~ help
danmu2ass 0.2.0
gwy15
将 XML 弹幕转换为 ASS 文件

USAGE:
    danmu2ass [OPTIONS] [INPUT]

ARGS:
    <INPUT>    需要转换的输入，可以是 xml 文件、文件夹或是哔哩哔哩链接、BV
               号。如果是文件夹会递归将其下所有 XML 都进行转换 [default: .]

OPTIONS:
    -a, --alpha <ALPHA>
            弹幕不透明度 [default: 0.7]

        --bold
            加粗

    -d, --duration <DURATION>
            弹幕在屏幕上的持续时间，单位为秒，可以有小数 [default: 15]

        --denylist <DENYLIST>
            黑名单，需要过滤的关键词列表文件，每行一个关键词

    -f, --font <FONT>
            弹幕使用字体。单位：像素 [default: 黑体]

        --font-size <FONT_SIZE>
            弹幕字体大小 [default: 25]

        --force
            默认会跳过 ass 比 xml 修改时间更晚的文件，此参数会强制转换

    -h, --height <HEIGHT>
            屏幕高度 [default: 720]

        --help
            Print help information

        --horizontal-gap <HORIZONTAL_GAP>
            每条弹幕之间的最小水平间距，为避免重叠可以调大这个数值。单位：像素 [default: 20.0]

    -l, --lane-size <LANE_SIZE>
            弹幕所占据的高度，即“行高度/行间距” [default: 32]

    -o, --output <ASS_FILE>
            输出的 ASS 文件，默认为输入文件名将 .xml 替换为 .ass，如果输入是文件夹则忽略

        --outline <OUTLINE>
            描边宽度 [default: 0.8]

    -p, --float-percentage <FLOAT_PERCENTAGE>
            屏幕上滚动弹幕最多高度百分比 [default: 0.5]

        --pause
            在处理完后暂停等待输入

        --time-offset <TIME_OFFSET>
            时间轴偏移，>0 会让弹幕延后，<0 会让弹幕提前，单位为秒 [default: 0.0]

    -V, --version
            Print version information

    -w, --width <WIDTH>
            屏幕宽度 [default: 1280]

        --width-ratio <WIDTH_RATIO>
            计算弹幕宽度的比例，为避免重叠可以调大这个数值 [default: 1.2]
~~~

