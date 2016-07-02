module Util where

import Control.Monad.Random

--------------------------------------------------------------------------------
-- Utilities
--------------------------------------------------------------------------------

randomChoice :: (RandomGen r) => [a] -> Rand r a
randomChoice xs = do
    rndIndex <- getRandomR (0, length xs - 1)
    return (xs !! rndIndex)

count :: (Eq a, Num n) => a -> [a] -> n
count x = fromIntegral . length . filter (== x)
