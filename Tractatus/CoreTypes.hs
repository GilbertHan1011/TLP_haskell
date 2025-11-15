-- TRACTATUS/CoreTypes.hs
-- 本体论：对象与形式
-- (Ontology: Objects and Forms)
--
-- 这个模块定义了世界的"实体"（Substance）和"形式"（Form）。
-- 在 TLP 中，"对象"（Objects）是简单的，它们的本质在于其"可能性"（Possibility）
-- ——即它们能如何与其他对象组合。
--
-- 在 Haskell 中，"对象的形式"就是"类型"（Type）。
--
-- 改进：使用数据构造函数作为"简单对象"，消除 undefined 的问题。
-- TLP 2.02: "对象是简单的。" 意味着对象不应该有 undefined 的实现。
-- 对象就是它自身。"名称"和"对象"是统一的。

module Tractatus.CoreTypes where

-- ============================================================================
-- TLP 2.01: "原子事实是对象（实体、事物）的结合。"
-- (An atomic fact is a combination of objects (entities, things).)
--
-- TLP 2.02: "对象是简单的。"
-- (The object is simple.)
--
-- TLP 2.021: "对象构成世界的实体。"
-- (Objects form the substance of the world.)
--
-- TLP 2.0232: "大致说来：对象是无色的。"
-- (Roughly speaking: objects are colourless.)
--
-- TLP 2.0251: "空间、时间和颜色（有色性）是对象的形式。"
-- (Space, time and colour (colouredness) are forms of objects.)
--
-- TLP 3.202: "命题中所运用的简单符号称为名称。"
-- (The simple signs employed in propositions are called names.)
--
-- TLP 3.203: "名称意指对象。对象是它的意谓。"
-- (The name means the object. The object is its meaning.)
--
-- [改进] "形式" (Type) 是 "Color"
-- "简单对象" (Objects) 是 "Red", "Green", "Blue", "Yellow"
-- "名称"和"对象"是统一的。Red 就是 Red。
-- ============================================================================

-- "形式" (Type) 是 "Color"
-- "简单对象" (Objects) 是 "Red", "Green", "Blue", "Yellow"
-- "名称"和"对象"是统一的。Red 就是 Red。
data Color = Red | Green | Blue | Yellow
    deriving (Eq, Ord, Show)

-- "形式" (Type) 是 "Person"
-- "简单对象" (Objects) 是 "John", "Mary", "Alice", "Bob"
-- "名称"和"对象"是统一的。John 就是 John。
data Person = John | Mary | Alice | Bob
    deriving (Eq, Ord, Show)

-- "形式" (Type) 是 "SpatialObject"
-- "简单对象" (Objects) 是 "Apple", "Table", "Book", "Chair"
-- "名称"和"对象"是统一的。Apple 就是 Apple。
data SpatialObject = Apple | Table | Book | Chair
    deriving (Eq, Ord, Show)

-- "形式" (Type) 是 "Time"
-- "简单对象" (Objects) 是 "Morning", "Noon", "Evening", "Night"
-- "名称"和"对象"是统一的。Morning 就是 Morning。
data Time = Morning | Noon | Evening | Night
    deriving (Eq, Ord, Show)

-- ============================================================================
-- 注意：我们删除了 `data Relation`，因为它不是一个"对象"。
-- 
-- TLP 2.01: "原子事实是对象的结合。"
-- "爱"不是一个像 john 或 apple 那样的"事物"或"对象"；
-- 它是 john 和 mary 之间的一种"结合方式"或"结构"。
-- 
-- 在 Logic.hs 中定义的 Loves :: Person -> Person -> AtomicFact
-- 已经完美地捕捉到了这一点。"Loves"就是这个"逻辑形式"。
-- ============================================================================
