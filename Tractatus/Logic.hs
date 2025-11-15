-- TRACTATUS/Logic.hs
-- 逻辑语法：原子事实
-- (Logical Grammar: Atomic Facts)
--
-- 这是整个框架的核心。这个模块定义了"逻辑形式"——即"对象"可以如何"合法地"组合成"原子事实"（Sachverhalte）。
--
-- 我们将使用 广义代数数据类型 (GADT)，因为它允许我们在数据构造器中编码类型规则。
--
-- 改进：
-- 1. 删除了冗余的 Relation 相关构造器（Relates, StandsIn）
-- 2. 使用 deriving instance 自动派生 Eq, Ord, Show（因为 CoreTypes 中的所有对象现在都有了正确的 Eq, Ord, Show）

{-# LANGUAGE GADTs, StandaloneDeriving #-}

module Tractatus.Logic where

import Tractatus.CoreTypes

-- ============================================================================
-- TLP 2.01: "原子事实是对象...的结合。"
-- (An atomic fact is a combination of objects...)
--
-- TLP 2.031: "在原子事实中，对象以确定的方式结合在一起。"
-- (In the atomic fact the objects are combined in a definite way.)
--
-- TLP 2.033: "形式是结构的可能性。"
-- (The form is the possibility of the structure.)
--
-- `AtomicFact` 是所有"可能"的原子事实的"类型"。
-- 它的构造器 *就是* "逻辑形式" (Logical Form)。
-- ============================================================================

data AtomicFact :: * where
    -- "IsOn" (在...之上) 这种形式 *必须* 结合两个 SpatialObject
    IsOn :: SpatialObject -> SpatialObject -> AtomicFact
    
    -- "IsColored" (是...色的) 这种形式 *必须* 结合一个 SpatialObject 和一个 Color
    IsColored :: SpatialObject -> Color -> AtomicFact
    
    -- "Loves" (爱) 这种形式 *必须* 结合两个 Person
    -- "Loves" *就是* 逻辑形式, 不是一个对象
    Loves :: Person -> Person -> AtomicFact
    
    -- "Hates" (恨) 这种形式 *必须* 结合两个 Person
    Hates :: Person -> Person -> AtomicFact
    
    -- "Knows" (知道) 这种形式 *必须* 结合两个 Person
    Knows :: Person -> Person -> AtomicFact
    
    -- "AtTime" (在...时间) 这种形式 *必须* 结合一个 Person 和一个 Time
    AtTime :: Person -> Time -> AtomicFact
    
    -- 注意：删除了 Relates 和 StandsIn，因为关系不是对象，而是逻辑形式

-- ============================================================================
-- TLP 1.13: "逻辑空间中的事实就是世界。"
-- (The facts in logical space are the world.)
--
-- TLP 2.013: "每一个事物...都是处在可能原子事实的空间之中。"
-- (Every thing is, as it were, in a space of possible atomic facts.)
--
-- "逻辑空间" (LogicalSpace) 不是一个需要被构建的"值"，
-- 它 *就是* `AtomicFact` 这个类型本身。
-- 任何 `AtomicFact` 类型的值都是"逻辑上可能的"。
-- ============================================================================

type LogicalSpace = AtomicFact

-- ============================================================================
-- TLP 3.03: "我们不能思考任何不合逻辑的东西..."
-- (We cannot think anything unlogical...)
--
-- TLP 3.032: "要在语言中表现任何"违背逻辑的"东西是不可能的..."
-- (To present in language anything which 'contradicts logic' is as impossible as...)
--
-- TLP 3.325: "为了避免这些错误，我们必须使用一种遵从"逻辑语法"的符号系统"
-- (In order to avoid these errors, we must employ a symbolism which obeys... 'logical grammar'...)
--
-- TLP 4.003: "有关哲学的大多数命题和问题，不是假的，而是无意义的。"
-- (Most propositions and questions... are not false, but senseless.)
--
-- 在这里，"无意义的" (Nonsense) 命题将导致一个类型错误。
-- ============================================================================

-- 以下代码如果取消注释，将导致编译时错误：
--
-- senselessFact :: AtomicFact
-- senselessFact = Loves Apple Table
--
-- {-
--     ^
--     [编译时错误 (Compile-Time Error)]
--     • Couldn't match type 'SpatialObject' with 'Person'
--       Expected type: Person
--         Actual type: SpatialObject
--     • In the first argument of 'Loves', namely 'Apple'
--     
--     这就是 TLP 4.003: "有关哲学的大多数命题...不是假的，而是无意义的。"
--     编译器 (逻辑) 阻止我们 "言说" 这个无意义的命题。
-- -}

-- ============================================================================
-- 改进：现在我们可以自动派生 Eq, Ord, Show
-- 因为 CoreTypes.hs 中的所有对象现在都有了正确的 Eq, Ord, Show
-- ============================================================================

deriving instance Eq AtomicFact
deriving instance Ord AtomicFact
deriving instance Show AtomicFact
