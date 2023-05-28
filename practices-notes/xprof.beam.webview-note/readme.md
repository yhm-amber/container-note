[src/gh]: https://github.com/Appliscale/xprof.git "(Languages: Erlang 50.7%, JavaScript 47.8%, Other 1.5%) A visual tracer and profiler for Erlang and Elixir. / Erlang 和 Elixir 的可视化跟踪器和分析器。"

[🦪 src][src/gh]

~~~ erlang
%% rebar.config (at least version `3.3.3` is required):

{deps, 
[
    ...
    {xprof, "2.0.0-rc.5"}
] } .
~~~

~~~ elixir
# `mix.exs`:

defp deps, do: 
( [
    ...
    {:xprof, "~> 2.0.0-rc.5"}
] )
~~~
