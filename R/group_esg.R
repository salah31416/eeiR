
##-------------------------------------------
## Author  : Izi
## Project : 
## Created : dom 24 mai 2020 18:52:50 -03
## License : MIT
## Updated :
##-------------------------------------------
group_esg = function(data, col_data = "Taxa", ref = NULL, add = NULL)
{
	ID=FG=Taxa_FG=NULL

	nameDATA = parse(text = col_data)

	if(is.data.frame(ref) & is.null(add))
	{
		REF = .ver_add_ref(ref)
		REF = copy(REF)
		on = names(REF)
		setnames(REF, on, c("Taxa_FG", "FG"))
		REF[, Taxa_FG := .firstup(Taxa_FG)]
		REF[, Taxa_FG := .cut_taxa(Taxa_FG, 1)]
	} else {
		REF = readRDS(system.file('esg_ref/FG.rds', package = 'eeiR'))[, list(Taxa_FG, FG)]
	}#end if

	if(!is.null(add))
	{
		ADD = .ver_add_ref(add)
		on = names(ADD)
		setnames(ADD, on, c("Taxa_FG", "FG"))
		ADD[, Taxa_FG := .firstup(Taxa_FG)]
		ADD[, Taxa_FG := .cut_taxa(Taxa_FG, 1)]
		REF = rbindlist(list(REF, ADD))
	}#end if

	REF = unique(REF, by = c("Taxa_FG", "FG"))

	tx = REF[duplicated(REF, by = c("Taxa_FG"))][, Taxa_FG]

	if(length(tx))
	{
		setkey(REF, Taxa_FG)
		msg = "duplicated taxa and different funcinal group:\n"
		dp = REF[tx, paste(Taxa_FG, FG, collapse="\n ")]
		stop(paste(msg, dp), call. = FALSE)
	}#end if

	## copy and convert to data.table
	DATA = copy(setDT(data))

	DATA[, ID := iconv(.cut_taxa(.firstup(eval(nameDATA)), n = 1), to='ASCII//TRANSLIT')]
	REF[, ID := iconv(.cut_taxa(Taxa_FG, n = 1), to='ASCII//TRANSLIT')]

	## join esg_ref and data
	OUT = REF[DATA, on = "ID"]
	OUT[, ID := NULL]

	NR = OUT[is.na(FG)]

	if(nrow(NR))
	{
		NRO = NR[, list(Taxa_FG = eval(nameDATA), FG)]
		setnames(NRO, "Taxa_FG", as.character(nameDATA))
		nd1 = as.character(nameDATA)
		nd2 = "name in data does not match functional group default:"
		msg2 = paste(nd1, nd2, "coerse functional group to <NA>\n")
		ag = NRO[, paste(unique(eval(nameDATA)), collapse = "\n ")]
		warning(paste(msg2, ag), call. = FALSE)
	}#end if

	OUT[, Taxa_FG := NULL]

	return(OUT[])

}#end group_esg

