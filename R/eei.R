##-------------------------------------------------------------
## Ecological Status Group - ESG
##-------------------------------------------------------------
esg = function(x = 0, y = 0, z = 0, k = NULL, type = c("esg1", "esg2")) {
	type = match.arg(type)

	if(is.null(k) & type == "esg1") k = c(1, 0.8, 0.6) else k = k
	if(is.null(k) & type == "esg2") k = c(0.8, 1, 1) else k = k

	ei = x*k[1] + y*k[2] + z*k[3]

	return(ei)
}#end esg


##-------------------------------------------------------------
##  Hyperbole
##-------------------------------------------------------------
hyp = function(x, y, k) {
	x = x/100
	y = y/100

	#     a  +   bx   +   cx^2   +   dy   +   ey^2   +   fxy
	#     |	     |        |          |        |          |
	h = k[1] + k[2]*x + k[3]*x^2 + k[4]*y + k[5]*y^2 + k[6]*x*y

	h[h > 1] <- 1

	## Ecological Evaluation Indice
	eei = 2 + 8*h

	return(eei)

}#end hyp

##-------------------------------------------------------------
## Ecological Evaluation Index - EEI
##-------------------------------------------------------------
eeic = function(x, y, k = c(a = 0.50339, b = 0.95404, c = -0.20394, d = -0.99804, e = 0.35476, f = -0.10909)) {

    ## EEI
    h = hyp(x, y, k)

    ## data.table
    out = data.table("ESG1" = x, 
					 "ESG2" = y,
                     "EQR" = eqr(h), 
					 "EEI" = h, 
					 "ESC" = esc(h))
    return(out)

}#end eeic

##-------------------------------------------------------------
## Ecological Quality Ratios - EQR
##-------------------------------------------------------------
eqr = function(x) {
	
	x[x > 10] <- 10
	rc = 10
	out = 1.25 * (x/rc) - 0.25

	return(out)
}#end eqr

##-------------------------------------------------------------
## Ecological Status Classes - ESC
##-------------------------------------------------------------
esc = function(x) {

	out = sapply(x,
		function(ic) {
			if(ic <= 2) cl = "Bad"
			if(ic > 2 & ic <= 4) cl = "Poor"
			if(ic > 4 & ic <= 6) cl = "Moderate"
			if(ic > 6 & ic <= 8) cl = "Good"
			if(ic > 8) cl = "High"

			return(cl)
		}#end function
	)#end sapply

	return(out)
}#end esc
