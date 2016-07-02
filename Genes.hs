module Genes where

import Genetics

--------------------------------------------------------------------------------
-- Genes
--------------------------------------------------------------------------------

-- Hair Style

data HairStyle = HairStyle

curlyHair = Allele "Curly Hair" 'C' Dominant
straightHair = Allele "Straight Hair" 'c' Recessive

instance Gene HairStyle where
    alleles = [curlyHair, straightHair]

-- Hair Color

data HairColor = HairColor

brownHair = Allele "Brown Hair" 'B' Dominant
blondeHair = Allele "Blonde Hair" 'b' Recessive
redHair = Allele "Red Hair" 'r' Recessive

instance Gene HairColor where
    alleles = [brownHair, blondeHair, redHair]
