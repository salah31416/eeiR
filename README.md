# eeiR 

# Installation

	install.packages("devtools")

	devtools::install_github("salah31416/eeiR")

# Tests

	esg1 = c(0, 0, 35, 156.67, 71.33, 56.88, 0, 0, 0, 13.58, 102.85)
	esg2 = c(27.21, 73.97, 7.06, 75.79, 22.87, 22.43, 76.39, 66.6, 68.89)
	eei.eqr = c(.25, .08, .76, .69, .87, .73, 0, 0, 0, .06, .35)

## Classes

	classes(c(.8, .5))
	classes(eei.eqr)

## EEI-c

	eeic(esg1, esg2)
	eeic(82, 18)

## EQR

	eqr(2.35173)

## ESG

	esg(0, 25, 18, type="esg1")
	esg(2.2, 69.85, type="esg2")

## Data ESG

	DD = desg(EEImelt, cove="Coverage", group="Group", 
		  ia = IA, ib = IB, ic = IC, iia = IIA, iib = IIB,
		  site = "Site", replica = "Replica")

	DD$coverage
	DD$esg
	DD$eei
	DD$media	
