#######################################################
## Projeto:
##
## Data: 
## Hora: 
##
## ## Autor: izi
##
## Encoding: UTF-8
#######################################################

##-------------------------------------------------------------
.firstup = function(x)
{
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  gsub(" .*", "", x)
}#end function

.epithet = function(x) gsub(".* ", "", x) #end function
.genus = function(x) gsub(" .*", "", x) #end function
##-------------------------------------------------------------

group_esg = function(dta, 
					 macroalgae, 
					 esg_ref = readRDS(system.file('esg_reference/ESG_BRA.rds', package = 'eeiR'))
){

	Algae=NULL

	setDT(esg_ref)

	DTA = copy(dta)

	nameDTA = parse(text=macroalgae)
	DTA[, Algae := .firstup(eval(nameDTA))]

	nameREF = names(esg_ref)[1]
	nameREF = parse(text=nameREF)
	esg_ref[, Algae := .firstup(eval(nameREF))]

	OUT = esg_ref[DTA, on="Algae"]
	OUT[, Algae:=NULL][]

	nmc = OUT[, length(which(unlist(lapply(.SD, is.character))))]

#	for(i in 1:nmc)
#	{
#		nesg = names(OUT)[i]
#		nesg1 = parse(text=nesg)
#		OUT[is.na(eval(nesg1)), eval(nesg):="ND"]
#		OUT[eval(nesg1)=="", eval(nesg):="ND"][]
#	}#end for

	nameESG = names(esg_ref)[2]
	nesg1 = parse(text=nameESG)
	OUT[is.na(eval(nesg1)), eval(nameESG):="ND"]
	OUT[eval(nesg1)=="", eval(nameESG):="ND"][]


	return(OUT)

}#end function
