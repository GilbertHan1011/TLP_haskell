-- TRACTATUS/CoreTypes.hs
-- 本体论：对象与形式
-- (Ontology: Objects and Forms)
--
-- 这个模块定义了世界的"实体"（Substance）和"形式"（Form）。
-- 在 TLP 中，"对象"（Objects）是简单的，它们的本质在于其"可能性"（Possibility）
-- ——即它们能如何与其他对象组合。
--
-- 在 Haskell 中，"对象的形式"就是"类型"（Type）。

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
-- [Objects are Types. They are 'forms', not 'values'.]
-- [Possibility is the Type Signature. A 'Thing' is a 'value' of a specific type.]
-- ============================================================================

-- 我们使用空的 `data` 声明来定义"形式"（类型）。
-- 它们本身没有"值"，它们只是"可能性"的分类。

data SpatialObject  -- "空间对象"这种形式
data Color          -- "颜色"这种形式
data Person         -- "人"这种形式
data Relation       -- "关系"这种形式
data Time           -- "时间"这种形式

-- ============================================================================
-- TLP 3.202: "命题中所运用的简单符号称为名称。"
-- (The simple signs employed in propositions are called names.)
--
-- TLP 3.203: "名称意指对象。对象是它的意谓。"
-- (The name means the object. The object is its meaning.)
--
-- "名称"(Name) 是这些"形式"(Type) 的具体"值"。
-- 我们使用类型签名来"给予"名称它们的"意谓"（类型）。
-- :: 的意思是 "具有...的形式" (is of the form)
-- ============================================================================

apple :: SpatialObject
apple = undefined  -- 我们不需要它的具体实现，只需要它的类型

table :: SpatialObject
table = undefined

book :: SpatialObject
book = undefined

chair :: SpatialObject
chair = undefined

red :: Color
red = undefined

blue :: Color
blue = undefined

green :: Color
green = undefined

yellow :: Color
yellow = undefined

john :: Person
john = undefined

mary :: Person
mary = undefined

alice :: Person
alice = undefined

bob :: Person
bob = undefined

loves :: Relation
loves = undefined

hates :: Relation
hates = undefined

knows :: Relation
knows = undefined

morning :: Time
morning = undefined

noon :: Time
noon = undefined

evening :: Time
evening = undefined

night :: Time
night = undefined

