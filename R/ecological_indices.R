
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
			if(ic > 2 & ic <= 4) cl = "Low"
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
esg = function(type = c("1", "2"), a = 0, b = 0, c = 0, k = NULL)
{
	type = match.arg(type)

	if(is.null(k) & type == "1") k = c(1, 0.8, 0.6)
	if(is.null(k) & type == "2") k = c(0.8, 1, 1)

	out = a * k[1] + b * k[2] + c * k[3]

	return(out)
}#end esg



##-------------------------------------------------------------
## Ecological Evaluation Index - EEI
##-------------------------------------------------------------
eei = function(x, y, type = c("eeic", "esi", "hyp"), k = c(a = 0.503, b = 0.954, c = -0.204, d = -0.998, e = 0.355, f = -0.109))
{
	k = unname(k)

	type = match.arg(type)

	x = x/100
	y = y/100

	#     a  +   bx   +   cx^2   +   dy   +   ey^2   +   fxy
	#     |	     |        |          |        |          |
	hyp = k[1] + k[2]*x + k[3]*x^2 + k[4]*y + k[5]*y^2 + k[6]*x*y

	switch(type,
		   "eeic" = {
			   hyp[hyp > 1] <- 1
			   hyp = 2 + 8 * hyp
			   hyp[hyp < 2] <- 2
		   },
		   "esi" = {
			   hyp[hyp > 1] <- 1
			   hyp = 2 + 8 * hyp
		   },
		   "hyp" = { hyp }
	)#end switch

	return(hyp)
}#end eei
