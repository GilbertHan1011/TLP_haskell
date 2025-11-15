-- Main.hs
-- 总览：执行与分析
-- (Overview: Execution and Analysis)
--
-- 现在我们可以把所有东西放在一起，清晰地展示 TLP 的核心论点。
--
-- 改进：使用新的构造函数（Apple 而不是 apple，John 而不是 john）

module Main where

import Tractatus.CoreTypes
import Tractatus.Logic
import Tractatus.World
import Tractatus.Language

-- ============================================================================
-- 我们来定义一些"有意义的" (sensical) 命题
-- ============================================================================

-- TLP 4.024: "理解一个命题，就是知道如果它为真，实际情况是怎样的。"
-- (To understand a proposition means to know what is the case, if it is true.)

-- p: "苹果在桌子上"
p :: Proposition
p = Elem (IsOn Apple Table)

-- q: "约翰爱玛丽"
q :: Proposition
q = Elem (Loves John Mary)

-- r: "苹果是红色的"
r :: Proposition
r = Elem (IsColored Apple Red)

-- s: "约翰在早晨"
s :: Proposition
s = Elem (AtTime John Morning)

-- 复合命题: "苹果在桌子上 并且 约翰不爱玛丽"
complexProp :: Proposition
complexProp = And p (Not q)

-- ============================================================================
-- TLP 6.1: "逻辑的命题是重言式。"
-- (The propositions of logic are tautologies.)
--
-- TLP 6.11: "逻辑的命题因此不作任何陈述。（它们是分析命题。）"
-- (The propositions of logic therefore say nothing. (They are the analytical propositions.))
--
-- TLP 6.113: "人们*仅凭符号*就能认识到它们是真的..."
-- (It is the characteristic mark of logical propositions that one can
--  perceive *in the symbol alone* that they are true...)
-- ============================================================================

-- 重言式: "苹果在桌子上 或 苹果不在桌子上"
tautology :: Proposition
tautology = Or p (Not p)

-- 矛盾式: "苹果在桌子上 并且 苹果不在桌子上"
contradiction :: Proposition
contradiction = And p (Not p)

-- 排中律: p ∨ ~p
law_of_excluded_middle :: Proposition
law_of_excluded_middle = Or p (Not p)

-- 矛盾律: ~(p & ~p)
law_of_contradiction :: Proposition
law_of_contradiction = Not (And p (Not p))

-- ============================================================================
-- 主函数
-- ============================================================================

