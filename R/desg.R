##-------------------------------------------------------------
## Data Ecological Evaluation Index
##-------------------------------------------------------------
desg = function(dt, 
				cove, 
				group, 
				ia = 0, 
				ib = 0, 
				ic = 0, 
				iia = 0,
				iib = 0,
				iic = 0,
				site = NULL,
				replica = NULL)
{
	ESGI=ESGII=EEI=EQR=ESC=NULL

	EE = copy(dt)

	cove = parse(text=cove)

	ia = parse(text=ia)
	ib = parse(text=ib)
	ic = parse(text=ic)

	iia = parse(text=iia)
	iib = parse(text=iib)
	iic = parse(text=iic)

	D1 = EE[, list(Total = sum(eval(cove))), 
			by = c(group, site, replica)]

	func = paste(paste(c(site, replica), collapse = " + "), 
				"~", paste(group, collapse = " + "))
	
	D2 = dcast(D1, func, value.var = "Total", fill = 0)

	D3 = D2[, list(ESGI = esg(eval(ia), eval(ib), eval(ic), type = "esg1"),
				   ESGII = esg(eval(iia), eval(iib), eval(iic), type = "esg2")),
				by = c(site, replica)]

	D4 = D3[, list(EEI = eeic(ESGI, ESGII)$EEI,
				   EQR = eeic(ESGI, ESGII)$EQR
				   ), by = c(site, replica)][, ESC := esc(EEI)]

	D5 = D4[, list(EEI = mean(EEI), EQR = mean(EQR)), by = site][,
					list(ESC = esc(EEI)), by = c(site, "EEI", "EQR")]

	#return(list("coverage" = D2, "esg" = D3, "eei" = D4, "average" = D5))

	nm = names(D2)[1]
	OUT1 = D2[D3, on=nm]
	OUT = OUT1[D4, on=nm]

	return(list("EEI"=OUT, "average"=D5))

}#end desg
