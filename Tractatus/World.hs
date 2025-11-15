-- TRACTATUS/World.hs
-- 实在：世界
-- (Reality: The World)
--
-- "世界"是 实际存在 的事实的总体。"实在"（Reality）是存在和不存在的原子事实的总和。
--
-- 改进：现在 worldDB 可以正确区分不同的事实了，因为 AtomicFact 有了正确的 Eq 实例。

module Tractatus.World where

import Tractatus.Logic
import Tractatus.CoreTypes
import qualified Data.Set as Set

-- ============================================================================
-- TLP 1: "世界是所有实际情况的总和。"
-- (The world is everything that is the case.)
--
-- TLP 1.1: "世界是事实的总体，而不是事物的总体。"
-- (The world is the totality of facts, not of things.)
--
-- TLP 1.11: "世界由诸事实所规定，并由'这些事实就是全部事实'这一点所规定。"
-- (The world is determined by the facts, and by these being all the facts.)
--
-- TLP 2.04: "现存的原子事实的总体就是世界。"
-- (The totality of existent atomic facts is the world.)
--
-- TLP 2.06: "原子事实的存在和不存在就是实在。"
-- (The existence and non-existence of atomic facts is the reality.)
--
-- TLP 2.063: "全部实在就是世界。"
-- (The total reality is the world.)
--
-- "世界" (TheWorld) 是一个函数，它定义了"实在" (Reality)。
-- 它告诉我们"逻辑空间"中的哪些事实"是实际情况" (is the case)。
-- ============================================================================

type TheWorld = AtomicFact -> Bool

-- ============================================================================
-- TLP 1.21: "任何一个事实，都可以是实际情况，也可以不是，而其他一切则保持不变。"
-- (Any one can either be the case or not be the case, and everything else remain the same.)
--
-- 这是一个可能的"世界"实例。
-- ============================================================================

-- ============================================================================
-- 改进：现在这个集合可以正确区分事实了
-- (IsOn Apple Table) 不再等于 (IsOn Book Chair)
-- ============================================================================

worldDB :: Set.Set AtomicFact
worldDB = Set.fromList
    [ (IsOn Apple Table)        -- 这个事实 *存在*
    , (IsColored Apple Red)      -- 这个事实 *存在*
    , (AtTime John Morning)      -- 这个事实 *存在*
    ]

-- 主要的"世界"定义，使用 Set 方式
theRealWorld :: TheWorld
theRealWorld fact = Set.member fact worldDB

-- ============================================================================
-- TLP 2.061: "原子事实是相互独立的。"
-- (Atomic facts are independent of one another.)
--
-- TLP 2.062: "从一个原子事实的存在或不存在，我们不能推断另一个原子事实的存在或不存在。"
-- (From the existence or non-existence of an atomic fact we cannot infer
--  the existence or non-existence of another.)
-- ============================================================================
