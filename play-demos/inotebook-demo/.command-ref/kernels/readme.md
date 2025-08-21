

## .Kernel

Kernel 是真正执行命令的解释器。一般来说一个 kernel 应该同事也能作为一个 REPL 使用。

## .Spec

如果语言支持虚拟环境，那么 kernel 一般也当能够支持根据环境创建新的 Spec 。

此时，即便是同一个 kernel ，但是由于 Spec 不同，所以可能所使用的虚拟环境也会不同。同一个虚拟环境能够创建多个不同的 Spec 。

## :Commands

以 `jupyter` 命令示例

### `list`

~~~ sh
jupyter kernelspec list
~~~

### `remove`

~~~ sh
jupyter kernelspec remove <spec-name>
~~~

