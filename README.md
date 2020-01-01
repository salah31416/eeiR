
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

## %Coverage ESG II
iia = c(2.2, 5, 6.55, 55.05, 60.05)
iib = c(69.85, 43.1, 36.85, 34.4, 55)

## ESG I
esg1 = esg(ia, ib, ic, type = "esg1")
#[1] 30.80 38.80 22.60 15.66 12.66

## ESG II
esg2 = esg(iia, iib, 0, type = "esg2")
#[1]  71.61  47.10  42.09  78.44 103.04
```

## Ecological Evaluation Index

<img src="https://latex.codecogs.com/svg.latex?x%20=%20\frac{ESGI}{100};%20\quad%20y%20=%20\frac{ESGII}{100}" title="xy" />


<a href="https://www.codecogs.com/eqnedit.php?latex=EEI=\begin{cases}&space;esi=a&plus;bx&plus;cx^2&plus;dy&plus;ey^2&plus;fxy&space;\\\\&space;hyp=\begin{cases}&space;1&space;&&space;\text{&space;if&space;}&space;esi>1&space;\\&space;2&plus;8\cdot&space;esi&&space;\end{cases}&space;\\\\&space;eeic=\begin{cases}&space;2&space;&&space;\text{&space;if&space;}&space;hyp<2&space;\\&space;2&plus;8\cdot&space;hyp&&space;\end{cases}&space;\end{cases}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?EEI=\begin{cases}&space;esi=a&plus;bx&plus;cx^2&plus;dy&plus;ey^2&plus;fxy&space;\\\\&space;hyp=\begin{cases}&space;1&space;&&space;\text{&space;if&space;}&space;esi>1&space;\\&space;2&plus;8\cdot&space;esi&&space;\end{cases}&space;\\\\&space;eeic=\begin{cases}&space;2&space;&&space;\text{&space;if&space;}&space;hyp<2&space;\\&space;2&plus;8\cdot&space;hyp&&space;\end{cases}&space;\end{cases}" title="eei=\begin{cases} esi=a+bx+cx^2+dy+ey^2+fxy \\\\ hyp=\begin{cases} 1 & \text{ if } esi>1 \\ 2+8\cdot esi& \end{cases} \\\\ eeic=\begin{cases} 2 & \text{ if } hyp<2 \\ 2+8\cdot hyp& \end{cases} \end{cases}" /></a>

where: *x* is the score in *ESG I*, *y* is the score in *ESG II*
and *a*, *b*, *c*, *d*, *e* and *f* are the coefficients of the hyperbola.

```r
## ESI
esi = eei(esg1, esg2, "esi")
#[1]  0.22081475  0.43121705  0.34064851  0.06959875 -0.04513925

## Hyp
hyp = eei(esg1, esg2, "hyp")
#[1] 3.766518 5.449736 4.725188 2.556790 1.638886

## EEIc
eeic = eei(esg1, esg2, "eeic")
#[1] 3.766518 5.449736 4.725188 2.556790 2.000000
```

## Ecological Quality Ratio

<a href="https://www.codecogs.com/eqnedit.php?latex=EQR=1.25\cdot(x/10)-0.25" target="_blank"><img src="https://latex.codecogs.com/gif.latex?EQR=1.25\cdot(x/10)-0.25" title="EQR=1.25\cdot(x/10)-0.25" /></a>

Where: *RC* = 10; *x* = *hyp* or *eeic*

The result `eqr(hyp)` is equal to output `eei(esg1, esg2, "esi")`.

```r
eqr(hyp)
#[1]  0.22081475  0.43121705  0.34064851  0.06959875 -0.04513925

eqr(eeic)
#[1] 0.22081475 0.43121705 0.34064851 0.06959875 0.00000000
```

## Ecological Status Class

<a href="https://www.codecogs.com/eqnedit.php?latex=ESC=\begin{cases}&space;Bad&space;&&space;\text{&space;if&space;}&space;eeic\leq2&space;\\&space;Poor&space;&&space;\text{&space;if&space;}&space;2<eeic\leq4&space;\\&space;Moderate&space;&&space;\text{&space;if&space;}&space;4<eeic\leq6&space;\\&space;Good&space;&&space;\text{&space;if&space;}&space;6<eeic\leq8&space;\\&space;High&space;&&space;\text{&space;if&space;}&space;eeic>8&space;\end{cases}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?ESC=\begin{cases}&space;Bad&space;&&space;\text{&space;if&space;}&space;eeic\leq2&space;\\&space;Poor&space;&&space;\text{&space;if&space;}&space;2<eeic\leq4&space;\\&space;Moderate&space;&&space;\text{&space;if&space;}&space;4<eeic\leq6&space;\\&space;Good&space;&&space;\text{&space;if&space;}&space;6<eeic\leq8&space;\\&space;High&space;&&space;\text{&space;if&space;}&space;eeic>8&space;\end{cases}" title="ESC=\begin{cases} Bad & \text{ if } eeic\leq2 \\ Poor & \text{ if } 2<eeic\leq4 \\ Moderate & \text{ if } 4<eeic\leq6 \\ Good & \text{ if } 6<eeic\leq8 \\ High & \text{ if } eeic>8 \end{cases}" /></a>

```r
## ESC
esc(eeic)
#[1] "Poor"     "Moderate" "Moderate" "Poor"     "Bad"
```


## Graphics

<p align="center">
<img src="https://github.com/salah31416/eeiR/raw/master/inst/figures/classes.png" alt="Classes" width="50%"/>
<img src="https://github.com/salah31416/eeiR/raw/master/inst/figures/hyp.png" alt="Hyperbole" width="80%"/>
<img src="https://github.com/salah31416/eeiR/raw/master/inst/figures/k2.png" alt="Hyperbole 3D" width="60%"/>
</p>

# References

> Orfanidis, S., Panayotidis, P., & Stamatis, N. (2003). An insight to the ecological evaluation index (EEI). Ecological Indicators, 3(1), 27–33. doi:10.1016/s1470-160x(03)00008-6

> Orfanidis, S., Pinna, M., Sabetta, L., Stamatis, N., & Nakou, K. (2008). Variation of structural and functional metrics in macrophyte communities within two habitats of eastern Mediterranean coastal lagoons: natural versus human effects. Aquatic Conservation: Marine and Freshwater Ecosystems, 18(S1), S45–S61. doi:10.1002/aqc.957

> Orfanidis, S., Panayotidis, P., & Ugland, K. (2011). Ecological Evaluation Index Continuous Formula (EEI-c) Application: A Step Forward For Functional Groups, The Formula And Reference Condition Values. Mediterranean Marine Science, 12(1), 199. doi:10.12681/mms.60

> Orfanidis, S., Dencheva, K., Nakou, K., Tsioli, S., Papathanasiou, V., & Rosati, I. (2014). Benthic macrophyte metrics as bioindicators of water quality: towards overcoming typological boundaries and methodological tradition in Mediterranean and Black Seas. Hydrobiologia, 740(1), 61–78. doi:10.1007/s10750-014-1938-x

> Caldeira, A. Q., De Paula, J. C., Reis, R. P., & Giordano, R. G. (2017). Structural and functional losses in macroalgal assemblages in a southeastern Brazilian bay over more than a decade. Ecological Indicators, 75, 242–248. https://doi.org/10.1016/j.ecolind.2016.12.029

> Caldeira, A. Q., & Reis, R. P. (2019). Brazilian macroalgae assemblages analyzed using the ecological evaluation index (EEI-c). Ocean & Coastal Management, 104927. https://doi.org/10.1016/j.ocecoaman.2019.104927
 
