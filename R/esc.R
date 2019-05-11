##-------------------------------------------------------------
## Ecological Status Classes
##-------------------------------------------------------------
esc = function(x)
{
#	Classes defined for EEI
#	eei <= 2	 = bad;
#	2 < eei <= 4 = poor;
#	4 < eei <= 6 = moderate;
#	6 < eei <= 8 = good;
#	eei > 8		 = high

	.esc = function(ic)
	{
		if(ic <= 2) cl = "Bad"
		if(ic > 2 & ic <= 4) cl = "Poor"
		if(ic > 4 & ic <= 6) cl = "Moderate"
		if(ic > 6 & ic <= 8) cl = "Good"
		if(ic > 8) cl = "High"

		return(cl)
	}#end .esc

	cl = sapply(x, .esc)

	return(cl)
}#end esc
