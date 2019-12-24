
##-------------------------------------------------------------
## Ecological Evaluation Index - EEI
##-------------------------------------------------------------
eeic = function(x, y, k = c(a = 0.50339, b = 0.95404, c = -0.20394, d = -0.99804, e = 0.35476, f = -0.10909)) {

    ## EEI
    h = fun_hyp(x, y, k)

    ## data.table
    out = data.table("ESG1" = x, 
					 "ESG2" = y,
                     "EQR" = eqr(h), 
					 "EEI" = h, 
					 "ESC" = esc(h))
    return(out)

}#end eeic
