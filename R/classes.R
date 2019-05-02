##-------------------------------------------------------------
## Ecological Status Classes
##
## 0-0.2 = bad
## 0.2-0.4 = poor
## 0.4-0.6 = moderate
## 0.6-0.8 = good
## 0.8-1.0 = high
##-------------------------------------------------------------
classes = function(eqr)
{
	.classes = function(ic)
	{
		if(ic < .2) cl = "bad"
		if(ic >= .2 & ic < .4) cl = "poor"
		if(ic >= .4 & ic < .6) cl = "moderate"
		if(ic >= .6 & ic < .8) cl = "good"
		if(ic >= .8) cl = "high"

		return(cl)
	}#end .classes

	cl = sapply(eqr, .classes)

	return(cl)
}#end classes
