##-------------------------------------------------------------
## 
##-------------------------------------------------------------
desg = function(dt, 
				cove, 
				group, 
				ia = NULL, 
				ib = NULL, 
				ic = NULL, 
				iia = NULL,
				iib = NULL,
				iic = NULL,
				site = NULL,
				replica = NULL)
{
	ESGI=ESGII=EEIc=EEIeqr=NULL

	EE = copy(dt)
	#cove = substitute(cove)
	#group = substitute(group)
	cove = parse(text=cove)

	ia = substitute(ia)
	ib = substitute(ib)
	ic = substitute(ic)

	iia = substitute(iia)
	iib = substitute(iib)
	iic = substitute(iic)

	D1 = EE[, list(Total = sum(eval(cove))), 
			by = c(group, site, replica)]

	func = paste(paste(c(site, replica), collapse = " + "), 
				"~", paste(group, collapse = " + "))
	
	D2 = dcast(D1, func, value.var = "Total")

	D3 = D2[, list(ESGI = esg(eval(ia), eval(ib), eval(ic), 
						   type = "esgi"),
				ESGII = esg(eval(iia), eval(iib), eval(iic), 
							type = "esgii")),
				by = c(site, replica)]

	D4 = D3[, eeic(ESGI, ESGII), by = c(site, replica)]

	D5 = D4[, list(EEIc = mean(EEIc), EEIeqr = mean(EEIeqr)), 
			by = site][, list(Classes = classes(EEIeqr)), 
			by = c(site, "EEIc", "EEIeqr")]

	return(list("coverage"=D2, "esg"=D3, "eei"=D4, "media"=D5))

}#end desg
