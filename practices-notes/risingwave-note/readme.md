
ref: https://risingwave.dev/docs/current/intro/

> RisingWave is an open-source cloud-native streaming database that uses SQL as the interface to manage and query data. It is designed to reduce the complexity and cost of building real-time applications. RisingWave consumes streaming data, performs incremental computations when new data come in, and updates results dynamically. As a database system, RisingWave maintains results in its own storage so that users can access data efficiently. You can sink data from RisingWave to an external stream for storage or additional processing.

ref: https://github.com/risingwavelabs/risingwave/.git

> Use Docker (Linux, macOS)
> 
> ~~~ sh
> # Start RisingWave in single-binary playground mode
> docker run -it --pull=always -p 4566:4566 -p 5691:5691 ghcr.io/risingwavelabs/risingwave:v0.1.13 playground
> ~~~
> 
