
# eeiR - Ecological Evaluation Index

<p align="center">
<img src="https://github.com/salah31416/eeiR/raw/master/inst/figures/macro.png" 
alt="Classes" width="35%"/>
</p>

## Contents

* [Installation](#installation)
* [Tests](#tests)
* [Ecological Status Class - ESC](#ecological-status-class)
* [Ecological Evaluation Index - EEI-c](#ecological-evaluation-index)
* [Ecological Quality Ratio - EQR](#ecological-quality-ratio)
* [Ecological Status Group - ESG](#ecological-status-group)
* [Data ESG](#data-esg)
* [Graphics](#graphics)


# Installation

```r
install.packages("devtools")

devtools::install_github("salah31416/eeiR")
```

# Tests

```r
esg1 = c(0, 0, 35, 156.67, 71.33, 56.88, 0, 0, 0, 13.58, 102.85)
esg2 = c(27.21, 73.97, 7.06, 75.79, 22.87, 22.43, 76.39, 66.6, 68.89)
eq = c(.25, .08, .76, .69, .87, .73, 0, 0, 0, .06, .35)
```

## Ecological Status Class

```r
esc(c(.8, .5))
esc(eq)
```

## Ecological Evaluation Index

```r
eeic(esg1, esg2)
eeic(82, 18)
```

## Ecological Quality Ratio

```r
eqr(2.35173)
```

## Ecological Status Group

```r
esg(0, 25, 18, type = "esg1")
esg(2.2, 69.85, type = "esg2")
```

## Data ESG

```r
DD = desg(EEImelt, cove="Coverage", group="Group", 
		  ia = IA, ib = IB, ic = IC, iia = IIA, iib = IIB,
		  site = "Site", replica = "Replica")

DD$coverage
DD$esg
DD$eei
DD$average
```
## Graphics

<p align="center">
<img src="https://github.com/salah31416/eeiR/raw/master/inst/figures/classes.png" alt="Classes" width="45%"/>
<img src="https://github.com/salah31416/eeiR/raw/master/inst/figures/hyp.png" alt="Hyperbole" width="50%"/>
<img src="https://github.com/salah31416/eeiR/blob/master/inst/figures/k2.png" alt="Hyperbole 3D" width="50%"/>
</p>
