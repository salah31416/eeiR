##-------------------------------------------------------------
## Ecological Status Group
##-------------------------------------------------------------
esg = function(a = 0, b = 0, c = 0, 
			   k1 = 1, k2 = 0.8, k3 = 0.6, 
			   w1 = 0.8, w2 = 1, w3 = 1, 
			   type = c("1", "2"))
{
	if(is.null(a)) a = 0
	if(is.null(b)) b = 0
	if(is.null(c)) c = 0

	type <- match.arg(type)
	switch(type,
		   esgi = {ei = a*k1 + b*k2 + c*k3},
		   esgii = {ei = a*w1 + b*w2 + c*w3})

	return(ei)
}#end esg

