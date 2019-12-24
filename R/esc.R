
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
