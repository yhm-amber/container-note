[src/gh]: https://github.com/jawline/Mimic.git "(Rust 100%) (: cargo run --release -- --rom PATH) A Gameboy emulator written in Rust // 用 Rust 编写的 Gameboy 模拟器 /// An open source Gameboy emulator written in Rust that can use a command line interface as a screen and input device. The project is an attempt to make an approachable emulator for the Gameboy that can be used to explain the concepts required in emulating a system without overwhelming the reader. The core logic is all in safe Rust, there is no JIT recompiler, and screen / IO logic is kept separate from the emulation core to reduce complexity. As such, it does not perform ideally, but the Gameboy is an old system so ideal performance is not necessary to run games at full speed. // 一个用 Rust 编写的开源 Gameboy 模拟器，可以使用命令行界面作为屏幕和输入设备。该项目试图为 Gameboy 制作一个平易近人的模拟器，可用于解释模拟系统所需的概念，而不会让读者感到不知所措。核心逻辑全部采用安全的 Rust，没有 JIT 重新编译器，并且屏幕/IO 逻辑与仿真核心分开以降低复杂性。因此，它的性能并不理想，但 Gameboy 是一个旧系统，因此全速运行游戏不需要理想的性能。"