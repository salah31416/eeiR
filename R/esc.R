##-------------------------------------------------------------
## Ecological Status Classes
##
## 0-0.2 = bad
## 0.2-0.4 = poor
## 0.4-0.6 = moderate
## 0.6-0.8 = good
## 0.8-1.0 = high
##-------------------------------------------------------------
esc = function(x)
{
	.esc = function(ic)
	{
		if(ic <= .2) cl = "Bad"
		if(ic > .2 & ic <= .4) cl = "Poor"
		if(ic > .4 & ic <= .6) cl = "Moderate"
		if(ic > .6 & ic <= .8) cl = "Good"
		if(ic > .8) cl = "High"

		return(cl)
	}#end .esc

	cl = sapply(x, .esc)

	return(cl)
}#end esc
