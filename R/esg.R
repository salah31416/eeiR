##-------------------------------------------------------------
## Ecological Status Group
##-------------------------------------------------------------
esg = function(a = 0, b = 0, c = 0, type = c("esgi", "esgii"))
{
	if(is.null(a)) a = 0
	if(is.null(b)) b = 0
	if(is.null(c)) c = 0

	type <- match.arg(type)
	switch(type,
		   esgi = {ei = a + b*0.8 + c*0.6},
		   esgii = {ei = a*0.8 + b + c})

	return(ei)
}#end esg

