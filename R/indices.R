
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
