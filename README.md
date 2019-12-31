
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
ia = c(0, 10, 5, 0, 0)
ib = c(25, 27, 13, 15, 12)
ic = c(18, 12, 12, 6.1, 5.1)

esg(ia, ib, ic, type = "esg1")
#[1] 30.80 38.80 22.60 15.66 12.66

## %Coverage ESG II
iia = c(2.2, 5, 6.55, 55.05, 60.05)
iib = c(69.85, 43.1, 36.85, 34.4, 55)

esg(iia, iib, 0, type = "esg2")
#[1]  71.61  47.10  42.09  78.44 103.04
```

## Ecological Evaluation Index

<img src="https://latex.codecogs.com/svg.latex?x%20=%20\frac{ESGI}{100};%20\quad%20y%20=%20\frac{ESGII}{100}" title="xy" />


<a href="https://www.codecogs.com/eqnedit.php?latex=eei&space;=&space;\begin{cases}&space;esi=a&plus;b\cdot&space;x&plus;c\cdot&space;x^2&plus;d\cdot&space;y&plus;e\cdot&space;y^2&plus;f\cdot&space;x\cdot&space;y&space;&&space;\\&space;hyp=2&plus;8\cdot&space;esi&&space;\\&space;eei_c=\begin{cases}&space;hyp&space;&&space;\\&space;2&space;&&space;\text{&space;if&space;}&space;hyp<2\\&space;\end{cases}&&space;\end{cases}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?eei&space;=&space;\begin{cases}&space;esi=a&plus;b\cdot&space;x&plus;c\cdot&space;x^2&plus;d\cdot&space;y&plus;e\cdot&space;y^2&plus;f\cdot&space;x\cdot&space;y&space;&&space;\\&space;hyp=2&plus;8\cdot&space;esi&&space;\\&space;eei_c=\begin{cases}&space;hyp&space;&&space;\\&space;2&space;&&space;\text{&space;if&space;}&space;hyp<2\\&space;\end{cases}&&space;\end{cases}" title="eei" /></a>

where: *x* is the score in *ESG I*, *y* is the score in *ESG II*
and *a*, *b*, *c*, *d*, *e* and *f* are the coefficients of the hyperbola.

```r
esg1 = c(9, 38.8, 22.6, 15.66)
esg2 = c(97, 47.1, 42.09, 78.44)

esi = eei(esg1, esg2, "esi")
#[1] -0.05634860  0.43121705  0.63437407  0.06959875

hyp = eei(esg1, esg2, "hyp")
#[1] 1.549211 5.449736 7.074993 2.556790

eeic = eei(esg1, esg2, "eeic")
#[1] 2.000000 5.449736 7.074993 2.556790
```

## Ecological Quality Ratio

<a href="https://www.codecogs.com/eqnedit.php?latex=eqr=\begin{cases}&space;1.25\cdot&space;(eei_c/RC)&space;&&space;\text{&space;if&space;}&space;eei_c\leq10&space;\\&space;1&space;&&space;\text{&space;if&space;}&space;eei_c>10&space;\\&space;0&space;&&space;\text{&space;if&space;}&space;eei_c<0&space;\end{cases}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?eqr=\begin{cases}&space;1.25\cdot&space;(eei/RC)&space;&&space;\text{&space;if&space;}&space;eei\leq10&space;\\&space;1&space;&&space;\text{&space;if&space;}&space;eei>10&space;\\\\&space;0&space;&&space;\text{&space;if&space;}&space;eei<0&space;\end{cases}" title="eqr" /></a>

Where: *RC* = 10

```r
eqr(eeic)
#[1] 0.00000000 0.43121705 0.34064851 0.06959875
```

## Ecological Status Class

<img src="https://latex.codecogs.com/svg.latex?ESC%20=\begin{cases}Bad%20%20&%20\text{if%20}%20eei%20\leq%202%20\\Poor%20&%20\text{if%20}%202%20%3C%20eei%20\leq%204%20\\Moderate%20&%20\text{if%20}%204%20%3C%20eei%20\leq%206%20\\Good%20&%20\text{if%20}%206%20%3C%20eei%20\leq%208%20\\High%20&%20\text{if%20}%20eei%20%3E%208\end{cases}" title="classes" />

```r
esc(eeic)
#[1] "Bad"      "Moderate" "Good"     "Poor" 
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

> Caldeira, A. Q., De Paula, J. C., Reis, R. P., & Giordano, R. G. (2017). Structural and functional losses in macroalgal assemblages in a southeastern Brazilian bay over more than a decade. Ecological Indicators, 75, 242–248. https://doi.org/10.1016/j.ecolind.2016.12.029

> Caldeira, A. Q., & Reis, R. P. (2019). Brazilian macroalgae assemblages analyzed using the ecological evaluation index (EEI-c). Ocean & Coastal Management, 104927. https://doi.org/10.1016/j.ocecoaman.2019.104927
 
