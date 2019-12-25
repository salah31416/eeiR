
##-------------------------------------------------------------
##
##-------------------------------------------------------------
group_esg = function(dta,
					 ColNameDTA = "Taxa",
					 ColNameREF = "Taxa",
					 ColNameESG = "Group",
					 ref = c("brazil", "greece"),
					 genus = TRUE) 
{
	ID = NULL

	nameREF = parse(text = ColNameREF)
	nameDTA = parse(text = ColNameDTA)

	if(is.data.frame(ref)) {
		REF = copy(setDT(ref))
		REF[, eval(ColNameREF) := .firstup(eval(nameREF))]
	} else {
		ref = match.arg(ref)

		bra = 'esg_ref/ESG_BRA.rds'
		gre = 'esg_ref/ESG_GRE.rds'

		REF = switch(ref,
					 "brazil" =
				readRDS(system.file(bra, package = 'eeiR')),
					 "greece" =
				readRDS(system.file(gre, package = 'eeiR'))
		)#end switch
	}#end if

	## copy and convert to data.table
	DTA = copy(setDT(dta))
	DTA[, eval(ColNameDTA) := .firstup(eval(nameDTA))]

	## macroalgae column name of dta
	if(genus) {
		DTA[, ID := .cut_taxa(eval(nameDTA), n = 1)]
		REF[, ID := .cut_taxa(eval(nameREF), n = 1)]
		REF = REF[, list(ID = unique(ID)), by = ColNameESG]
	} else {
		DTA[, ID := .firstup(paste(.cut_taxa(eval(nameDTA), n = 1),
								  .cut_taxa(eval(nameDTA))))]
		## macroalgae column name of esg reference
		REF[, ID := eval(nameREF)]
		REF = REF[, list(ID = unique(ID)), by = ColNameESG]
	}#end if

	## join esg_ref and dta
	OUT = REF[DTA, on = "ID"]
	OUT[, ID := NULL]

	## enter ND "Not Defined"
	nesg1 = parse(text = ColNameESG)
	OUT[is.na(eval(nesg1)), eval(ColNameESG) := "ND"]
	OUT[eval(nesg1) == "", eval(ColNameESG) := "ND"]

	return(OUT[])
}#end group_esg

##-------------------------------------------------------------
## 
##-------------------------------------------------------------
desg = function(dta,
				coverage, 
				group, place,
				k = c(a = 0.503, b = 0.954, c = -0.204, 
					  d = -0.998, e = 0.355, f = -0.109)) 
{
	ESGI=ESGII=EEIc=EEI=D3=EQR=ESC=NULL

	DTA = copy(dta)

	coverage = parse(text=coverage)
	group1 = parse(text=group)

	DTA = DTA[!(eval(group1) == "ND" | is.na(eval(coverage)))]

	g = dta[, unique(eval(group1))]

	ia  = ifelse("IA"  %in% g, parse(text="IA"),  0)
	ib  = ifelse("IB"  %in% g, parse(text="IB"),  0)
	ic  = ifelse("IC"  %in% g, parse(text="IC"),  0)
	iic = ifelse("IIC" %in% g, parse(text="IIC"), 0)
	iia = ifelse("IIA" %in% g, parse(text="IIA"), 0)
	iib = ifelse("IIB" %in% g, parse(text="IIB"), 0)

	D1 = DTA[, list(Total = sum(eval(coverage))), 
			 by = c(group, place)]

	func = paste(paste(c(place), collapse = " + "), "~",
				 paste(group, collapse = " + "))

	D2 = dcast(D1, func, value.var = "Total", fill=0)

	D3 = D2[, list(ESGI = esg(eval(ia), eval(ib), eval(ic), type = "esg1"),
			  ESGII = esg(eval(iia), eval(iib), eval(iib), type = "esg2")
			 ), by = c(place)]

	D4 = D3[, list(EEIc = eeic(ESGI, ESGII, k),
				   EQR = eqr(eeic(ESGI, ESGII, k))
				  ), by = place]

	D4[, ESC := esc(EEIc)]

	D5 = D4[, list(EEIc = mean(EEIc), EQR = mean(EQR))
	       ][, list(ESC = esc(EEIc)), by = c("EEIc", "EQR")]

	nm = names(D2)[1]

	OUT1 = D2[D3, on = nm]
	OUT = OUT1[D4, on = nm]

	DT = DTA[OUT, on = place]

	return(list(DT, "EEIc"=OUT, "average"=D5))

}#end desg

