
# eeiR - Ecological Evaluation Index


<p align="center">
<img src="https://github.com/salah31416/eeiR/raw/master/inst/figures/macro.png" 
alt="Classes" width="35%"/>
</p>


## Contents

* [Installation](#installation)
* [Ecological Status Group - ESG](#ecological-status-group)
* [Ecological Evaluation Index - EEI-c](#ecological-evaluation-index)
* [Ecological Status Class - ESC](#ecological-status-class)
* [Ecological Quality Ratio - EQR](#ecological-quality-ratio)
* [Data ESG](#data-esg)
* [Graphics](#graphics)


# Installation

```r
install.packages("devtools")

devtools::install_github("salah31416/eeiR")
```

## Ecological Status Group

<img src="https://latex.codecogs.com/svg.latex?\Large&space;ESG%20I%20(\%%20coverage)%20=%20(IA%20\cdot%201)%20+%20(IB%20\cdot%200.8)%20+%20(IC%20\cdot%200.6)" title="ESGI" />

<img src="https://latex.codecogs.com/svg.latex?ESG%20II%20(\%%20coverage)%20=%20(IIA%20\cdot%200.8)%20+%20(IIB%20\cdot%201)%20+%20(IIC%20\cdot%201)" title=ESG2 />


```r
## %Coverage ESG I
ia = c(0, 10, 5, 0, 0, 0, 15, 25, 22, 43, 55, 6)
ib = c(25, 27, 13, 15, 12, 25, 20, 28, 7.5, 20, 7, 10)
ic = c(18, 12, 12, 6.1, 5.1, 2, 5.05, 2.05, 5.05, 5.1, 21, 3)

## %Coverage ESG II
iia = c(2.2, 5, 6.55, 55.05, 60.05, 28.15, 8.05, 8.05, 9.05, 16, 15.6, 22.5)
iib = c(69.85, 43.1, 36.85, 34.4, 55, 49.85, 44.45, 48.75, 41.65, 17.5, 19, 16.95)

df = data.frame(ESGI = esg(ia, ib, ic, type = "esg1"), ESGII = esg(iia, iib, type = "esg2"))
#    ESGI  ESGII
#1  30.80  71.61
#2  38.80  47.10
#3  22.60  42.09
#4  15.66  78.44
#5  12.66 103.04
#6  21.20  72.37
#7  34.03  50.89
#8  48.63  55.19
#9  31.03  48.89
#10 62.06  30.30
#11 73.20  31.48
#12 74.80  34.95
```

## Ecological Evaluation Index

<img src="https://latex.codecogs.com/svg.latex?x%20=%20\frac{ESGI}{100};%20\quad%20y%20=%20\frac{ESGII}{100}" title="xy" />

<img src="https://latex.codecogs.com/svg.latex?p(x,y)%20=%20a%20+%20b\cdot%20x%20+%20c\cdot%20x^2%20+%20d\cdot%20y%20+%20e\cdot%20y^2%20+%20f\cdot%20x\cdot%20y" title="eqr" />

<img src="https://latex.codecogs.com/svg.latex?eei%20=%202%20+%208%20\cdot%20p(x,%20y)" title="eei" />

where: *x* is the score in *ESG I*, *y* is the score in *ESG II*
and *a*, *b*, *c*, *d*, *e* and *f* are the coefficients of the hyperbola.

```r
esg1 = c(30.8, 38.8, 22.6, 15.66, 12.66, 21.2, 34.03, 48.63, 31.03, 62.06, 73.2, 74.8)
esg2 = c(71.61, 47.1, 42.09, 78.44, 103.04, 72.37, 50.89, 55.19, 48.89, 30.3, 31.48, 34.95)

eeic(esg1, esg2)
#     N  ESG1   ESG2        EQR      EEI      ESC
# 1:  1 30.80  71.61 0.21970761 3.757661     Poor
# 2:  2 38.80  47.10 0.43098923 5.447914 Moderate
# 3:  3 22.60  42.09 0.32081942 4.566555 Moderate
# 4:  4 15.66  78.44 0.05562272 2.444982     Poor
# 5:  5 12.66 103.04 0.00000000 2.000000      Bad
# 6:  6 21.20  72.37 0.13112933 3.049035     Poor
# 7:  7 34.03  50.89 0.36382817 4.910625 Moderate
# 8:  8 48.63  55.19 0.45413015 5.633041 Moderate
# 9:  9 31.03  48.89 0.35091334 4.807307 Moderate
#10: 10 62.06  30.30 0.75007118 8.000569     High
#11: 11 73.20  31.48 0.81323800 8.505904     High
#12: 12 74.80  34.95 0.79095191 8.327615     High
```

## Ecological Quality Ratio

<img src="https://latex.codecogs.com/svg.latex?EQR%20%3D%5Cbegin%7Bcases%7D%201.25%5Ccdot%28EEI_c/RC%29-0.25%5Cquad%5Ctext%7Bfor%20%7DEEI_c%5Cleq10%26%20%5C%5C%201%5Cquad%5Ctext%7Bfor%20%7DEEI_c%3E10%26%20%5Cend%7Bcases%7D" title="eqr" />

Where: *RC* = 10

```r
eei = c(3.75766, 5.44791, 4.56655, 2.44498, 2, 3.04903, 4.91062, 5.63304, 4.80731, 8.00057, 8.505904, 8.32761)

df = data.frame(EEI = eei, EQR = eqr(eei))
#        EEI       EQR
#1  3.757660 0.2197075
#2  5.447910 0.4309888
#3  4.566550 0.3208188
#4  2.444980 0.0556225
#5  2.000000 0.0000000
#6  3.049030 0.1311288
#7  4.910620 0.3638275
#8  5.633040 0.4541300
#9  4.807310 0.3509138
#10 8.000570 0.7500712
#11 8.505904 0.8132380
#12 8.327610 0.7909512
```

## Ecological Status Class

<img src="https://latex.codecogs.com/svg.latex?ESC%20=\begin{cases}Bad%20%20&%20\text{for%20}%20eei%20\leq%202%20\\Poor%20&%20\text{for%20}%202%20%3C%20eei%20\leq%204%20\\Moderate%20&%20\text{for%20}%204%20%3C%20eei%20\leq%206%20\\Good%20&%20\text{for%20}%206%20%3C%20eei%20\leq%208%20\\High%20&%20\text{for%20}%20eei%20%3E%208\end{cases}" title="classes" />

```r
ei = seq(0, 10, .5)
df = data.frame(EEI = ei, ESC = esc(ei))
#    EEI      ESC
#1   0.0      Bad
#2   0.5      Bad
#3   1.0      Bad
#4   1.5      Bad
#5   2.0      Bad
#6   2.5     Poor
#7   3.0     Poor
#8   3.5     Poor
#9   4.0     Poor
#10  4.5 Moderate
#11  5.0 Moderate
#12  5.5 Moderate
#13  6.0 Moderate
#14  6.5     Good
#15  7.0     Good
#16  7.5     Good
#17  8.0     Good
#18  8.5     High
#19  9.0     High
#20  9.5     High
#21 10.0     High
```


## Graphics

<p align="center">
<img src="https://github.com/salah31416/eeiR/raw/master/inst/figures/classes.png" alt="Classes" width="45%"/>
<img src="https://github.com/salah31416/eeiR/raw/master/inst/figures/hyp.png" alt="Hyperbole" width="50%"/>
<img src="https://github.com/salah31416/eeiR/raw/master/inst/figures/k2.png" alt="Hyperbole 3D" width="50%"/>
</p>

# References

> Orfanidis, S., Panayotidis, P., & Stamatis, N. (2003). An insight to the ecological evaluation index (EEI). Ecological Indicators, 3(1), 27–33. doi:10.1016/s1470-160x(03)00008-6

> Orfanidis, S., Pinna, M., Sabetta, L., Stamatis, N., & Nakou, K. (2008). Variation of structural and functional metrics in macrophyte communities within two habitats of eastern Mediterranean coastal lagoons: natural versus human effects. Aquatic Conservation: Marine and Freshwater Ecosystems, 18(S1), S45–S61. doi:10.1002/aqc.957

> Orfanidis, S., Panayotidis, P., & Ugland, K. (2011). Ecological Evaluation Index Continuous Formula (EEI-c) Application: A Step Forward For Functional Groups, The Formula And Reference Condition Values. Mediterranean Marine Science, 12(1), 199. doi:10.12681/mms.60

> Orfanidis, S., Dencheva, K., Nakou, K., Tsioli, S., Papathanasiou, V., & Rosati, I. (2014). Benthic macrophyte metrics as bioindicators of water quality: towards overcoming typological boundaries and methodological tradition in Mediterranean and Black Seas. Hydrobiologia, 740(1), 61–78. doi:10.1007/s10750-014-1938-x
