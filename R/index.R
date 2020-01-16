
##-------------------------------------------------------------
## 
##-------------------------------------------------------------
index = function(...,data,
				 group,
				 name.col1 = NULL,
				 mean_by = NULL,
				 k = c(a = 0.503, b = 0.954, c = -0.204,
					   d = -0.998, e = 0.355, f = -0.109) )
{
	ESGI=ESGII=EEIc=NULL

	group1 = parse(text=group)

	DTA = copy(data)

	g = DTA[, unique(eval(group1))]

	ia  = ifelse("IA"  %in% g, parse(text="IA"),  0)
	ib  = ifelse("IB"  %in% g, parse(text="IB"),  0)
	ic  = ifelse("IC"  %in% g, parse(text="IC"),  0)
	iia = ifelse("IIA" %in% g, parse(text="IIA"), 0)
	iib = ifelse("IIB" %in% g, parse(text="IIB"), 0)
	iic = ifelse("IIC" %in% g, parse(text="IIC"), 0)

	cla = sapply(DTA, is.numeric)
	nc = names(cla[!cla])

	gm1 = unique(c(group, mean_by))

	gm = gm1[(gm1%in%nc)]

	by2 = gm1[!(gm1%in%nc)]

	mby = length(intersect(mean_by, nc))

	if(!mby)mean_by=NULL

	mean_by = mean_by[!mean_by%in%by2]

	E1 = DTA[, lapply(.SD, sum), .SDcols = !nc, by = gm] 

	if(is.null(name.col1)) name.col1 = "site"

	EM = melt(E1, id.vars = gm, variable.name=name.col1)

	if(is.null(mean_by)) aa = paste(name.col1, "~", group) else
		aa = paste(name.col1, "+", paste(mean_by, collapse = " + "), "~", group)

	E2 = dcast(EM, aa)

	#E2 = data.table::transpose(E1, keep.names = name.col1, make.names = 1)

	E2 = E2[!(eval(ia) == 0 & eval(ib) == 0 & eval(ic) == 0 & 
			  eval(iia) == 0 & eval(iib) == 0 & eval(iic) == 0)]

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
	}#end  if

	if(is.null(mean_by) & !length(by2)) return(E2[])

	MEAN = E2[, list(EEIc = mean(EEIc) ), by = c(by2, mean_by) ]
	MEAN[, `:=`(EQR = eqr(EEIc), ESC = esc(EEIc))]

	return(list(E2, MEAN))

}#end index

