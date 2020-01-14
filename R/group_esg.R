
##-------------------------------------------------------------
##
##-------------------------------------------------------------
group_esg = function(data,
					 NameTaxaDATA = "Taxa",
					 NameTaxaREF = "Taxa",
					 NameGroupESG = "Group",
					 ref = c("gbra", "sgre", "ggre"),
					 genus = TRUE)
{
	ID=ESGg=ESGs=Taxa=NULL

	nameREF = parse(text = NameTaxaREF)
	nameDATA = parse(text = NameTaxaDATA)

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
	DATA = copy(setDT(data))
	DATA[, eval(NameTaxaDATA) := .firstup(eval(nameDATA))]

	## macroalgae column name of data
	if(genus) {
		DATA[, ID := iconv(.cut_taxa(eval(nameDATA), n = 1), to='ASCII//TRANSLIT')]
		REF[, ID := iconv(.cut_taxa(eval(nameREF), n = 1), to='ASCII//TRANSLIT')]
		REF = REF[, list(ID = unique(ID)), by = NameGroupESG]
	} else {
		DATA[, ID := iconv(.firstup(paste(.cut_taxa(eval(nameDATA), n = 1),
								  .cut_taxa(eval(nameDATA)))), to='ASCII//TRANSLIT')]
		## macroalgae column name of esg reference
		REF[, ID := iconv(eval(nameREF), to='ASCII//TRANSLIT')]
		REF = REF[, list(ID = unique(ID)), by = NameGroupESG]
	}#end if

	## join esg_ref and data
	OUT = REF[DATA, on = "ID"]
	OUT[, ID := NULL]

	nameESG = parse(text = NameGroupESG)

	NR = OUT[is.na(eval(nameESG))]

	if(nrow(NR)) {
		print(NR)
		stop("\nTaxa name in data does not match reference group Taxa name\nEnter an external ESG group\nExample: ref = esg_group.csv", call. = FALSE)
		return(NULL)
	}#end if

	return(OUT[])
}#end group_esg

