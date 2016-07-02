# Hendel
Mendelian Genetics in Haskell

## Usage
To build:
```
./build.sh
```

To clean (remove generated files):
```
./clean.sh
```

To run:
```
./hendel n aIndex bIndex
```
where:
- `n` is the number of offspring to generate
- `aIndex` and `bIndex` are values from `0` to `3` as described in the next section used for the genotype of the parents (the first parent gets its genotype from `aIndex`; the second parent gets its genotype from `bIndex`)

### `aIndex` and `bIndex`

`aIndex` and `bIndex` are numbers that correspond to different genotypes (as follows):
- `0`: Cc
- `1`: Cc
- `2`: cC
- `3`: cc

## GHCi

It is recommended to play with this program via GHCi, creating whatever genes, genotypes, and crosses you would like. See the file `Genes.hs` for examples of genes, and `Main.hs` for how to cross genotypes.
