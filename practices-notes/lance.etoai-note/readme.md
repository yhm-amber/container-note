[src/gh]: https://github.com/eto-ai/lance.git "Parquet 的替代品。随机访问速度提高 100 倍，包括向量索引和自动版本控制。兼容 Apache Arrow 和 DuckDB。"
[web]: https://eto-ai.github.io/lance "Lance: modern columnar data format for ML¶"

[🥚 src][src/gh] | [🍳 web][web]

> Alternative to Parquet.
>  100x faster for random access,
>  includes a vector index
>  and automatic versioning.
>  Apache Arrow and DuckDB compatible.
> 
> 实木复合地板的替代品。
> 随机访问速度提高 100 倍，
> 包括向量索引和自动版本控制。
> 兼容 Apache Arrow 和 DuckDB 。
> 

~~~
Languages: 

Rust 77.4%
Jupyter Notebook 11.9%
Python 9.4%
C 0.4%
Shell 0.3%
CMake 0.3%
Other 0.3%
~~~

Lance 是一种列式数据格式，
可以轻松快速地进行版本控制、查询和训练。
它设计用于图像、视频、3D 点云、音频，当然还有表格数据。

Lance 的主要特点包括：

  - 高性能随机访问： 比 Parquet 快 100 倍。
  - 矢量搜索： 在 1 毫秒内找到最近的邻居，并将 OLAP 查询与矢量搜索相结合。
  - 零拷贝、自动版本控制： 自动管理数据版本，并通过内置的零拷贝逻辑减少冗余。
  - 生态系统集成： Apache-Arrow、DuckDB 等正在开发中。
