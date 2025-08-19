This conversation was generated with Duck.ai (https://duck.ai) using OpenAI's o4-mini Model. AI chats may display inaccurate or offensive information (see https://duckduckgo.com/duckai/privacy-terms for more info).

====================

> User prompt 1 of 1 - 8/19/2025, 4:55:35 PM:
> 给我一个 elixir axon 示例，要 livebook 风格而不是构建包和模块。

o4-mini:
**以下是一个 Livebook 风格的 Elixir Axon 示例**

```elixir
# 标记为一个 Livebook 单元格
# 1. 安装依赖
# Mix.install/2 在 Livebook 中动态安装
Mix.install([
  {:nx, "~> 0.5.0"},
  {:axon, "~> 0.5.0"},
  {:explorer, "~> 0.5.0"}             # 用于数据处理
])

# 2. 导入模块
import Nx.Defn
alias Axon.Loop
alias Axon.Optimizers
```

<hr>

## 数据准备

本示例使用随机生成的回归数据，特征维度为 1，样本数为 100。

```elixir
# 生成训练集
features = Nx.random_uniform({100, 1}, min: -1.0, max: 1.0)
# y = 2*x + 噪声
labels = features
         |> Nx.multiply(2.0)
         |> Nx.add(Nx.random_normal({100, 1}, 0.0, 0.1))
```

<hr>

## 模型定义

下面构建一个简单的线性回归模型：单层全连接。

```elixir
model = 
  Axon.input("input", shape: {nil, 1})
  |> Axon.dense(1, name: "linear")

# 查看模型结构
model
```

<hr>

## 训练循环

使用 `Axon.Loop` 来定义训练流程，优化器为 SGD，损失为 MSE。

```elixir
# 定义损失函数
loss_fun = fn preds, targets ->
  Axon.Losses.mean_squared_error(preds, targets)
end

# 定义训练 Loop
train_loop =
  Loop.create(
    model,
    optimizer: Optimizers.sgd(0.1),
    loss: loss_fun,
    metrics: [:mse]
  )

# 训练 100 个 epoch
trained_loop = 
  train_loop
  |> Loop.trainer()
  |> Loop.run(%{"input" => features, "linear" => labels}, epochs: 100)
```

<hr>

## 预测与可视化

训练完成后，使用训练好的模型进行预测，并绘制结果。

```elixir
# 提取模型参数
params = Loop.state(trained_loop).key_params

# 构造测试数据
test_x = Nx.linspace(-1.0, 1.0, 50) |> Nx.reshape({50, 1})

# 预测
preds = Axon.predict(model, params, %{"input" => test_x})

# 简单可视化（Livebook 内置绘图）
Explorer.DataFrame.new(%{
  x: Enum.to_list(List.flatten(Axes.to_flat_list(test_x))),
  y: Enum.to_list(List.flatten(Axes.to_flat_list(preds)))
})
|> Explorer.DataFrame.plot(:scatter, x: :x, y: :y, title: "回归预测结果")
```

训练日志和最终散点图将在 Livebook 中实时展示，无需额外模块或包结构。
