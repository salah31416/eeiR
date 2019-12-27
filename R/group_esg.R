
##-------------------------------------------------------------
##
##-------------------------------------------------------------
group_esg = function(dta,
					 NameTaxaDTA = "Taxa",
					 NameTaxaREF = "Taxa",
					 NameGroupESG = "Group",
					 ref = c("gbra", "sgre", "ggre"),
					 genus = TRUE)
{
	ID=ESGg=ESGs=Taxa=NULL

	nameREF = parse(text = NameTaxaREF)
	nameDTA = parse(text = NameTaxaDTA)

	if(is.data.frame(ref)) {
		REF = copy(setDT(ref))
		REF[, eval(NameTaxaREF) := .firstup(eval(nameREF))]
	} else {
		ref = match.arg(ref)

		bra = 'esg_ref/ESG_BRA.rds'
		gre = 'esg_ref/ESG_GRE.rds'

		switch(ref,
					 "gbra" = {
			REF = readRDS(system.file(bra, package = 'eeiR'))[,list(Taxa,ESGg)]
			NameGroupESG = "ESGg" },
					 "sgre" = {
			REF = readRDS(system.file(gre, package = 'eeiR'))[,list(Taxa,ESGs)]
			NameGroupESG = "ESGs"},
					 "ggre" = {
			REF = readRDS(system.file(gre, package = 'eeiR'))[,list(Taxa,ESGg)]
			NameGroupESG = "ESGg"}
		)#end switch

		NameTaxaREF = "Taxa"
		nameREF = parse(text = NameTaxaREF)
	}#end if

	## copy and convert to data.table
	DTA = copy(setDT(dta))
	DTA[, eval(NameTaxaDTA) := .firstup(eval(nameDTA))]

	## macroalgae column name of dta
	if(genus) {
		DTA[, ID := iconv(.cut_taxa(eval(nameDTA), n = 1), to='ASCII//TRANSLIT')]
		REF[, ID := iconv(.cut_taxa(eval(nameREF), n = 1), to='ASCII//TRANSLIT')]
		REF = REF[, list(ID = unique(ID)), by = NameGroupESG]
	} else {
		DTA[, ID := iconv(.firstup(paste(.cut_taxa(eval(nameDTA), n = 1),
								  .cut_taxa(eval(nameDTA)))), to='ASCII//TRANSLIT')]
		## macroalgae column name of esg reference
		REF[, ID := iconv(eval(nameREF), to='ASCII//TRANSLIT')]
		REF = REF[, list(ID = unique(ID)), by = NameGroupESG]
	}#end if

	## join esg_ref and dta
	OUT = REF[DTA, on = "ID"]
	OUT[, ID := NULL]

	return(OUT[])
}#end group_esg
