module Main where

import Control.Monad.Random
import System.Environment
import System.IO

import Genetics
import Genes
import Util

--------------------------------------------------------------------------------
-- Main
--------------------------------------------------------------------------------

hendel :: Integer -> Int -> Int -> IO ()
hendel n aIndex bIndex = do
    let gs = [ Genotype curlyHair curlyHair
             , Genotype curlyHair straightHair
             , Genotype straightHair curlyHair
             , Genotype straightHair straightHair
             ]
        [cc, cs, sc, ss] = gs
        a = gs !! aIndex
        b = gs !! bIndex
    putStrLn ""
    putStrLn $ "[" ++ show a ++ "] cross [" ++ show b ++ "]"
    children <- evalRandIO $ crossMany n a b
    putStrLn ""
    putStrLn $ "Results:"
    putStrLn $ "--------"
    let counts = [ count cc children
                 , count cs children
                 , count sc children
                 , count ss children
                 ]
        freqs = map (/ fromIntegral n) counts
        s = map (\(g, c, f) -> show g ++ ": " ++ show (round c) ++
                               " (" ++ show (round (100 * f)) ++ "%)")
                (zip3 gs counts freqs)
    mapM_ putStrLn s
    putStrLn ""

main :: IO ()
main = do
    args <- getArgs
    progName <- getProgName
    if (length args /= 3) then do
        hPutStrLn stderr $ "Usage: ./" ++ progName ++ " n aIndex bIndex"
    else do
        let [nString, aIndexString, bIndexString] = args
            n = read nString
            aIndex = read aIndexString
            bIndex = read bIndexString
        hendel n aIndex bIndex
