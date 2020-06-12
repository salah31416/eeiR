
##-------------------------------------------
## Author  : Izi
## Project : 
## Created : dom 17 mai 2020 14:13:29 -03
## License : MIT
## Updated :
##-------------------------------------------
group_index = function(data, id_names = c("Taxa"), col_data = "Taxa", by = NULL, ref = NULL, add = NULL, k = NULL, na.rm = FALSE){

	DTA = copy(data)

	idNames = unique(c(names(DTA[, id_names, with=F]), "FG", col_data))

	GE = group_esg(DTA, col_data, ref, add)

	out = index(GE, id_names = idNames, col_fg = "FG", by, k, na.rm)
	
	return(out)
}#end group_index
