
##-------------------------------------------------------------
## 
##-------------------------------------------------------------
desg = function(dta, coverage, group, place, k = NULL) {

	ESGI=ESGII=EEI=EQR=ESC=NULL

	DTA = copy(dta)

	coverage = parse(text=coverage)
	group1 = parse(text=group)

	if(is.null(k)) k = c(a = 0.5, b = 0.95, c = -0.2, d = -1, e = 0.35, f = -0.11)

	DTA = DTA[!(eval(group1) == "ND" | is.na(eval(coverage)))]

	g = dta[, unique(eval(group1))]

	ia  = ifelse("IA"  %in% g, parse(text="IA"),  0)
	ib  = ifelse("IB"  %in% g, parse(text="IB"),  0)
	ic  = ifelse("IC"  %in% g, parse(text="IC"),  0)
	iic = ifelse("IIC" %in% g, parse(text="IIC"), 0)
	iia = ifelse("IIA" %in% g, parse(text="IIA"), 0)
	iib = ifelse("IIB" %in% g, parse(text="IIB"), 0)

	D1 = DTA[, list(Total = sum(eval(coverage))), by = c(group, place)]

	func = paste(paste(c(place), collapse = " + "), "~",
				 paste(group, collapse = " + "))

	D2 = dcast(D1, func, value.var = "Total", fill=0)

	D3 = D2[, list(ESGI = esg(eval(ia), eval(ib), eval(ic), type = "esg1"),
				   ESGII = esg(eval(iia), eval(iib), eval(iib), type = "esg2")
					 ), by = c(place)]

	D4 = D3[, list(EEI = eeic(ESGI, ESGII, k)$EEI,
				   EQR = eeic(ESGI, ESGII, k)$EQR
				   ), by = c(place)]

	D4[, ESC := esc(EEI)]

	D5 = D4[, list(EEI = mean(EEI), EQR = mean(EQR))
	       ][, list(ESC = esc(EEI)), by = c("EEI", "EQR")]

	nm = names(D2)[1]
	OUT1 = D2[D3, on = nm]
	OUT = OUT1[D4, on = nm]

	DT = DTA[OUT, on = place]

	return(list(DT, "EEI"=OUT, "average"=D5))

}#end desg

