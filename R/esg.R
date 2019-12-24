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
