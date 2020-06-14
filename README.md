
# eeiR - Ecological Evaluation Index


<p align="center">
<img src="https://github.com/salah31416/eeiR/raw/master/inst/figures/macro.png" 
alt="Classes" width="35%"/>
</p>

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3609316.svg)](https://doi.org/10.5281/zenodo.3609316)


# Installation

```r
install.packages("devtools")

devtools::install_github("salah31416/eeiR")
```

## Ecological Status Group


```r
## %Coverage ESG I
ia = c(0, 10, 5, 0, 0)
ib = c(25, 27, 13, 15, 12)
ic = c(18, 12, 12, 6.1, 5.1)

## %Coverage ESG II
iia = c(2.2, 5, 6.55, 55.05, 60.05)
iib = c(69.85, 43.1, 36.85, 34.4, 55)

## ESG I
esg1 = esg("1", ia, ib, ic)
#[1] 30.80 38.80 22.60 15.66 12.66

## ESG II
esg2 = esg("2", iia, iib, 0)
#[1]  71.61  47.10  42.09  78.44 103.04
```

## Ecological Evaluation Index

```r
## hyp
hyp = eei(esg1, esg2, "hyp")
#[1]  0.22081475  0.43121705  0.34064851  0.06959875 -0.04513925

## ESI
esi = eei(esg1, esg2, "esi")
#[1] 3.766518 5.449736 4.725188 2.556790 1.638886

## EEIc
eeic = eei(esg1, esg2, "eeic")
#[1] 3.766518 5.449736 4.725188 2.556790 2.000000
```

## Ecological Quality Ratio

```r
## EQR
eqr(esi)
#[1]  0.22081475  0.43121705  0.34064851  0.06959875 -0.04513925

eqr(eeic)
#[1] 0.22081475 0.43121705 0.34064851 0.06959875 0.00000000
```

## Ecological Status Class


```r
## ESC
esc(eeic)
#[1] "Low"     "Moderate" "Moderate" "Low"     "Bad"
```


# References

> Caldeira, A.Q., De Paula, J.C., Reis, R.P., Giordano, R.G., 2017. Structural and functional losses in macroalgal assemblages in a southeastern Brazilian bay over more than a decade. Ecological Indicators 75, 242–248. https://doi.org/10.1016/j.ecolind.2016.12.029

> Caldeira, A.Q., Reis, R.P., 2019. Brazilian macroalgae assemblages analyzed using the ecological evaluation index (EEI-c). Ocean & Coastal Management 104927. https://doi.org/10.1016/j.ocecoaman.2019.104927

> Orfanidis, S., Dencheva, K., Nakou, K., Tsioli, S., Papathanasiou, V., Rosati, I., 2014. Benthic macrophyte metrics as bioindicators of water quality: Towards overcoming typological boundaries and methodological tradition in Mediterranean and Black Seas. Hydrobiologia 740, 61–78. https://doi.org/10.1007/s10750-014-1938-x

> Orfanidis, S., Panayotidis, P., Stamatis, N., 2003. An insight to the ecological evaluation index (EEI). Ecological Indicators 3, 27–33. https://doi.org/10.1016/s1470-160x(03)00008-6

> Orfanidis, S., Panayotidis, P., Ugland, K., 2011. Ecological Evaluation Index Continuous Formula (EEI-c) Application: A Step Forward For Functional Groups, The Formula And Reference Condition Values. Mediterranean Marine Science 12, 199. https://doi.org/10.12681/mms.60

> Orfanidis, S., Pinna, M., Sabetta, L., Stamatis, N., Nakou, K., 2008. Variation of structural and functional metrics in macrophyte communities within two habitats of eastern Mediterranean coastal lagoons: Natural versus human effects. Aquatic Conservation: Marine and Freshwater Ecosystems 18, S45–S61. https://doi.org/10.1002/aqc.957
 
