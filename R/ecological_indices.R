
##-------------------------------------------------------------
## Ecological Quality Ratios - EQR
##-------------------------------------------------------------
eqr = function(x) 
{
	rc = 10
	out = 1.25 * (x/rc) - 0.25
	out[out > 1] <- 1

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
esg = function(a = 0, b = 0, c = 0, type = c("esg1", "esg2"), k = NULL)
{
	type = match.arg(type)

	if(is.null(k) & type == "esg1") k = c(1, 0.8, 0.6)
	if(is.null(k) & type == "esg2") k = c(0.8, 1, 1)

	out = a * k[1] + b * k[2] + c * k[3]

	return(out)
}#end esg


##-------------------------------------------------------------
## Ecological Evaluation Index - EEI
##-------------------------------------------------------------
eei = function(x, y, type = c("esi", "hyp", "eeic"), k = c(0.503, 0.954, -0.204, -0.998, 0.355, -0.109))
{
	k = unname(k)

	type = match.arg(type)

	x = x/100
	y = y/100

	#     a  +   bx   +   cx^2   +   dy   +   ey^2   +   fxy
	#     |	     |        |          |        |          |
	h = k[1] + k[2]*x + k[3]*x^2 + k[4]*y + k[5]*y^2 + k[6]*x*y

	switch(type,
		   "esi" = {h},
		   "hyp" = {
			   h[h > 1] <- 1
			   h = 2 + 8 * h
			   },
		   "eeic" = {
			   h[h > 1] <- 1
			   h = 2 + 8 * h
			   h[h < 2] <- 2
			   }
		   )#end switch

	return(h)
}#end eei