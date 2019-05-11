##-------------------------------------------------------------
## Ecological Evaluation Index
##-------------------------------------------------------------
eeic = function(x, y, k = NULL)
{
    ## Coefficient default
    if(is.null(k))
    {
        k = c(a = 0.4680, b = 1.2088, c = -0.3583,
              d = -1.1289, e = 0.5129, f = -0.1869)
    }#end if

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
	h[h < 0] <- 0

    ## Ecological Evaluation Index
    eei = 2 + 8*(h)

	## Ecological Status Classes
    cl = esc(eei)

    ## data.table
    out = data.table("N" = n, "ESG1" = x*100, "ESG2" = y*100,
                     "EQR" = h, "EEI" = eei, "ESC" = cl)
    return(out)

}#end eeic