main :: IO ()
main = do
    putStrLn "======================================================================"
    putStrLn "--- 维特根斯坦的《逻辑哲学论》Haskell 重构 ---"
    putStrLn "--- Wittgenstein's Tractatus Logico-Philosophicus in Haskell ---"
    putStrLn "======================================================================"
    putStrLn ""
    
    -- ========================================================================
    -- 1. "有意义的、真的"命题 (Sensical, True)
    --    `eval` 返回 True
    -- ========================================================================
    putStrLn "1. 有意义的、真的命题 (Sensical, True Propositions):"
    putStrLn "   ----------------------------------------------------"
    putStrLn $ "   命题 'p' (苹果在桌上): " ++ show (eval theRealWorld p)
    putStrLn $ "   命题 'r' (苹果是红色的): " ++ show (eval theRealWorld r)
    putStrLn $ "   命题 's' (约翰在早晨): " ++ show (eval theRealWorld s)
    putStrLn ""
    
    -- ========================================================================
    -- 2. "有意义的、假的"命题 (Sensical, False)
    --    `eval` 返回 False
    -- ========================================================================
    putStrLn "2. 有意义的、假的命题 (Sensical, False Propositions):"
    putStrLn "   ----------------------------------------------------"
    putStrLn $ "   命题 'q' (约翰爱玛丽): " ++ show (eval theRealWorld q)
    putStrLn ""
    
    -- ========================================================================
    -- 3. "复合命题" (Complex Propositions)
    -- ========================================================================
    putStrLn "3. 复合命题 (Complex Propositions):"
    putStrLn "   ----------------------------------------------------"
    putStrLn $ "   命题 'complexProp' (苹果在桌上 并且 约翰不爱玛丽): " 
               ++ show (eval theRealWorld complexProp)
    putStrLn ""
    
    -- ========================================================================
    -- 4. "逻辑命题"（重言式）
    --    它不依赖于 `theRealWorld` 是什么。
    -- ========================================================================
    putStrLn "4. 逻辑命题 - 重言式 (Logical Propositions - Tautologies):"
    putStrLn "   ----------------------------------------------------"
    putStrLn $ "   命题 'tautology' (p or not p): " ++ show (eval theRealWorld tautology)
    putStrLn $ "   命题 'law_of_excluded_middle' (排中律): " 
               ++ show (eval theRealWorld law_of_excluded_middle)
    putStrLn $ "   命题 'law_of_contradiction' (矛盾律): " 
               ++ show (eval theRealWorld law_of_contradiction)
    putStrLn ""
    putStrLn "   TLP 6.1: '逻辑的命题因此不作任何陈述。'"
    putStrLn "   (The propositions of logic therefore say nothing.)"
    putStrLn ""
    
    -- ========================================================================
    -- 5. "矛盾式" (Contradictions)
    -- ========================================================================
    putStrLn "5. 矛盾式 (Contradictions):"
    putStrLn "   ----------------------------------------------------"
    putStrLn $ "   命题 'contradiction' (p and not p): " 
               ++ show (eval theRealWorld contradiction)
    putStrLn ""
    
    -- ========================================================================
    -- 6. "无意义的"命题 (Nonsensical)
    --    我们甚至不能写这个 `main` 函数，
    --    因为它根本无法被编译！
    -- ========================================================================
    putStrLn "6. 无意义的命题 (Nonsensical Propositions):"
    putStrLn "   ----------------------------------------------------"
    putStrLn "   命题 'nonsense' (苹果爱桌子): 无法编译 (Type Error)"
    putStrLn ""
    putStrLn "   TLP 3.03: '我们不能思考任何不合逻辑的东西...'"
    putStrLn "   TLP 4.003: '有关哲学的大多数命题...不是假的，而是无意义的。'"
    putStrLn ""
    putStrLn "   如果我们尝试写:"
    putStrLn "   let nonsense = Elem (Loves Apple Table)"
    putStrLn "   编译器会报错："
    putStrLn "   • Couldn't match type 'SpatialObject' with 'Person'"
    putStrLn "   这就是'逻辑语法'（类型系统）在起作用。"
    putStrLn ""
    

    -- ========================================================================
    -- 7. 框架总结
    -- ========================================================================
    putStrLn "======================================================================"
    putStrLn "框架总结 (Framework Summary):"
    putStrLn "======================================================================"
    putStrLn ""
    putStrLn "• 逻辑形式 (Logical Form):"
    putStrLn "  由 AtomicFact GADT 强制执行。"
    putStrLn ""
    putStrLn "• 可说的/有意义的 (Sensical):"
    putStrLn "  所有类型正确的 Proposition 值。"
    putStrLn ""
    putStrLn "• 不可说的/无意义的 (Nonsensical):"
    putStrLn "  导致 Type Error 的代码。"
    putStrLn ""
    putStrLn "• 世界 (The World):"
    putStrLn "  一个类型为 AtomicFact -> Bool 的函数。"
    putStrLn ""
    putStrLn "• 真/假 (True/False):"
    putStrLn "  eval 函数在 TheWorld 上的运行时结果。"
    putStrLn ""
    putStrLn "• 逻辑命题 (Logic):"
    putStrLn "  那些在所有可能的 TheWorld 上 eval 结果都为 True 的 Proposition（即重言式）。"
    putStrLn ""
    putStrLn "======================================================================"
    putStrLn "TLP 7: '对于不可言说的东西，我们必须保持沉默。'"
    putStrLn "(Whereof one cannot speak, thereof one must be silent.)"
    putStrLn "======================================================================"
    putStrLn ""
    putStrLn "编译器 (The Compiler) 强制我们保持沉默 (enforces silence)。"
    putStrLn ""
