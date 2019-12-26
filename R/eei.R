
##-------------------------------------------------------------
## Ecological Quality Ratios - EQR
##-------------------------------------------------------------
eqr = function(x) 
{
	rc = 10
	out = 1.25 * (x/rc) - 0.25

	return(out)
}#end eqr

##-------------------------------------------------------------
## Ecological Status Classes - ESC
##-------------------------------------------------------------
esc = function(x, FUN = NULL)
{
	if(is.null(FUN)) {
		FUN = function(ic) {
			if(ic <= 2) cl = "Bad"
			if(ic > 2 & ic <= 4) cl = "Poor"
			if(ic > 4 & ic <= 6) cl = "Moderate"
			if(ic > 6 & ic <= 8) cl = "Good"
			if(ic > 8) cl = "High"
			return(cl)
		}#end FUN
	}#end if

	return(sapply(x, FUN))
}#end esc

##-------------------------------------------------------------
## Ecological Status Group - ESG
##-------------------------------------------------------------
esg = function(ia = 0, ib = 0, ic = 0, k = NULL, type = c("esg1", "esg2")) 
{
	type = match.arg(type)

	if(is.null(k) & type == "esg1") k = c(1, 0.8, 0.6)
	if(is.null(k) & type == "esg2") k = c(0.8, 1, 0)

	out = ia * k[1] + ib * k[2] + ic * k[3]

	return(out)
}#end esg

##-------------------------------------------------------------
## Ecological Evaluation Index - EEI
##-------------------------------------------------------------
eei_hyp = function(x, y, k = c(a = 0.503, b = 0.954, c = -0.204, d = -0.998, e = 0.355, f = -0.109)) 
{
	x = x/100
	y = y/100

	#     a  +   bx   +   cx^2   +   dy   +   ey^2   +   fxy
	#     |	     |        |          |        |          |
	h = k[1] + k[2]*x + k[3]*x^2 + k[4]*y + k[5]*y^2 + k[6]*x*y

	h[h > 1] <- 1

	## Ecological Evaluation Index
	eei = 2 + 8 * h

	return(eei)
}#end hyp

##-------------------------------------------------------------
## Ecological Evaluation Index Coverage - EEIc
##-------------------------------------------------------------
eeic = function(x, y, k = c(a = 0.503, b = 0.954, c = -0.204, d = -0.998, e = 0.355, f = -0.110)) 
{
    ## EEI
    h = eei_hyp(x, y, k)

	## eeic
	h[h < 2] <- 2
    
    return(h)
}#end eeic

##-------------------------------------------------------------
## Generate Sequence Number - gsn
##-------------------------------------------------------------
.gsn = function(RV = TRUE, from = 0, to = 100, by = .5) 
{
	ESC=V=R=z=D3=EEIc=NULL

	x = y = seq(from, to, by)
	sq = expand.grid(x = x, y = y)
	SEQ = data.table(sq)


	if(isTRUE(RV) | is.data.table(RV))
	{
		if(isTRUE(RV))
		{
			RV = data.table(
			  R = c(
				"x <= 30 & y > 60",
				"x <= 30 & (y > 30 & y <= 60)",
				"(x > 30 & x <= 60) & y > 60",
				"x > 60 & y > 60",
				"(x > 30 & x <= 60) & (y > 30 & y <= 60)",
				"x <= 30 & y <= 30",
				"x > 60 & (y > 30 & y <= 60)",
				"(x > 30 & x <= 60) & y <= 30",
				"x > 60 & y <= 30"),
			  V = c(2, 4, 4, 6, 6, 6, 8, 8, 10 ),
			  ESC = c("Bad", "Poor", "Poor", "Moderate", "Moderate",
					  "Moderate", "Good", "Good", "High") )
		}#end if

		message("Classification of intervals")
		cat(paste(ESC, V, R), sep="\n")

		for(i in 1:nrow(RV))
		{
			rela = parse(text=RV[i,1])
			SEQ[eval(rela), z := RV[i,2]]

#			z0 = SEQ[eval(rela), unique(z)]
#			w = paste(paste0(" ", z0," ", RV[i,3], ":"),
#					  RV[i,1], sep="  ")
#			message(w)
		}#end for
	}#end if

	return(SEQ[])
}#end generate_seq

