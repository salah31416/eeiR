##-------------------------------------------------------------
## Ecological Evaluation Index
##-------------------------------------------------------------
eeic = function(x, y,
					 a = 0.4680,
					 b = 1.2088,
					 c = -0.3583,
					 d = -1.1289,
					 e = 0.5129,
					 f = -0.1869)
{

	x = x/100
	y = y/100

	eqr = a + b*x + c*x^2 + d*y + e*y^2 + f*x*y

	eqr[eqr > 1] <- 1

	cl = classes(eqr)

	eeic = 2 + 8*(eqr)

	return(list("EEIeqr"=eqr, "EEIc"=eeic, "classe"=cl))

}#end hyp_model

