{-# LANGUAGE GADTs #-}

module Genetics where

import Control.Monad.Random

import Util

--------------------------------------------------------------------------------
-- Allele
--------------------------------------------------------------------------------

data AlleleType = Dominant | Recessive
                deriving (Eq, Show)

type AlleleDescription = String
type AlleleRepresentation = Char

data Allele g where
    Allele :: (Gene g) => AlleleDescription ->
                          AlleleRepresentation ->
                          AlleleType ->
                          Allele g

instance Show (Allele g) where
    show (Allele d r t) = [r]

instance Eq (Allele g) where
    (Allele d1 r1 t1) == (Allele d2 r2 t2) =
        d1 == d2 && r1 == r2 && t1 == t2

--------------------------------------------------------------------------------
-- Gene
--------------------------------------------------------------------------------

class Gene g where
    alleles :: [Allele g]

--------------------------------------------------------------------------------
-- Genotype
--------------------------------------------------------------------------------

data Genotype g = Genotype (Allele g) (Allele g)
                deriving (Eq, Show)

alphaAllele :: Genotype g -> Allele g
alphaAllele (Genotype a b) = a

betaAllele :: Genotype g -> Allele g
betaAllele (Genotype a b) = b

randomAllele :: (RandomGen r) => Genotype g -> Rand r (Allele g)
randomAllele genotype =
    randomChoice [alphaAllele genotype, betaAllele genotype]

cross :: (RandomGen r) =>
         Genotype g -> Genotype g -> Rand r (Genotype g)
cross a b = do
    ra <- randomAllele a
    rb <- randomAllele b
    return (Genotype ra rb)

crossMany :: (RandomGen r) =>
             Integer ->
             Genotype g ->
             Genotype g ->
             Rand r [Genotype g]
crossMany = crossMany' []
    where crossMany' gs 0 a b = return gs
          crossMany' gs n a b = do
            child <- cross a b
            crossMany' (child : gs) (n - 1) a b
