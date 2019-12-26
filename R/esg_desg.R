
##-------------------------------------------------------------
##
##-------------------------------------------------------------
group_esg = function(dta,
					 ColNameDTA = "Taxa",
					 ColNameREF = "Taxa",
					 ColNameESG = "Group",
					 ref = c("gbra", "sgre", "ggre"),
					 genus = TRUE) 
{
	ID=ESGg=ESGs=Taxa=NULL

	nameREF = parse(text = ColNameREF)
	nameDTA = parse(text = ColNameDTA)

	if(is.data.frame(ref)) {
		REF = copy(setDT(ref))
		REF[, eval(ColNameREF) := .firstup(eval(nameREF))]
	} else {
		ref = match.arg(ref)

		bra = 'esg_ref/ESG_BRA.csv'
		gre = 'esg_ref/ESG_GRE.csv'


		REF = switch(ref,
					 "gbra" =
		  fread(system.file(bra, package = 'eeiR'))[,list(Taxa,ESGg)],
					 "sgre" =
		  fread(system.file(gre, package = 'eeiR'))[,list(Taxa,ESGs)],
					 "ggre" =
		  fread(system.file(gre, package = 'eeiR'))[,list(Taxa,ESGg)]
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

	## UG (undefined group)
	nesg1 = parse(text = ColNameESG)
	OUT[is.na(eval(nesg1)), eval(ColNameESG) := "UG"]
	OUT[eval(nesg1) == "", eval(ColNameESG) := "UG"]

	return(OUT[])
}#end group_esg

##-------------------------------------------------------------
## 
##-------------------------------------------------------------
desg = function(dta,
				coverage,
				group,
				by,
				mean_by = NULL,
				k = c(a = 0.503, b = 0.954, c = -0.204,
					  d = -0.998, e = 0.355, f = -0.109))
{
	ESGI=ESGII=EEIc=EEI=D3=EQR=ESC=NULL

	DTA = copy(dta)

	coverage = parse(text=coverage)
	group1 = parse(text=group)

	## remove NA and UG (undefined group)
	DTA = DTA[!(eval(group1) == "UG" | is.na(eval(coverage)))]

	g = dta[, unique(eval(group1))]

	ia  = ifelse("IA"  %in% g, parse(text="IA"),  0)
	ib  = ifelse("IB"  %in% g, parse(text="IB"),  0)
	ic  = ifelse("IC"  %in% g, parse(text="IC"),  0)
	iic = ifelse("IIC" %in% g, parse(text="IIC"), 0)
	iia = ifelse("IIA" %in% g, parse(text="IIA"), 0)
	iib = ifelse("IIB" %in% g, parse(text="IIB"), 0)

	D1 = DTA[, list(Total = sum(eval(coverage))), by = c(group, by)]

	func = paste(paste(by, collapse = " + "), "~",
				 paste(group, collapse = " + "))

	D2 = dcast(D1, func, value.var = "Total", fill=0)

	D3 = D2[, list(ESGI = esg(eval(ia), eval(ib), eval(ic), type = "esg1"),
			  ESGII = esg(eval(iia), eval(iib), eval(iib), type = "esg2")
			 ), by = by]

	D4 = D3[, list(EEIc = eeic(ESGI, ESGII, k),
				   EQR = eqr(eeic(ESGI, ESGII, k))
				  ), by = by][, ESC := esc(EEIc)]

	if(!is.null(mean_by))
	{
		if(!length(intersect(by, mean_by))) {
			stop(paste0("'mean_by' (", mean_by, 
						") must be contained in 'by' (", 
						paste(by, collapse=", "), ")"), 
				 call. = FALSE)
		}#en if
	}#end if

	MEAN_by = D4[, list(EEIc = mean(EEIc), EQR = mean(EQR)), by = mean_by
			][, list(ESC = esc(EEIc)), by = c(mean_by, "EEIc", "EQR")]

	OUT = D2[D3, on = by][D4, on = by]

	return(list("Index" = OUT, "Average" = MEAN_by))
}#end desg
