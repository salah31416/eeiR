
##-------------------------------------------
## Author  : Izi
## Project : 
## Created : sáb 23 mai 2020 21:46:03 -03
## License : MIT
## Updated :
##-------------------------------------------
index = function(data, id_names=c("FG", "Taxa"), col_fg = "FG", by = NULL, k = NULL, na.rm = FALSE) {

	EEIc=EQR=ESC=IA=IB=IC=IIA=IIB=IIC=ESGI=ESGII=value=NULL

	if(is.null(k)){
		k = c(0.5033936, 0.9540361, -0.2039391, -0.9980407, 0.3547625, -0.1090916)
	} else { k }

	setDT(data)
	D0 = copy(data)

	nr = nrow(D0[is.na(eval(parse(text=col_fg)))])

	if(nr) warning(paste(paste0("'", col_fg, "': ",
			   "Functional group with"), nr, "<NA> ignored values"), call. = FALSE )

	D0 = D0[!is.na(eval(parse(text=col_fg)))]

	idNames = unique(c(names(D0[,id_names, with=F]), by, col_fg))

	D1 = melt(D0, id = idNames)

	by2 = c(col_fg, "variable", by)

	D2 = D1[, list(Soma = sum(value)), by = by2]

	fun = paste(paste0(c("variable", by), collapse = "+"), "~", col_fg)

	D3 = dcast(D2, fun, value.var="Soma")

	gf = c("IA", "IB", "IC", "IIA", "IIB", "IIC")

	GF = gf[!(gf %in% names(D3))]

	D3[, (GF) := 0]

	D3[, ESGI  := esg(IA, IB, IC, type="1")]
	D3[, ESGII := esg(IIA, IIB, IIC, type="2")]
	D3[, EEIc  := eei(ESGI, ESGII, type="eeic", k)]
	D3[, EQR   := eqr(EEIc)]
	D3[, ESC   := esc(EEIc)]
	D3[, (GF)  := NULL]

	if(na.rm) D3 = D3[!is.na(ESC)]

	return(D3[])
}#end index
