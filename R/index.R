
##-------------------------------------------------------------
## 
##-------------------------------------------------------------
index = function(dta, 
				 group,
				 ...,
				 name.col1 = NULL,
				 mean_by = NULL,
				 k = c(a = 0.503, b = 0.954, c = -0.204,
					   d = -0.998, e = 0.355, f = -0.109)
)
{
	ESGI=ESGII=EEIc=NULL

	group1 = parse(text=group)

	DTA = copy(dta)

	g = DTA[, unique(eval(group1))]

	ia  = ifelse("IA"  %in% g, parse(text="IA"),  0)
	ib  = ifelse("IB"  %in% g, parse(text="IB"),  0)
	ic  = ifelse("IC"  %in% g, parse(text="IC"),  0)
	iia = ifelse("IIA" %in% g, parse(text="IIA"), 0)
	iib = ifelse("IIB" %in% g, parse(text="IIB"), 0)
	iic = ifelse("IIC" %in% g, parse(text="IIC"), 0)

	cla = sapply(DTA, is.numeric)
	nc = names(cla[!cla])

	E1 = DTA[, lapply(.SD, sum), .SDcols = !nc, by = group]

	if(is.null(name.col1)) name.col1 = "col1"

	E2 = transpose(E1, keep.names = name.col1, make.names = 1)

	E2[, `:=`(ESGI = esg("1", eval(ia), eval(ib), eval(ic))),
		  by = name.col1]
	E2[, `:=`(ESGII = esg("2", eval(iia), eval(iib), eval(iic))),
	      by = name.col1]
	E2[, `:=`(EEIc = eei(ESGI, ESGII, type = "eeic", k), 
			 EQR = eqr(eei(ESGI, ESGII, type = "eeic", k)))]
	E2[, `:=`(ESC = esc(EEIc))]

	c2 = substitute(...)

	if(!is.null(c2)){

		E2[, eval(c2)]

		if(is.null(mean_by)) mean_by = names(E2)[ncol(E2)]

		MEAN = E2[, list(EEIc = mean(EEIc) ), by = mean_by ]
		MEAN[, `:=`(EQR = eqr(EEIc), ESC = esc(EEIc))]

		return(list(E2[], MEAN[]))
	}#end if

	return(E2[])
}#end index

