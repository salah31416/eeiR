
##-------------------------------------------------------------
##  Hyperbole
##-------------------------------------------------------------
fun_hyp = function(x, y, k) {
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
