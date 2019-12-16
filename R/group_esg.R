
##-------------------------------------------------------------
## 
##-------------------------------------------------------------
.firstup = function(x) {
	x = tolower(x)
	substr(x, 1, 1) <- toupper(substr(x, 1, 1))
	gsub(" .*", "", x)
}#end .firstup


##-------------------------------------------------------------
## 
##-------------------------------------------------------------
group_esg = function(dta, macroalgae, esg_ref = readRDS(system.file('esg_reference/ESG_BRA.rds', package = 'eeiR')) ) {

	Algae = NULL

	## convert to data.table
	setDT(esg_ref)

	## copy and convert to data.table
	DTA = copy(setDT(dta))

	## macroalgae column name of dta
	nameDTA = parse(text = macroalgae)
	DTA[, Algae := .firstup(eval(nameDTA))]

	## macroalgae column name of esg_ref
	nameREF = names(esg_ref)[1]
	nameREF = parse(text=nameREF)
	esg_ref[, Algae := .firstup(eval(nameREF))]

	## join esg_ref and dta
	OUT = esg_ref[DTA, on = "Algae"]
	OUT[, Algae := NULL]

	#nmc = OUT[, length(which(unlist(lapply(.SD, is.character))))]

	## enter ND "Not Defined"
	nameESG = names(esg_ref)[2]
	nesg1 = parse(text = nameESG)
	OUT[is.na(eval(nesg1)), eval(nameESG) := "ND"]
	OUT[eval(nesg1) == "", eval(nameESG) := "ND"]

	return(OUT[])

}#end group_esg
