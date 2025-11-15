-- TRACTATUS/Language.hs
-- 语言：命题
-- (Language: Propositions)
--
-- 这个模块定义"命题"（Satz）。TLP 5 说："命题是基本命题的真值函项。"
-- 我们将"命题"的**句法（Syntax）和语义（Semantics）**分开。

module Tractatus.Language where

import Tractatus.Logic
import Tractatus.World

-- ============================================================================
-- 1. 命题的"句法" (Syntax)
-- ============================================================================

-- TLP 4: "思想是有意义的命题。"
-- (The thought is the significant proposition.)

-- TLP 4.001: "命题的总体就是语言。"
-- (The totality of propositions is the language.)

-- TLP 4.21: "最简单的命题，即基本命题，断定一个原子事实的存在。"
-- (The simplest proposition, the elementary proposition, asserts the existence of an atomic fact.)

-- TLP 5: "命题是基本命题的真值函项。"
-- (Propositions are truth-functions of elementary propositions.)

-- TLP 5.01: "基本命题是命题的真值自变项。"
-- (The elementary propositions are the truth-arguments of propositions.)

data Proposition =
    -- 一个基本命题 (p, q, r...)
    Elem AtomicFact
    
    -- 复合命题
    | Not Proposition
    | And Proposition Proposition
    | Or  Proposition Proposition
    | Implies Proposition Proposition
    | Iff Proposition Proposition
    deriving (Eq, Show)

-- ============================================================================
-- TLP 2.221: "图像所表现的东西，是它的意义 (Sinn)。"
-- (What the picture represents is its sense.)
--
-- 在我们的框架中，"意义" (Sinn) 就是这个 `Proposition` 的句法结构本身。
-- 它"展示" (shows) 了一个可能的真值条件。
-- ============================================================================

-- ============================================================================
-- 2. 命题的"语义" (Semantics) / "真假" (Truth/Falsity)
-- ============================================================================

-- TLP 2.222: "它的真或假在于它的意义与实在的一致或不一致。"
-- (In the agreement or disagreement of its sense with reality, its truth or falsity consists.)

-- TLP 2.223: "要发现图像是真是假，我们必须把它与实在相比较。"
-- (In order to discover whether the picture is true or false we must compare it with reality.)

-- TLP 4.024: "理解一个命题，就是知道如果它为真，实际情况是怎样的。"
-- (To understand a proposition means to know what is the case, if it is true.)

-- `eval` 函数就是"比较"的过程。
-- 它接受一个"世界"（实在）和一个"命题"（意义），
-- 并返回一个"真值"（真或假）。

eval :: TheWorld -> Proposition -> Bool
eval world (Elem fact)           = world fact
eval world (Not p)               = not (eval world p)
eval world (And p q)             = (eval world p) && (eval world q)
eval world (Or p q)              = (eval world p) || (eval world q)
eval world (Implies p q)         = not (eval world p) || (eval world q)
eval world (Iff p q)             = (eval world p) == (eval world q)

-- ============================================================================
-- TLP 6.1: "逻辑的命题是重言式。"
-- (The propositions of logic are tautologies.)
--
-- TLP 6.11: "逻辑的命题因此不作任何陈述。（它们是分析命题。）"
-- (The propositions of logic therefore say nothing. (They are the analytical propositions.))
--
-- TLP 6.113: "逻辑命题的特征是：人们*仅凭符号*就能认识到它们是真的..."
-- (It is the characteristic mark of logical propositions that one can
--  perceive *in the symbol alone* that they are true...)
--
-- 我们可以写一个函数来 *静态分析* 命题的"逻辑属性"
-- (这超出了基础框架，但展示了可能性)
-- ============================================================================

-- 检查一个命题是否是重言式（在所有可能的世界中都为真）
-- 注意：这是一个简化的实现，实际应该检查所有可能的世界
-- 在完整实现中，我们需要枚举所有可能的原子事实组合
isTautology :: Proposition -> Bool
isTautology prop = 
    -- 在完整实现中，我们应该检查所有可能的实在
    -- 这里我们检查一些样本实在（包括 theRealWorld 和一些极端情况）
    let sampleWorlds = 
            [ theRealWorld  -- 实际世界
            , \_ -> True    -- 所有事实都为真的世界
            , \_ -> False   -- 所有事实都为假的世界
            , \f -> case f of (IsOn _ _) -> True; _ -> False  -- 只有 IsOn 为真
            , \f -> case f of (IsColored _ _) -> True; _ -> False  -- 只有 IsColored 为真
            ]
    in all (flip eval prop) sampleWorlds

-- 检查一个命题是否是矛盾式（在所有可能的世界中都为假）
isContradiction :: Proposition -> Bool
isContradiction prop = isTautology (Not prop)

-- ============================================================================
-- TLP 4.22: "基本命题由名称组成。它是名称的联结、连接。"
-- (The elementary proposition consists of names. It is a connexion, a concatenation, of names.)
--
-- TLP 4.25: "如果基本命题是真的，原子事实就存在；如果基本命题是假的，原子事实就不存在。"
-- (If the elementary proposition is true, the atomic fact exists;
--  if it is false the atomic fact does not exist.)
-- ============================================================================

