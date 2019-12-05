##-------------------------------------------------------------
## Ecological Status Group - ESG
##-------------------------------------------------------------
esg = function(x = 0, y = 0, z = 0, k = NULL, type = c("esg1", "esg2"))
{
	type = match.arg(type)

	if(is.null(k) & type == "esg1") k = c(1, 0.8, 0.6) else k = k
	if(is.null(k) & type == "esg2") k = c(0.8, 1, 1) else k = k

	ei = x*k[1] + y*k[2] + z*k[3]

	return(ei)
}#end esg


##-------------------------------------------------------------
## Ecological Evaluation Index - EEI
##-------------------------------------------------------------
eeic = function(x, y, k = c(a = 0.4680, b = 1.2088, c = -0.3583, d = -1.1289, e = 0.5129, f = -0.1869))
{
    ## length
    n = 1:max(length(x), length(y))

    ## percent
    x = x/100
    y = y/100

    ## hyperbole: Ecological Quality Ratio
    ##    a  +   b*x  +   c*x^2  +   d*y  +   e*y^2  +   f*x*y
    ##    |      |        |          |        |          |
    h = k[1] + k[2]*x + k[3]*x^2 + k[4]*y + k[5]*y^2 + k[6]*x*y

    ## limit value h
    h[h > 1] <- 1
	#h[h < 0] <- 0

    ## Ecological Evaluation Index
    eei = 2 + 8*h

	## Ecological Status Classes
    cl = esc(eei)

    ## data.table
    out = data.table("N" = n, "ESG1" = x*100, "ESG2" = y*100,
                     "EQR" = h, "EEI" = eei, "ESC" = cl)
    return(out)

}#end eeic

##-------------------------------------------------------------
## Ecological Quality Ratios - EQR
##-------------------------------------------------------------
eqr = function(x, rc = 10) 1.25*(x/rc) - 0.25

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
