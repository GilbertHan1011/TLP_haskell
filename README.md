# Tractatus Logico-Philosophicus in Haskell

这是一个用 Haskell 实现的维特根斯坦《逻辑哲学论》（Tractatus Logico-Philosophicus）的模块化框架。

## 模块结构

### 1. `Tractatus/CoreTypes.hs` - 本体论：对象与形式

定义了世界的"实体"（Substance）和"形式"（Form）。在 TLP 中，"对象"（Objects）是简单的，它们的本质在于其"可能性"（Possibility）。

- **对象类型**：`SpatialObject`, `Color`, `Person`, `Time`
- **简单对象**：使用数据构造函数（如 `Apple`, `Table`, `John`, `Mary`, `Red`, `Green` 等）

### 2. `Tractatus/Logic.hs` - 逻辑语法：原子事实

定义了"逻辑形式"——即"对象"可以如何"合法地"组合成"原子事实"（Sachverhalte）。

- 使用 **GADT**（广义代数数据类型）来编码类型规则
- **原子事实构造器**：
  - `IsOn :: SpatialObject -> SpatialObject -> AtomicFact`
  - `IsColored :: SpatialObject -> Color -> AtomicFact`
  - `Loves :: Person -> Person -> AtomicFact`
  - `Hates :: Person -> Person -> AtomicFact`
  - `Knows :: Person -> Person -> AtomicFact`
  - `AtTime :: Person -> Time -> AtomicFact`

### 3. `Tractatus/World.hs` - 实在：世界

定义了"世界"和"实在"（Reality）。

- **TheWorld**：`AtomicFact -> Bool` 类型
- **theRealWorld**：一个具体的世界实例
- **worldDB**：使用 `Set` 存储存在的原子事实

### 4. `Tractatus/Language.hs` - 语言：命题

定义了"命题"（Satz）的句法和语义。

- **命题类型**：
  - `Elem AtomicFact` - 基本命题
  - `Not`, `And`, `Or`, `Implies`, `Iff` - 复合命题
- **eval**：评估命题在世界中的真值
- **isTautology**：检查命题是否是重言式
- **isContradiction**：检查命题是否是矛盾式

### 5. `Main.hs` - 总览和执行

演示如何使用框架，展示 TLP 的核心论点。

## 核心概念

### 逻辑形式 (Logical Form)

逻辑形式由 `AtomicFact` GADT 强制执行。类型系统确保只有"有意义的"组合才能被构造。

### 可说的/有意义的 (Sensical)

所有类型正确的 `Proposition` 值都是"有意义的"。

### 不可说的/无意义的 (Nonsensical)

导致 Type Error 的代码是"无意义的"。编译器（逻辑）阻止我们"言说"无意义的命题。

例如，以下代码无法编译：

```haskell
senselessFact :: AtomicFact
senselessFact = Loves Apple Table  -- 类型错误！
-- • Couldn't match type 'SpatialObject' with 'Person'
```

### 世界 (The World)

世界是一个类型为 `AtomicFact -> Bool` 的函数，它定义了哪些原子事实存在。

### 真/假 (True/False)

`eval` 函数在世界上的运行时结果。

### 逻辑命题 (Logic)

那些在所有可能的世界中 `eval` 结果都为 `True` 的命题（即重言式）。



## 编译和运行

```bash
# 编译
ghc -o tractatus Main.hs

# 运行
./tractatus
```

## 哲学意义

这个框架展示了：

1. **类型系统即逻辑语法**：Haskell 的类型系统充当"逻辑语法"，确保只有"有意义的"命题可以被表达。

2. **编译时错误即无意义**：任何违反"逻辑语法"的代码都会在编译时被拒绝，这正是 TLP 4.003 所说的："有关哲学的大多数命题...不是假的，而是无意义的。"

3. **逻辑形式在类型中**：`AtomicFact` GADT 的构造器本身就是"逻辑形式"，它们规定了对象可以如何组合。

4. **世界作为函数**：世界被建模为一个函数，从原子事实到真值，这体现了 TLP 2.06："原子事实的存在和不存在就是实在。"

5. **重言式即逻辑**：逻辑命题（重言式）不依赖于任何特定的世界，它们在所有可能的世界中都为真。

6. **名称与对象的统一**：TLP 3.203："名称意指对象。对象是它的意谓。"在我们的模型中，`John` 这个名称就是 `John` 这个对象，它们是不可分割的。

## TLP 7

> "对于不可言说的东西，我们必须保持沉默。"
> (Whereof one cannot speak, thereof one must be silent.)

编译器（The Compiler）强制我们保持沉默（enforces silence）。
